Class {
	#name : #CpCanyonLocalAccountRestApiService,
	#superclass : #CpCanyonBaseRestApiService,
	#instVars : [
		'mailer'
	],
	#category : #'CodeParadise-Canyon-Data-Service'
}

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> activateAccount: anActivateAccount [

	"Activate the specified Account.

	Implementation:
	If there is not activation for the specified Account, provide the same error
	as in #activateAccount:response: to prevent wrong-doer from concluding account
	exists for given email address."

	| now activations |

	now := self timestampNow.

	activations := modelDatabase
		selectMany: #getActivations
		statement: 'SELECT id, expiresAt FROM activations WHERE token=:token AND email=:email ORDER BY expiresAt DESC'
		bind: {
			#token -> anActivateAccount token.
			#email -> anActivateAccount email } asDictionary.

	"No match for token and email"
	activations ifEmpty: [ ^ self errorActivationNotFound ].

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
CpCanyonLocalAccountRestApiService >> activateAccount: aRestRequest response: aServerResponse [

	"Activate Account within Accounts collection"

	<post: '/api/accounts?action=activate'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CpCanyonActivateAccount fromBody: body.

	(self isNonActivatedAccount: account)
		ifFalse: [ ^ self errorActivationNotFound ].

	self activateAccount: account.

	self sendEmptyResponse: aServerResponse
]

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> activationTokenMailMessageWith: aString [

	^ CpNodeJSNodemailerMessage new
		subject: 'Activation code' ;
		text: ('Your activation code is: {1}' format: { aString }) ;
		html: ('Your <i>activation code</i> is <code>{1}</code>' format: { aString }) ;
		yourself
]

{ #category : #API }
CpCanyonLocalAccountRestApiService >> addAccount: aRestRequest response: aServerResponse [

	"Add a new Account to the Accounts collection.

	Implementation:
	Always answer empty result, so wrong-doer can't conclude account exists based on result."

	<post: '/api/accounts'>
	<public>

	| body account |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CpCanyonCreateAccount fromBody: body.

	"If this Account exists, but is not activated, send new activation token,
	otherwise try to create new account (could fail if on exists, but that is
	handled in #newAccount:)."
	(self isNonActivatedAccount: account)
		ifTrue: [ self addActivationTokenToAccount: account ]
		ifFalse: [ self createAccount: account ].

	self sendEmptyResponse: aServerResponse
]

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> addActivationTokenToAccount: anAccount [

	"Send new activation token to existing account, update the provided
	password. In theory a wrong-doer could get in between registration
	and activation, but that will not result in access to the account.
	At worst the account owner needs to reset his/her password."

	| passwordHash updatedAt |

	"Update password with the new value given (to prevent name clash use
	statement identifier: #insertAccountPassword"
	passwordHash := self createPasswordHashFrom: anAccount password.
	updatedAt := self timestampNow.
	modelDatabase
		performOne: #insertAccountPassword
		statement: 'UPDATE accounts SET password=:password, updatedAt=:updatedAt WHERE email=:email'
		bind: {
			#email -> anAccount email.
			#password -> passwordHash.
			#updatedAt -> updatedAt } asDictionary.

	self createActivationTokenForAccount: anAccount
]

{ #category : #accessing }
CpCanyonLocalAccountRestApiService >> configMailer [

	"Answer the mailer configuration"

	^ config at: #mailer
]

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> createAccount: account [

	| id createdAt passwordHash |

	"Try to create new Account (might fail if it exists, but we catch that)"
	id := self newId.
	createdAt := self timestampNow.
	passwordHash := self createPasswordHashFrom: account password.

	[
		modelDatabase
			performOne: #insertAccount
			statement: 'INSERT INTO accounts (id, createdAt, email, password, settings) VALUES(:id, :createdAt, :email, :password, :settings)'
			bind: {
				#id -> id.
				#createdAt -> createdAt.
				#email -> account email.
				#password -> passwordHash.
				#settings -> '{}' } asDictionary
	] on: CpDatabaseUniqueConstraintViolation do: [
		"Account exists and is already activated (otherwise found it above at #isNonActivatedAccount:).
		No need to create and send activation token."
		^ self ].

	self createActivationTokenForAccount: account
]

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> createActivationTokenForAccount: anAccount [

	"Create an Activation record for the specified Account"

	| id token expiresAt |

	id := self newId.
	token := self newToken.
	expiresAt := self timestampNow + (30 * 60). "30 x 60 = 30 minutes"

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
CpCanyonLocalAccountRestApiService >> createPasswordHashFrom: aString [

	"Answer a password hash (a hex String consisting of a '<salt><hash>' where the salt is 32 hex-characters)"

	^ self hashPassword: aString usingSalt: ((self crypto randomBytes: 16) toStringEncoding: #hex)
]

{ #category : #'API - sessions' }
CpCanyonLocalAccountRestApiService >> createSessionForAccount: anAccount [

	| id createdAt accessToken |

	id := self newId.
	createdAt := self timestampNow.
	accessToken := self newToken.

	modelDatabase
		performOne: #createSession
		statement: 'INSERT INTO sessions (id, createdAt, accountId, accessToken, expires) VALUES(:id, :createdAt, :accountId, :accessToken, :expires)'
		bind: {
			#id -> id.
			#createdAt -> createdAt.
			#accountId -> anAccount id.
			#accessToken -> accessToken.
			#expires -> anAccount expires } asDictionary.

	^ accessToken
]

{ #category : #errors }
CpCanyonLocalAccountRestApiService >> errorActivationNotFound [

	CpNodeJSRestNotFoundError signal: 'Token and email combination not found'
]

{ #category : #errors }
CpCanyonLocalAccountRestApiService >> errorInvalidLogin [

	CpNodeJSRestUnauthorizedError signal: 'Credentials provided do not match an active account'
]

{ #category : #errors }
CpCanyonLocalAccountRestApiService >> errorTokenExpired [

	CpNodeJSRestGoneError signal: 'Token is expired'
]

{ #category : #'API - password' }
CpCanyonLocalAccountRestApiService >> hashPassword: plainTextPassword usingSalt: saltString [

	"Answer a hash by performing a Password-Based Key Derivation Function 2 (PBKDF2) on the specified plain text password.
	The hash is a hex String consisting of '<salt><hash>'."

	^ saltString, ((self crypto
		pbkdf2Password: plainTextPassword
		salt: saltString
		iterations: 100000
		keylen: 64
		digest: #sha512) toStringEncoding: #hex)
]

{ #category : #initialization }
CpCanyonLocalAccountRestApiService >> initialize [

	super initialize.

	mailer := CpNodeJSNodemailerTransporter createTransport: (config at: #mailer) withDefaults: (config at: #'mailer-defaults').
	mailer verify: [ :error :success |
		error ifNotNil: [ self errorCr: ('Startup error mailer: {1}' format: { error }) ].
		success ifNotNil: [ self traceCr: ('Startup mailer successful: {1}' format: { success }) ] ]
]

{ #category : #'API - authorization' }
CpCanyonLocalAccountRestApiService >> isAdminAccount: aString [

	"Answer a Boolean stating whether the supplied account ID is for an admin user"

	^ false
]

{ #category : #'API - sessions' }
CpCanyonLocalAccountRestApiService >> isExpiredSession: aSession [

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
	now := self timestampNow.
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
CpCanyonLocalAccountRestApiService >> isNonActivatedAccount: anAccount [

	"Answer whether the specified Account has pending activations (might be expired)"

	| activations |

	activations := modelDatabase
		selectMany: #getOpenActivations
		statement: 'SELECT id FROM activations WHERE email=:email UNION SELECT id FROM accounts WHERE email=:email AND activatedAt IS NULL'
		bind: { #email -> anAccount email } asDictionary.

	^ activations isNotEmpty
]

{ #category : #API }
CpCanyonLocalAccountRestApiService >> login: aRestRequest response: aServerResponse [

	<post: '/api/accounts?action=login'>
	<public>

	| body account storedAccount accessToken |

	body := (aRestRequest jsonBody) ifNil: [ self errorNoBody ].
	account := self extractNewObject: CpCanyonLoginAccount fromBody: body.

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
	aServerResponse appendHeaderWithName: #'cp-access-token' value: accessToken.

	"Send response to indicate success"
	self send: { #success -> true . #settings -> (storedAccount at: #settings) } asDictionary response: aServerResponse
]

{ #category : #'API - support' }
CpCanyonLocalAccountRestApiService >> mail: aMessage to: aString [

	"Send the specified Message to the specified recipient"

	"Update message with to fields"
	aMessage to: aString.

	mailer sendMail: aMessage thenDo: [ :error :info |
		error ifNotNil: [ self errorCr: ('sendMail error: {1}' format: { error }) ].
		info ifNotNil: [ self traceCr: ('sendMail: {1}' format: { info }) ] ]
]

{ #category : #'API - accounts' }
CpCanyonLocalAccountRestApiService >> mailActivationToken: tokenString to: emailString [

	self mail: (self activationTokenMailMessageWith: tokenString) to: emailString
]

{ #category : #'API - password' }
CpCanyonLocalAccountRestApiService >> matchPassword: plainTextPassword withHash: hashedPassword [

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
CpCanyonLocalAccountRestApiService >> sessionExpirationDuration [

	"Answer the duration before a session's access token expires (in seconds).

	By default this is 30 minutes."

	^ (config at: #sessionExpirationDuration) ifNil: [ 1800 ]
]

{ #category : #'API - authorization' }
CpCanyonLocalAccountRestApiService >> validateAuthorizedRequest: aRestRequest [

	"Default authorization handler for non-public endpoints"

	| accessToken session |

	"Retrieve access token from the request, otherwise request is not authorized"
	accessToken := (aRestRequest headerAt: #authorization)
		ifNotNil: [ :header | header withoutPrefix: 'Bearer ' ]
		ifNil: [ CpNodeJSRestForbiddenError signal ].

	(CpTokenPropertyConstraint default isValid: accessToken)
		ifFalse: [ CpNodeJSRestForbiddenError signal ].

	"Find the session for this access token (which has an active account attached)"
	session := modelDatabase
		selectOne: #getSessionByAccessToken
		statement: 'SELECT id, accountId, createdAt, updatedAt, expires FROM sessions WHERE accessToken=:accessToken AND EXISTS (SELECT id FROM accounts WHERE id=accountId AND activatedAt IS NOT NULL AND deletedAt IS NULL)'
		bind: { #accessToken -> accessToken } asDictionary.

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
			#now -> self timestampNow } asDictionary.

	"Store the accountId for later usage"
	aRestRequest propertyAt: #accountId put: (session at: #accountId)
]
