"
I am a REST API service with some simple support for accounts.

I assume the following tables are present in the SQLite database:
```
CREATE TABLE IF NOT EXISTS accounts (
	id TEXT NOT NULL PRIMARY KEY,	/* Never shared with user(s) */
	createdAt INTEGER NOT NULL,
	updatedAt INTEGER,
	deletedAt INTEGER,
	activatedAt INTEGER,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL,		/* Hash of course */
	settings TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS activations (
	id TEXT NOT NULL PRIMARY KEY,
	email TEXT NOT NULL,
	token TEXT NOT NULL,
	expiresAt INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS sessions (
	id TEXT NOT NULL PRIMARY KEY,
	createdAt INTEGER NOT NULL,
	updatedAt INTEGER,
	accountId TEXT NOT NULL,
	accessToken TEXT NOT NULL UNIQUE,
	expires TEXT NOT NULL		/* 'usage', 'day' or 'never' */
);
```
"
Class {
	#name : #CynLocalAccountRestApiService,
	#superclass : #CynBaseRestApiService,
	#category : #'CodeParadise-Canyon-Data-Service'
}

{ #category : #testing }
CynLocalAccountRestApiService class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> activateAccount: anActivateAccount [

	"Activate the specified Account.

	Implementation:
	If there is not activation for the specified Account, provide the same error
	as in #activateAccount:response: to prevent wrong-doer from concluding account
	exists for given email address."

	| now activations |

	now := CpJavaScriptDate timestampNow.

	activations := modelDatabase
		selectMany: #getActivations
		statement: 'SELECT id, expiresAt FROM activations WHERE token=:token AND email=:email ORDER BY expiresAt DESC'
		bind: {
			#token -> anActivateAccount token.
			#email -> anActivateAccount email } asDictionary.

	"No match for token and email"
	activations ifEmpty: [ ^ self errorTokenAndEmailNotFound ].

	"Token already expired (okay to provide answer, since token is secret value anyway and can't be guessed)"
	(activations first at: #expiresAt) < now
		ifTrue: [ ^ self errorTokenExpired ].

	"Mark account as activated"
	modelDatabase
		performOne: #activateAccount
		statement: 'UPDATE accounts SET activatedAt=:now, updatedAt=:now WHERE email=:email AND activatedAt IS NULL'
		bind: {
			#now -> now.
			#email -> anActivateAccount email } asDictionary.

	"Remove activations (no longer needed)"
	modelDatabase
		performMulti: #removeActivations
		statement: 'DELETE FROM activations WHERE email=:email'
		bind: {
			#email -> anActivateAccount email } asDictionary
]

{ #category : #API }
CynLocalAccountRestApiService >> activateAccount: aRestRequest response: aRestResponse [

	"Activate Account within Accounts collection"

	<post: '/api/accounts?action=activate'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynActivateAccount fromBody: body.

	(self isNonActivatedAccount: account)
		ifFalse: [ ^ self errorTokenAndEmailNotFound ].

	self activateAccount: account.

	self sendEmptyResponse: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> activationTokenMailMessageWith: aString [

	^ self newMailMessage
		subject: 'Activation code' ;
		text: ('Your activation code is: {1}' format: { aString }) ;
		html: ('Your <i>activation code</i> is <code>{1}</code>' format: { aString }) ;
		yourself
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> addActivationTokenToAccount: anAccount [

	"Send new activation token to existing account, update the provided
	password. In theory a wrong-doer could get in between registration
	and activation, but that will not result in access to the account.
	At worst the account owner needs to reset his/her password."

	| passwordHash |

	"Update password with the new value given (to prevent name clash use
	statement identifier: #insertAccountPassword"
	passwordHash := self createPasswordHashFrom: anAccount password.
	modelDatabase
		performOne: #insertAccountPassword
		statement: 'UPDATE accounts SET password=:password, updatedAt=:now WHERE email=:email'
		bind: {
			#email -> anAccount email.
			#password -> passwordHash.
			#now -> CpJavaScriptDate timestampNow } asDictionary.

	self createActivationTokenForAccount: anAccount
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> createAccount: account [

	| id passwordHash |

	"Try to create new Account (might fail if it exists, but we catch that)"
	id := self newId.
	passwordHash := self createPasswordHashFrom: account password.

	[
		modelDatabase
			performOne: #insertAccount
			statement: 'INSERT INTO accounts (id, createdAt, email, password, settings) VALUES(:id, :now, :email, :password, :settings)'
			bind: {
				#id -> id.
				#now -> CpJavaScriptDate timestampNow.
				#email -> account email.
				#password -> passwordHash.
				#settings -> '{}' } asDictionary
	] on: CynDatabaseUniqueConstraintViolation do: [
		"Account exists and is already activated (otherwise found it above at #isNonActivatedAccount:).
		No need to create and send activation token."
		^ self ].

	self createActivationTokenForAccount: account
]

{ #category : #API }
CynLocalAccountRestApiService >> createAccount: aRestRequest response: aRestResponse [

	"Add a new Account to the Accounts collection.

	Implementation:
	Always answer empty result, so wrong-doer can't conclude account exists based on result."

	<post: '/api/accounts'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynRegisterAccount fromBody: body.

	"If this Account exists, but is not activated, send new activation token,
	otherwise try to create new account (could fail if on exists, but that is
	handled in #newAccount:)."
	(self isNonActivatedAccount: account)
		ifTrue: [ self addActivationTokenToAccount: account ]
		ifFalse: [ self createAccount: account ].

	self sendEmptyResponse: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> createActivationTokenForAccount: anAccount [

	"Create an Activation record for the specified Account"

	| id token expiresAt |

	id := self newId.
	token := self newToken.
	expiresAt := CpJavaScriptDate timestampNow + (30 * 60). "30 x 60 = 30 minutes"

	modelDatabase
		performOne: #createActivation
		statement: 'INSERT INTO activations (id, email, token, expiresAt) VALUES(:id, :email, :token, :expiresAt)'
		bind: {
			#id -> id.
			#email -> anAccount email.
			#token -> token.
			#expiresAt -> expiresAt } asDictionary.

	self mailActivationToken: token to: anAccount email
]

{ #category : #'API - password' }
CynLocalAccountRestApiService >> createPasswordHashFrom: aString [

	"Answer a password hash (a hex String consisting of a '<salt><hash>' where the salt is 32 hex-characters)"

	^ self hashPassword: aString usingSalt: ((self crypto randomBytes: 16) toStringEncoding: #hex)
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> createPasswordResetTokenForAccount: anAccount [

	"Create an Forgotten record for the specified Account"

	| id token expiresAt |

	id := self newId.
	token := self newToken.
	expiresAt := CpJavaScriptDate timestampNow + (30 * 60). "30 x 60 = 30 minutes"

	modelDatabase
		performOne: #createPasswordReset
		statement: 'INSERT INTO resets (id, email, token, expiresAt) VALUES(:id, :email, :token, :expiresAt)'
		bind: {
			#id -> id.
			#email -> anAccount email.
			#token -> token.
			#expiresAt -> expiresAt } asDictionary.

	self mailPasswordResetToken: token to: anAccount email
]

{ #category : #'API - sessions' }
CynLocalAccountRestApiService >> createSessionForAccount: anAccount [

	| id accessToken |

	id := self newId.
	accessToken := self newToken.

	modelDatabase
		performOne: #createSession
		statement: 'INSERT INTO sessions (id, createdAt, accountId, accessToken, expires) VALUES(:id, :now, :accountId, :accessToken, :expires)'
		bind: {
			#id -> id.
			#now -> CpJavaScriptDate timestampNow.
			#accountId -> anAccount id.
			#accessToken -> accessToken.
			#expires -> anAccount expires } asDictionary.

	^ accessToken
]

{ #category : #errors }
CynLocalAccountRestApiService >> errorInvalidLogin [

	CpNodeJSRestUnauthorizedError signal: 'Credentials provided do not match an active account'
]

{ #category : #accessing }
CynLocalAccountRestApiService >> errorNotificationMailAccount [

	"Answer the mail account where notifications should be sent"

	^ config at: #errorNotificationMailAccount
]

{ #category : #errors }
CynLocalAccountRestApiService >> errorTokenAndEmailNotFound [

	CpNodeJSRestNotFoundError signal: 'Token and email combination not found'
]

{ #category : #errors }
CynLocalAccountRestApiService >> errorTokenExpired [

	CpNodeJSRestUnprocessableEntityError signal: 'Token is expired'
]

{ #category : #'API - authorization' }
CynLocalAccountRestApiService >> getSessionForRequest: aRestRequest [

	| accessToken |

	"Retrieve access token from the request, otherwise request is not authorized"
	accessToken := (aRestRequest headerAt: #authorization)
		ifNotNil: [ :header | header withoutPrefix: 'Bearer ' ]
		ifNil: [ ^ nil ].

	(CynTokenPropertyConstraint isValidValue: accessToken)
		ifFalse: [ ^ nil ].

	"Find the session for this access token (which has an active account attached)"
	^ modelDatabase
		selectOne: #getSessionByAccessToken
		statement: 'SELECT id, accountId, createdAt, updatedAt, expires FROM sessions WHERE accessToken=:accessToken AND EXISTS (SELECT id FROM accounts WHERE id=accountId AND activatedAt IS NOT NULL AND deletedAt IS NULL)'
		bind: { #accessToken -> accessToken } asDictionary
]

{ #category : #'API - password' }
CynLocalAccountRestApiService >> hashPassword: plainTextPassword usingSalt: saltString [

	"Answer a hash by performing a Password-Based Key Derivation Function 2 (PBKDF2) on the specified plain text password.
	The hash is a hex String consisting of '<salt><hash>'."

	^ saltString, ((self crypto
		pbkdf2Password: plainTextPassword
		salt: saltString
		iterations: 100000
		keylen: 64
		digest: #sha512) toStringEncoding: #hex)
]

{ #category : #logging }
CynLocalAccountRestApiService >> insertLogStatement [

	^ 'INSERT INTO logs (timestamp, level, message, accountId, sessionId) VALUES (:timestamp, :level, :message, :accountId, :sessionId)'
]

{ #category : #'API - authorization' }
CynLocalAccountRestApiService >> isAdminAccount: aString [

	"Answer a Boolean stating whether the supplied account ID is for an admin user"

	^ false
]

{ #category : #'API - sessions' }
CynLocalAccountRestApiService >> isExpiredSession: aSession [

	"Answer whether the session (a Dictionary) is expired.

	Implementation:
	The field #expires can be:
		#never - session never expires
		#day - session expires the next day (when no longer kept alive by regular usage, see below)
		#usage - session expires if the API is not used for a certain amount of time (see #sessionExpirationDuration)

	When a session expires the next day, it can in fact be kept alive unlimitedly IF the user keeps using the API.
	Same holds for #usage of course."

	| expires now createdAt updatedAt |

	"Never expiring sessions, never expire ;-)"
	expires := aSession at: #expires.
	expires = #never
		ifTrue: [ ^ false ].

	"Check for recent activity (both day and usage)"
	now := CpJavaScriptDate timestampNow.
	updatedAt := (aSession at: #updatedAt)
		ifNil: [ aSession at: #createdAt ].
	updatedAt + self sessionExpirationDuration > now
		ifTrue: [ ^ false ].

	"Check for expiring the next day"
	expires = #day
		ifTrue: [
			"Check if 'createdAt' and 'now' are still on the same day (1 day = 86400 seconds, 60 * 60 * 24)"
			createdAt := aSession at: #createdAt.
			(createdAt // 86400) = (now // 86400)
				ifTrue: [ ^ false ] ].

	^ true
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> isNonActivatedAccount: anAccount [

	"Answer whether the specified Account has pending activations (might be expired)"

	^ modelDatabase
		exists: #openActivationsExists
		statement: 'SELECT id FROM activations WHERE email=:email UNION SELECT id FROM accounts WHERE email=:email AND activatedAt IS NULL'
		bind: { #email -> anAccount email } asDictionary
]

{ #category : #API }
CynLocalAccountRestApiService >> log: aRestRequest response: aRestResponse [

	"Log the client message.
	This endpoint is to be used for storing relevant client side events (including errors).

	Implementation:
	It is assumed this endpoint is called used the CpBrowserNavigator >> sendBeacon:data:
	method. This mechanism does not offer any means to add authentication data to the
	request header. Authentication is therefore done based on the body content.
	Beacon requests do not expect a result, therefore silently ignore any errors."

	<post: '/api/log'>
	<public>

	[ self notifyLog: (self writeClientLogFrom: aRestRequest) ] on: Error do: [ :error | "ignore errors" ].

	"Beacon requests do not expect a response"
	super send: Dictionary new response: aRestResponse
]

{ #category : #logging }
CynLocalAccountRestApiService >> logError: anError request: aRestRequest [

	^ self notifyLog: (super logError: anError request: aRestRequest)
]

{ #category : #logging }
CynLocalAccountRestApiService >> logInfoMessage: aString request: aRestRequest [

	"Do not log for logging API call"

	aRestRequest ifNotNil: [
		aRestRequest path asString = '/api/log'
			ifTrue: [ ^ nil ] ].

	^ super logInfoMessage: aString request: aRestRequest
]

{ #category : #logging }
CynLocalAccountRestApiService >> logRecordFromError: anError request: aRestRequest [

	| session |

	session := aRestRequest ifNotNil: [ self getSessionForRequest: aRestRequest ].

	^ (super logRecordFromError: anError request: aRestRequest)
		at: #sessionId put: (session ifNotNil: [ session at: #sessionId ifAbsent: [ nil ] ]) ;
		at: #accountId put: (session ifNotNil: [ session at: #accountId ifAbsent: [ nil ] ]) ;
		yourself
]

{ #category : #logging }
CynLocalAccountRestApiService >> logRecordFromRequest: aRestRequest [

	| session |

	session := aRestRequest ifNotNil: [ self getSessionForRequest: aRestRequest ].

	^ (super logRecordFromRequest: aRestRequest)
		at: #sessionId put: (session ifNotNil: [ session at: #sessionId ifAbsent: [ nil ] ]) ;
		at: #accountId put: (session ifNotNil: [ session at: #accountId ifAbsent: [ nil ] ]) ;
		yourself
]

{ #category : #API }
CynLocalAccountRestApiService >> login: aRestRequest response: aRestResponse [

	<post: '/api/accounts?action=login'>
	<public>

	| body account storedAccount accessToken |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynLoginAccount fromBody: body.

	"Precaution to not divulge more information than needed"
	[
		"Read account"
		storedAccount := modelDatabase
			selectOne: #login
			statement: 'SELECT id, email, password, settings FROM accounts WHERE deletedAt IS NULL AND email=:email'
			bind: {
				#email -> account email } asDictionary.

		storedAccount ifNil: [ self errorInvalidLogin ].

		"Validate password"
		(self matchPassword: account password withHash: (storedAccount at: #password))
			ifFalse: [ self errorInvalidLogin ].

		"Merge the stored account id"
		account id: (storedAccount at: #id).
	] on: Error do: [ :err | self errorInvalidLogin ].

	"Create session and store access token in response header"
	accessToken := self createSessionForAccount: account.
	aRestResponse setHeaderWithName: #'cp-access-token' value: accessToken.

	"Send response to indicate success"
	self send: { #success -> true . #settings -> (CpJavaScriptJSON parse: (storedAccount at: #settings)) } asDictionary response: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> mailActivationToken: tokenString to: emailString [

	self mail: (self activationTokenMailMessageWith: tokenString) to: emailString
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> mailPasswordResetToken: tokenString to: emailString [

	self mail: (self passwordResetTokenMailMessageWith: tokenString) to: emailString
]

{ #category : #'API - password' }
CynLocalAccountRestApiService >> matchPassword: plainTextPassword withHash: hashedPassword [

	"Answer whether the specified password matches the hashed password specified.

	Implementation:
	The hashed password consists of: 16 byte hex salt string followed by hashed password (PBKDF2).
	Therefore extract the first 32 characters (salt string is hex string of 16 bytes) to recreate
	the salt. Then perform hashing algorithm to create a hashed password value.
	Finally, check that value against the previously stored hashed value."

	| salt hash |

	salt := hashedPassword first: 32.

	hash := self hashPassword: plainTextPassword usingSalt: salt.

	^ hashedPassword = hash
]

{ #category : #accessing }
CynLocalAccountRestApiService >> notificationTimeout [

	"Answer the timeout before sending the same/similar notification again (in seconds).

	By default this is 30 minutes."

	^ (config at: #notificationTimeout) ifNil: [ 1800 ]
]

{ #category : #accessing }
CynLocalAccountRestApiService >> notificationWindow [

	"Answer the time frame in which a certain amount of notifications can be sent (in seconds).
	The amount is specified by #notificationWindowCount.

	By default this is 2 hours."

	^ (config at: #notificationWindow) ifNil: [ 7200 ]
]

{ #category : #accessing }
CynLocalAccountRestApiService >> notificationWindowCount [

	"Answer the amount of notifications which can be sent in a fixed time frame.
	The time frame is specified by #notificationWindow.

	By default this is 4."

	^ (config at: #notificationWindowCount) ifNil: [ 4 ]
]

{ #category : #notifying }
CynLocalAccountRestApiService >> notify: messageString statusCode: statusCodeInteger stack: stackString forLogId: logIdInteger [

	"Notify by sending a mail to the admin and then adding entry to the database"

	| notificationMessage |

	notificationMessage := self newMailMessage
		to: self errorNotificationMailAccount ;
		subject: 'Error in ', (self class nameWithoutPrefix withoutSuffix: 'RestApiService') ;
		html: ('<h1>Error: {1}</h1><h3>Statuscode: {2}</h3><h3>Stack trace:</h3><pre>{3}</pre>' format: { messageString . statusCodeInteger printString . stackString }) ;
		yourself.

	mailer sendMail: notificationMessage thenDo: [ :error :info |
		error ifNotNil: [ self errorCr: 'Failed to send notification: ', error printString ] ].

	[ logDatabase
		performOne: #addNotification
		statement: 'INSERT INTO notifications (timestamp, logId, statusCode, message) VALUES(:now, :logId, :statusCode, :message)'
		bind: {
			#now -> CpJavaScriptDate timestampNow.
			#logId -> logIdInteger.
			#statusCode -> statusCodeInteger.
			#message -> messageString } asDictionary
	] on: Error do: [ :error | self errorCr: 'Failed to store notification: ', error printString ]
]

{ #category : #notifying }
CynLocalAccountRestApiService >> notifyLog: anInteger [

	"Notify about the log entry.
	Answer the log id provided."

	| logRecord notified recently |

	anInteger ifNil: [ ^ nil ].

	self shouldNotify
		ifFalse: [ ^ anInteger ].

	"Retrieve log record"
	logRecord := logDatabase
		selectOne: #recentLogEntry
		statement: 'SELECT statusCode, message, stack FROM logs WHERE id=:id'
		bind: { #id -> anInteger } asDictionary.
	logRecord ifNil: [ ^ anInteger ].

	(self shouldNotifyStatusCode: (logRecord at: #statusCode))
		ifFalse: [ ^ anInteger ].

	"Check if a recent notification is made for a similar log entry"
	recently := CpJavaScriptDate timestampNow - self notificationTimeout.
	notified := logDatabase
		exists: #notificationExists
		statement: 'SELECT id FROM notifications WHERE timestamp >= :recently AND statusCode=:statusCode AND message=:message'
		bind: {
			#recently -> recently.
			#statusCode -> (logRecord at: #statusCode).
			#message -> (logRecord at: #message) } asDictionary.

	"If recently notified, do not notify again"
	notified ifTrue: [ ^ anInteger ].

	"Check total amount of recent notifications"
	recently := CpJavaScriptDate timestampNow - self notificationWindow.
	notified := logDatabase
		selectCount: #countRecentNotifications
		statement: 'SELECT count(*) FROM notifications WHERE timestamp >= :recently AND (statusCode>=500 OR statusCode=0)'
		bind: { #recently -> recently } asDictionary.

	"If too many notifications, do not notify again"
	notified > self notificationWindowCount
		ifTrue: [ ^ anInteger ].

	"Do notify"
	self
		notify: (logRecord at: #message)
		statusCode: (logRecord at: #statusCode)
		stack: (logRecord at: #stack)
		forLogId: anInteger.

	^ anInteger
]

{ #category : #API }
CynLocalAccountRestApiService >> passwordForgottenAccount: aRestRequest response: aRestResponse [

	"Activate Account within Accounts collection"

	<post: '/api/accounts?action=password-forgotten'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynPasswordForgottenAccount fromBody: body.

	self sendPasswordResetMailToAccount: account.

	self sendEmptyResponse: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> passwordResetAccount: aPasswordResetAccount [

	"Reset password for the specified Account"

	| now passwordHash resets |

	now := CpJavaScriptDate timestampNow.
	passwordHash := self createPasswordHashFrom: aPasswordResetAccount password.

	resets := modelDatabase
		selectMany: #getResets
		statement: 'SELECT id, expiresAt FROM resets WHERE token=:token AND email=:email ORDER BY expiresAt DESC'
		bind: {
			#token -> aPasswordResetAccount token.
			#email -> aPasswordResetAccount email } asDictionary.

	"No match for token and email"
	resets ifEmpty: [ ^ self errorTokenAndEmailNotFound ].

	"Token already expired (okay to provide answer, since token is secret value anyway and can't be guessed)"
	(resets first at: #expiresAt) < now
		ifTrue: [ ^ self errorTokenExpired ].

	"Store the new password"
	modelDatabase
		performOne: #passwordResetAccount
		statement: 'UPDATE accounts SET updatedAt=:now, password=:passwordHash WHERE email=:email AND deletedAt IS NULL'
		bind: {
			#now -> now.
			#passwordHash -> passwordHash.
			#email -> aPasswordResetAccount email } asDictionary.

	"Remove resets (no longer needed)"
	modelDatabase
		performMulti: #removeResets
		statement: 'DELETE FROM resets WHERE email=:email'
		bind: {
			#email -> aPasswordResetAccount email } asDictionary
]

{ #category : #API }
CynLocalAccountRestApiService >> passwordResetAccount: aRestRequest response: aRestResponse [

	"Reset password of Account within Accounts collection"

	<post: '/api/accounts?action=password-reset'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CynPasswordResetAccount fromBody: body.

	self passwordResetAccount: account.

	self sendEmptyResponse: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> passwordResetTokenMailMessageWith: aString [

	^ self newMailMessage
		subject: 'Password reset code' ;
		text: ('Your password reset code is: {1}' format: { aString }) ;
		html: ('Your <i>password reset code</i> is <code>{1}</code>' format: { aString }) ;
		yourself
]

{ #category : #API }
CynLocalAccountRestApiService >> ping: aRestRequest response: aRestResponse [

	"Ping to check on liveness"

	<get: '/api/ping/hello'>
	<public>

	"Validate the access token (if supplied)"
	(aRestRequest hasHeaderAt: #authorization)
		ifTrue: [ self validateAuthorizedRequest: aRestRequest ].

	super ping: aRestRequest response: aRestResponse
]

{ #category : #'API - accounts' }
CynLocalAccountRestApiService >> sendPasswordResetMailToAccount: anAccount [

	"Send a password reset mail the specified Account.

	Implementation:
	If account does not exist, ignore it. Do not let caller know whether
	account exists or not."

	modelDatabase
		exists: #passwordResetAccountExists
		statement: 'SELECT id FROM accounts WHERE email=:email AND activatedAt IS NOT NULL AND deletedAt IS NULL'
		bind: { #email -> anAccount email } asDictionary
		ifNot: [ ^ self ].

	self createPasswordResetTokenForAccount: anAccount
]

{ #category : #accessing }
CynLocalAccountRestApiService >> sessionExpirationDuration [

	"Answer the duration before a session's access token expires (in seconds).

	By default this is 30 minutes."

	^ (config at: #sessionExpirationDuration) ifNil: [ 1800 ]
]

{ #category : #notifying }
CynLocalAccountRestApiService >> shouldNotify [

	^ self errorNotificationMailAccount isNotNil
]

{ #category : #notifying }
CynLocalAccountRestApiService >> shouldNotifyStatusCode: anInteger [

	"Only notify internal server errors or client errors (statusCode = 0)"

	^ anInteger >= 500 or: [ anInteger = 0 ]
]

{ #category : #logging }
CynLocalAccountRestApiService >> updateLogResponse: aRestResponse [

	"Update the log entry with status code.
	Add notification for the entry."

	^ self notifyLog: (super updateLogResponse: aRestResponse)
]

{ #category : #'API - settings' }
CynLocalAccountRestApiService >> updateSettings: aDictionary forAccountId: aString [

	| settings |

	modelDatabase performInTransaction: [
		| accountInfo |

		"Read settings"
		accountInfo := modelDatabase
			selectOne: #getSettings
			statement: 'SELECT settings, updatedAt FROM accounts WHERE id=:accountId'
			bind: {
				#accountId -> aString } asDictionary.
		accountInfo ifNil: [ CpNodeJSRestBadRequestError signal ].

		settings := [ CpJavaScriptJSON parse: (accountInfo at: #settings) ] on: Error do: [ :error |
			self logError: error.
			self errorCr: 'Failed to parse account settings ', error printString.
			self traceCr: 'Settings: ', (accountInfo at: #settings) printString.

			"Start with empty settings"
			Dictionary new ].

		"Update settings"
		aDictionary keysAndValuesDo: [ :key :value |
			value
				ifNotNil: [ settings at: key put: value ]
				ifNil: [ settings removeKey: key ifAbsent: [ "ignore" ] ] ].

		"Write settings"
		modelDatabase
			performOne: #updateSettings
			statement: 'UPDATE accounts SET settings=:settings WHERE id=:accountId AND updatedAt=:updatedAt'
			bind: {
				#settings -> (CpJavaScriptJSON stringify: settings).
				#accountId -> aString.
				#updatedAt -> (accountInfo at: #updatedAt) } asDictionary ].

	^ settings
]

{ #category : #API }
CynLocalAccountRestApiService >> updateSettings: aRestRequest response: aRestResponse [

	"Patch the settings using the following mechanism:
		fields which are non-nil are set to their specified value.
		fields which are nil are removed."

	<patch: '/api/accounts/current/settings'>

	| settings |

	settings := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].

	self send: (self updateSettings: settings forAccountId: aRestRequest accountId) response: aRestResponse
]

{ #category : #'API - authorization' }
CynLocalAccountRestApiService >> validateAuthorizedRequest: aRestRequest [

	"Default authorization handler for non-public endpoints"

	| session |

	session := self getSessionForRequest: aRestRequest.
	session ifNil: [ CpNodeJSRestForbiddenError signal ].

	"Check for expiration (if expired, signal Unauthorized!)"
	(self isExpiredSession: session)
		ifTrue: [ CpNodeJSRestUnauthorizedError signal ].

	"Update the session"
	modelDatabase
		performOne: #updateSession
		statement: 'UPDATE sessions SET updatedAt=:now WHERE id=:id'
		bind: {
			#id -> (session at: #id).
			#now -> CpJavaScriptDate timestampNow } asDictionary.

	"Store the accountId for later usage"
	aRestRequest propertyAt: #accountId put: (session at: #accountId)
]

{ #category : #'API - logging' }
CynLocalAccountRestApiService >> writeClientLogFrom: aRestRequest [

	"Write the client log from the request. The client send this log request using Beacon API.
	Validate the body contains a accessToken (which may already be expired, but should be known).
	Without an access token, ignore the log (otherwise there will be the opportunity to fill our
	logging DB with trash).
	Answer the id of the log row created (or nil if none is created)."

	| body accessToken session level message logRecord |

	body := (aRestRequest jsonBody)
		ifNil: [ ^ nil ].

	"Validate the access token exists (but may be expired)"
	accessToken := body at: #accessToken ifAbsent: [ ^ nil ].
	(CynTokenPropertyConstraint isValidValue: accessToken)
		ifFalse: [ ^ nil ].
	session := modelDatabase
		selectOne: #sessionForLogging
		statement: 'SELECT id, accountId FROM sessions WHERE accessToken=:accessToken'
		bind: { #accessToken -> accessToken } asDictionary.

	level := body at: #level ifAbsent: [ ^ nil ].
	message := body at: #message ifAbsent: [ ^ nil ].

	logRecord := {
		#timestamp -> CpJavaScriptDate timestampNow.
		#level -> level.
		#message -> ('Client log: ', message).
		#statusCode -> 0.
		#accountId -> (session ifNotNil: [ session at: #accountId ]).
		#sessionId -> (session ifNotNil: [ session at: #id ]).
		#stack -> (body at: #stack ifAbsent: [ nil ]).
	} asDictionary.

	[
		^ logDatabase
			performOne: #insertClientLogRecord
			statement: 	'INSERT INTO logs (timestamp, level, message, accountId, sessionId, stack) VALUES (:timestamp, :level, :message, :accountId, :sessionId, :stack)'
			bind: logRecord
	] on: Error do: [ :error |
		self warnCr: 'Failed to write log record: ', error printString.
		^ nil ]
]
