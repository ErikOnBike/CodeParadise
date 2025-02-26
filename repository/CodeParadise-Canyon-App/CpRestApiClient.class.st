Class {
	#name : #CpRestApiClient,
	#superclass : #CpBaseModel,
	#instVars : [
		'accessToken'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

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

{ #category : #operations }
CpRestApiClient >> performOperation: aSymbol model: aModel timeoutPeriod: anInteger [

	"Perform the specified operation on the receiver's model and answer the response content.
	If all instances of a Model are to be read, provide the class as model."

	| headers body url fetch response |

	headers := Dictionary new.

	"Add authorization to headers if access token is present (even on public endpoints)"
	accessToken
		ifNotNil: [ headers at: #Authorization put: 'Bearer ', accessToken ].

	"Create body (only relevant for #POST #PUT #PATCH)"
	body := (#(POST PUT PATCH) includes: aSymbol)
		ifTrue: [ CpJavaScriptJSON stringify: aModel asJsonObjectValue ]
		ifFalse: [ nil ].

	"Create URL"
	url := '/api', aModel apiPath.

	"Create request"
	fetch := CpGlobalThis
		fetch: url
		withOptions: {
			#method -> aSymbol.
			#headers -> headers.
			#body -> body.
			#mode -> #cors.
			#redirect -> #error.
			#priority -> #high.
			#signal -> (CpBrowserAbortSignal timeout: anInteger) } asDictionary.

	"Retrieve response"
	response := fetch await.

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

{ #category : #operations }
CpRestApiClient >> updateAccessTokenFromResponse: aResponse [

	"Retrieve a (new) access token from the specified Response and store it in the receiver"

	| headers newAccessToken |

	headers := aResponse headers
		ifNil: [ ^ self ].

	newAccessToken := (headers get: #'cp-access-token')
		ifNil: [ ^ self ].

	self setAccessToken: newAccessToken
]
