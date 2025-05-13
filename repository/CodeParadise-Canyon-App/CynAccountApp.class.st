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
