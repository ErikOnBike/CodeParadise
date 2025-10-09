"
I am a Canyon App for Apps where an account is required for the
user. My (additional) responsibility is limited to maintaining the
login account and handling user/account login/logout events.

Since the actual login and logout actions can be implemented
in many ways, there is no default mechanism present. Please
let your subclass handle this in a friendly way for the user.

"
Class {
	#name : #CynAccountApp,
	#superclass : #CynApp,
	#instVars : [
		'account'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #tags }
CynAccountApp class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'error handling' }
CynAccountApp >> handleUnhandledError: anError [

	"An Error is signaled which is not handled elsewhere. Handle it here.
	Answer a Boolean indicating whether the error is sufficiently handled to
	consider it 'fixed'.

	Implementation:
	Write log if an internal error (not being a 500 from server) occurred.
	Server side errors will have been logged already."

	(super handleUnhandledError: anError)
		ifTrue: [ ^ true ].

	"We are only interested in internal client errors (the others are already logged on the server itself)"
	anError statusCode = 0
		ifFalse: [ ^ false ].

	[ self sendClientLogFor: anError ] on: Error do: [ :error |
		self class ifDevelopment: [ self warnCr: 'Can''t send log to server: ', error printString ] ].

	^ false
]

{ #category : #'event handling' }
CynAccountApp >> handleUserLoggedIn [

	"The user logged in to her account"
]

{ #category : #'event handling' }
CynAccountApp >> handleUserLoggedOut [

	"The user logged out of her account"
]

{ #category : #initialization }
CynAccountApp >> initialize [

	super initialize.

	"Ping the server to make sure any potential access token is checked
	(and thereby the state of the login will be set correctly during its
	initialization in the following lines)"
	CynPropertyEntity restApiClient ping.

	account := CynLoginAccount new.
	account
		when: CynAccountLoggedIn send: #handleUserLoggedIn to: self ;
		when: CynAccountLoggedOut send: #handleUserLoggedOut to: self
]

{ #category : #logging }
CynAccountApp >> sendClientLogFor: anError [

	"Send client log message to server to store there using Beacon API (i.e. async)"

	| logObject restApiClient accessToken stack |

	"Without access token, logging will not work (accessToken may be expired though)"
	restApiClient := CynPropertyEntity restApiClient ifNil: [ ^ self ].		
	accessToken := restApiClient getAccessToken ifNil: [ ^ self ].

	stack := String streamContents: [ :stream |
		| context origin |
		context := anError isAnnouncedException
			ifTrue: [ anError announcerContext ifNil: [ anError exception signalContext ifNotNil: [ anError exception signalerContext ] ] ]
			ifFalse: [ anError signalContext ifNotNil: [ anError signalerContext ] ].
		origin := (self locationFromSignalerContext: context)
			ifNotNil: [ :location | location method ]
			ifNil: [ anError signaler ].
		origin ifNotNil: [
			stream
				nextPutAll: '=== Origin seems to be ===' ; lf ;
				print: origin ;
				lf ].
		stream
			nextPutAll: '=== Error ===' ; lf ;
			print: anError ;
			lf ;
			nextPutAll: '=== Stack trace ===' ; lf ;
			print: context ;
			lf ].

	logObject := {
		#accessToken -> accessToken.
		#level -> #error.
		#message -> anError description.
		#stack -> (stack replaceAll: Character cr with: Character lf) } asDictionary.

	CpBrowserNavigator current
		sendBeacon: restApiClient baseUrl, '/log' data: (CpJavaScriptJSON stringify: logObject)
]
