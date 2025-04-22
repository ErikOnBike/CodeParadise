Extension { #name : #CpCanyonLoginAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> addClientChangeHandlers [

	"Add client-side only change handlers.

	Implementation:
	Since login/logout are client side methods, announcing state changes should
	be done when the #success instance variable changes. Changing the #success:
	setter method would make this method's implementation to appear in the
	server environment as well. Therefore use the Announcement mechanism to
	listen to changes in the receiver and keep this code separate for the client
	environment only."

	<environment: #browser>

	super addClientChangeHandlers.

	self
		when: (CpPropertyChanged name: #success) send: #loginChanged to: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> initializeClientProperties [

	<environment: #browser>

	super initializeClientProperties.

	CpPropertyEntity restApiClient hasAccessToken
		ifTrue: [ success := true ].

	CpPropertyEntity restApiClient
		when: CpSessionExpired send: #sessionExpired to: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> isLoggedIn [

	"Answer whether the receiver has logged in successfully"

	^ success
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> loggedIn [

	self announce: CpCanyonAccountLoggedIn
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> loggedOut [

	self announce: CpCanyonAccountLoggedOut
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> login [

	"Login by perform the REST API call.

	Implementation:
	Login is a POST call to the login endpoint."

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> loginChanged [

	success
		ifTrue: [ self loggedIn ]
		ifFalse: [ self loggedOut ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> logout [

	"Logout by resetting the REST API Client and setting the success status field"

	self restApiClient reset.
	success := false
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount >> sessionExpired [

	"The REST API session expired, I'm no longer logged in"

	success := false
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonLoginAccount class >> uri [

	^ '/accounts?action=login'
]
