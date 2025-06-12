Class {
	#name : #CynRestApiClient,
	#superclass : #CpBaseModel,
	#instVars : [
		'baseUrl',
		'accessToken',
		'lastUsedTimestamp',
		'lastResponseTimestamp',
		'lastSuccessResponseTimestamp'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CynRestApiClient class >> baseUrl: aString [

	"Answer an instance of the receiver for the specified base URL
	(all requests will add their URI to access specific resources).

	The base URL can be relative (to the client) or absolute."

	^ self basicNew
		initializeWithBaseUrl: aString ;
		yourself
]

{ #category : #'class initialization' }
CynRestApiClient class >> beLoaded [

	CpBrowserResponse beLoaded.
	CpJavaScriptError beLoaded
]

{ #category : #'instance creation' }
CynRestApiClient class >> new [

	self errorNewReplacedBy: #baseUrl:
]

{ #category : #resources }
CynRestApiClient class >> timestampNow [

	"Answer the current timestamp as seconds since Unix epoch (midnight Jan 1, 1970, UTC).

	Implementation:
	Since currently the tiny image for CodeParadise does not support any Date and Time classes,
	use a simple Unix timestamp. This value can be retrieved in both environments. It allows
	easy comparison and storage."

	(Smalltalk classNamed: #DateAndTime)
		ifNotNil: [ :dateAndTimeClass | ^ dateAndTimeClass now asUnixTime ].

	(Smalltalk classNamed: #CpJavaScriptClass)
		ifNotNil: [ :jsClass | ^ ((jsClass forName: #Date) apply: #now) // 1000 ].

	self error: 'No Date or DateAndTime class available in the current environment'
]

{ #category : #operations }
CynRestApiClient >> deleteUri: aString timeoutPeriod: anInteger [

	"Perform the DELETE operation with the URI and answer the response content"

	^ self performOperation: #DELETE uri: aString queryParams: nil body: nil timeoutPeriod: anInteger
]

{ #category : #operations }
CynRestApiClient >> getUri: aString queryParams: aDictionary timeoutPeriod: anInteger [

	"Perform the GET operation with the URI and query parameters and answer the response content"

	^ self performOperation: #GET uri: aString queryParams: aDictionary body: nil timeoutPeriod: anInteger
]

{ #category : #operations }
CynRestApiClient >> getUri: aString timeoutPeriod: anInteger [

	"Perform the GET operation with the URI and answer the response content"

	^ self performOperation: #GET uri: aString queryParams: nil body: nil timeoutPeriod: anInteger
]

{ #category : #'response handling' }
CynRestApiClient >> handleErrorResponse: aResponse [

	"Handle the error response by signaling an CynRestResponseError (to be handled higher up).
	In case an expired session, simply answer nil and do not signal an Error."

	| errorDescription exception |

	"Check for an expired session"
	(aResponse status = CynRestResponseError codeUnauthorized and: [ accessToken isNotNil ])
		ifTrue: [
			self setAccessToken: nil.

			"Announce the session has expired.
			Answer nil to indicate there is no valid response."
			self announce: CynSessionExpired.
			^ nil ].

	"Extract error description from response"
	errorDescription := [
		aResponse text await
			ifEmpty: [
				aResponse statusText
					ifEmpty: [ 'Unspecified error' ] ]
	] on: Error do: [ :error |
		self warnCr: 'Internal error extracting error description: ', error printString.
		'Unspecified error' ].

	"Create exception, announce it and signal it (to allow cleanup in call stack)"
	exception := CynRestResponseError messageText: errorDescription statusCode: aResponse status.

	self announce: (CynRestApiClientFailed exception: exception).

	exception signal
]

{ #category : #'response handling' }
CynRestApiClient >> handleSuccessfulResponse: aResponse [

	"Answer the Response's content (assuming status is in 200-299 range)"

	| result |

	"A JSON result can't be a Symbol, use it as placeholder to recognize it is not used"
	result := #unused.

	(aResponse headers get: 'Content-Type')
		ifNotNil: [ :contentType |
			(contentType includesSubstring: 'application/json')
				ifTrue: [ result := aResponse json await ] ].

	result == #unused
		ifTrue: [ result := aResponse text await ].

	lastSuccessResponseTimestamp := self class timestampNow.

	^ result
]

{ #category : #testing }
CynRestApiClient >> hasAccessToken [

	^ accessToken isNotNil
]

{ #category : #'initialize - release' }
CynRestApiClient >> initialize [

	super initialize.

	"If an access token is persisted, retrieve it"
	(CpClientEnvironment current variableAt: #ACCESS_TOKEN)
		ifNotNil: [ :newAccessToken | self setAccessToken: newAccessToken ]
]

{ #category : #initialization }
CynRestApiClient >> initializeWithBaseUrl: aString [

	self initialize.

	baseUrl := aString
]

{ #category : #accessing }
CynRestApiClient >> lastResponseTimestamp [

	^ lastResponseTimestamp
]

{ #category : #accessing }
CynRestApiClient >> lastSuccessResponseTimestamp [

	^ lastSuccessResponseTimestamp
]

{ #category : #accessing }
CynRestApiClient >> lastUsedTimestamp [

	^ lastUsedTimestamp
]

{ #category : #operations }
CynRestApiClient >> patchUri: uriString body: anObject timeoutPeriod: anInteger [

	"Perform the PATCH operation with the URI and body and answer the response content"

	^ self performOperation: #PATCH uri: uriString queryParams: nil body: anObject timeoutPeriod: anInteger
]

{ #category : #private }
CynRestApiClient >> performOperation: aSymbol uri: uriString queryParams: aDictionary body: anObject timeoutPeriod: anInteger [

	"Perform the specified operation with URI and body (can be nil) and answer the response content.
	The body object can be a String, ArrayBuffer, Blob, File, FormData or a ReadableStream.
	If the query parameter's Dictionary contains non-String values, these will be converted to
	Strings. Exception is a nil value, which will NOT be used at all. To send such values to the
	server, replace nil values with the desired String representation."

	| headers url fetch response |

	headers := Dictionary new.

	"Add authorization to headers if access token is present (even on public endpoints)"
	accessToken
		ifNotNil: [ headers at: #Authorization put: 'Bearer ', accessToken ].

	"Create URL"
	url := String streamContents: [ :stream |
		stream
			nextPutAll: baseUrl ;
			nextPutAll: (CpGlobalThis encodeURI: uriString).

		"Add query parameters"
		aDictionary isEmptyOrNil ifFalse: [
			| haveParams |

			haveParams := uriString includes: $?.
			aDictionary keysAndValuesDo: [ :key :value |
				value ifNotNil: [
					haveParams
						ifTrue: [ stream nextPut: $& ]
						ifFalse: [
							stream nextPut: $?.
							haveParams := true ].
					stream
						nextPutAll: (CpGlobalThis encodeURIComponent: key) ;
						nextPut: $= ;
						nextPutAll: (CpGlobalThis encodeURIComponent: value asString) ] ] ] ].

	"Create request"
	fetch := CpGlobalThis
		fetch: url
		withOptions: {
			#method -> aSymbol.
			#headers -> headers.
			#body -> anObject.
			#mode -> #cors.
			#redirect -> #error.
			#priority -> #high.
			#signal -> (CpBrowserAbortSignal timeout: anInteger) } asDictionary.
	lastUsedTimestamp := self class timestampNow.

	"Retrieve response"
	response := fetch await.
	lastResponseTimestamp := self class timestampNow.

	"Extract (new) access token"
	self updateAccessTokenFromResponse: response.

	"Handle the specified response answering the response content
	or signal an Error (i.e. when status not in the success range 200 - 299)"
	^ (response status between: 200 and: 299)
		ifTrue: [ self handleSuccessfulResponse: response ]
		ifFalse: [ self handleErrorResponse: response ]
]

{ #category : #operations }
CynRestApiClient >> ping [

	"Answer a Boolean stating whether the server could be pinged successfully"

	| response |

	response := [
		self getUri: '/ping/hello' timeoutPeriod: self pingTimeoutPeriod
	] on: Error do: [ :err | ^ false ].

	^ response = #world
]

{ #category : #accessing }
CynRestApiClient >> pingTimeoutPeriod [

	"Answer the number of milliseconds before a ping request should time out"

	^ 2000
]

{ #category : #operations }
CynRestApiClient >> postUri: uriString body: anObject timeoutPeriod: anInteger [

	"Perform the POST operation with the URI and body and answer the response content"

	^ self performOperation: #POST uri: uriString queryParams: nil body: anObject timeoutPeriod: anInteger
]

{ #category : #operations }
CynRestApiClient >> putUri: uriString body: anObject timeoutPeriod: anInteger [

	"Perform the PUT operation with the URI and body and answer the response content"

	^ self performOperation: #PUT uri: uriString queryParams: nil body: anObject timeoutPeriod: anInteger
]

{ #category : #accessing }
CynRestApiClient >> requestTimeoutPeriod [

	"Answer the number of milliseconds before a request should time out"

	^ 8000
]

{ #category : #operations }
CynRestApiClient >> reset [

	"Reset the receiver, removing the access token"

	self setAccessToken: nil
]

{ #category : #private }
CynRestApiClient >> setAccessToken: aString [

	"Store the specified (new) access token in the receiver.
	It might be nil to indicating the previous value has expired."

	"Validate the access token is usable (might be empty to specify it is expired)"
	(aString isNotNil and: [ (CynTokenPropertyConstraint isValidValue: aString) not ])
		ifTrue: [
			self warnCr: 'Received invalid acccess token from the server (ignoring it): ', aString.
			^ self ].

	"Check if something changed"
	accessToken = aString
		ifTrue: [ ^ self ].

	"Update the access token"
	accessToken := aString.

	"Keep or remove access token in Session storage"
	accessToken
		ifNotNil: [
			CpClientEnvironment current
				variableAt: #ACCESS_TOKEN put: accessToken ]
		ifNil: [
			CpClientEnvironment current
				removeVariableAt: #ACCESS_TOKEN ].

	"Signal the updated status"
	self announce: CynSessionUpdated
]

{ #category : #private }
CynRestApiClient >> updateAccessTokenFromResponse: aResponse [

	"Retrieve a (new) access token from the specified Response and store it in the receiver"

	| headers newAccessToken |

	headers := aResponse headers
		ifNil: [ ^ self ].

	newAccessToken := (headers get: #'cp-access-token')
		ifNil: [ ^ self ].

	self setAccessToken: newAccessToken
]
