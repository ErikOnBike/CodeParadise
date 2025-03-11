Class {
	#name : #CpRestApiClient,
	#superclass : #CpBaseModel,
	#instVars : [
		'baseUrl',
		'accessToken'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CpRestApiClient class >> baseUrl: aString [

	"Answer an instance of the receiver for the specified base URL
	(all requests will add their URI to access specific resources).

	The base URL can be relative (to the client) or absolute."

	^ self basicNew
		initializeWithBaseUrl: aString ;
		yourself
]

{ #category : #'instance creation' }
CpRestApiClient class >> new [

	self errorNewReplacedBy: #baseUrl:
]

{ #category : #operations }
CpRestApiClient >> deleteUri: aString timeoutPeriod: anInteger [

	"Perform the DELETE operation with the URI and answer the response content"

	^ self performOperation: #DELETE uri: aString queryParams: nil body: nil timeoutPeriod: anInteger
]

{ #category : #operations }
CpRestApiClient >> getUri: aString timeoutPeriod: anInteger [

	"Perform the GET operation with the URI and answer the response content"

	^ self performOperation: #GET uri: aString queryParams: nil body: nil timeoutPeriod: anInteger
]

{ #category : #'response handling' }
CpRestApiClient >> handleErrorResponse: aResponse [

	"Handle the error response by signaling an MaRestError (to be handled higher up).
	In case an expired session, simply answer nil and do not signal an Error."

	"Check for an expired session"
	(aResponse status = MaRestError codeUnauthorized and: [ accessToken isNotNil ])
		ifTrue: [
			self setAccessToken: nil.

			"Announce the session has expired.
			Answer nil to indicate there is no valid response."
			self announce: CpSessionExpired.
			^ nil ].

	^ [
		| errorDescription |
		errorDescription := aResponse text await.
		errorDescription ifEmpty: [ errorDescription := aResponse statusText ifEmpty: [ 'Unspecified error' ] ].
		MaRestError signal: errorDescription withStatusCode: aResponse status
	] on: Error do: [ :error | MaRestError signal: error description withStatusCode: aResponse status ]
]

{ #category : #'response handling' }
CpRestApiClient >> handleSuccessfulResponse: aResponse [

	"Answer the Response's content (assuming status is in 200-299 range)"

	(aResponse headers get: 'Content-Type')
		ifNotNil: [ :contentType |
			(contentType includesSubstring: 'application/json')
				ifTrue: [ ^ aResponse json await ] ].

	^ aResponse text await
]

{ #category : #testing }
CpRestApiClient >> hasAccessToken [

	^ accessToken isNotNil
]

{ #category : #'initialize - release' }
CpRestApiClient >> initialize [

	super initialize.

	"If an access token is persisted, retrieve it"
	(CpClientEnvironment current variableAt: #ACCESS_TOKEN)
		ifNotNil: [ :newAccessToken | self setAccessToken: newAccessToken ]
]

{ #category : #initialization }
CpRestApiClient >> initializeWithBaseUrl: aString [

	self initialize.

	baseUrl := aString
]

{ #category : #operations }
CpRestApiClient >> patchUri: uriString body: bodyString timeoutPeriod: anInteger [

	"Perform the PATCH operation with the URI and body and answer the response content"

	^ self performOperation: #PATCH uri: uriString queryParams: nil body: bodyString timeoutPeriod: anInteger
]

{ #category : #private }
CpRestApiClient >> performOperation: aSymbol uri: uriString queryParams: aDictionary body: bodyString timeoutPeriod: anInteger [

	"Perform the specified operation with URI and body (can be nil) and answer the response content"

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
				haveParams
					ifTrue: [ stream nextPut: $& ]
					ifFalse: [
						stream nextPut: $?.
						haveParams := true ].
				stream
					nextPutAll: (CpGlobalThis encodeURIComponent: key) ;
					nextPut: $= ;
					nextPutAll: (CpGlobalThis encodeURIComponent: value) ] ] ].

	"Create request"
	fetch := CpGlobalThis
		fetch: url
		withOptions: {
			#method -> aSymbol.
			#headers -> headers.
			#body -> bodyString.
			#mode -> #cors.
			#redirect -> #error.
			#priority -> #high.
			#signal -> (CpBrowserAbortSignal timeout: anInteger) } asDictionary.

	"Retrieve response"
	response := fetch await.
self traceCr: 'hiero'.
	"Extract (new) access token"
	self updateAccessTokenFromResponse: response.

	"Handle the specified response answering the response content
	or signal an Error (i.e. when status not in the success range 200 - 299)"
	^ (response status between: 200 and: 299)
		ifTrue: [ self handleSuccessfulResponse: response ]
		ifFalse: [ self handleErrorResponse: response ]
]

{ #category : #accessing }
CpRestApiClient >> performTimeoutPeriod [

	"Answer the number of milliseconds before a request should time out"

	^ 8000
]

{ #category : #operations }
CpRestApiClient >> postUri: uriString body: bodyString timeoutPeriod: anInteger [

	"Perform the POST operation with the URI and body and answer the response content"

	^ self performOperation: #POST uri: uriString queryParams: nil body: bodyString timeoutPeriod: anInteger
]

{ #category : #operations }
CpRestApiClient >> putUri: uriString body: bodyString timeoutPeriod: anInteger [

	"Perform the PUT operation with the URI and body and answer the response content"

	^ self performOperation: #PUT uri: uriString queryParams: nil body: bodyString timeoutPeriod: anInteger
]

{ #category : #accessing }
CpRestApiClient >> requestTimeoutPeriod [

	"Answer the number of milliseconds before a request should time out"

	^ 8000
]

{ #category : #operations }
CpRestApiClient >> reset [

	"Reset the receiver, removing the access token"

	accessToken := nil
]

{ #category : #private }
CpRestApiClient >> setAccessToken: aString [

	"Store the specified (new) access token in the receiver.
	It might be nil to indicating the previous value has expired."

	"Validate the access token is usable (might be empty to specify it is expired)"
	(aString isNotNil and: [ (CpTokenPropertyConstraint default isValid: aString) not ])
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
	self announce: CpSessionUpdated
]

{ #category : #private }
CpRestApiClient >> updateAccessTokenFromResponse: aResponse [

	"Retrieve a (new) access token from the specified Response and store it in the receiver"

	| headers newAccessToken |

	headers := aResponse headers
		ifNil: [ ^ self ].

	newAccessToken := (headers get: #'cp-access-token')
		ifNil: [ ^ self ].

	self setAccessToken: newAccessToken
]
