Extension { #name : #CynLoginAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> addClientChangeHandlers [

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
		when: (CynPropertyChanged name: #success) send: #loginChanged to: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> addSetting: aSymbol value: anObject [

	"Add the specified setting to the receiver.

	Implementation:
	This will be communicated to the server immediately, but we don't wait for the acknowledge."

	settings at: aSymbol put: anObject.

	self restSettingAt: aSymbol put: anObject
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> handleSessionExpired [

	"The REST API session expired, I'm no longer logged in"

	success := false
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> initializeClientProperties [

	<environment: #browser>

	super initializeClientProperties.

	CynPropertyEntity restApiClient hasAccessToken
		ifTrue: [
			success := true.

			"Load settings (async) by faking a removal of a setting"
			self restSettingAt: #fakeReload put: nil ].

	CynPropertyEntity restApiClient
		when: CynSessionExpired send: #handleSessionExpired to: self
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> isLoggedIn [

	"Answer whether the receiver has logged in successfully"

	^ success
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> loggedIn [

	self announce: CynAccountLoggedIn
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> loggedOut [

	self announce: CynAccountLoggedOut
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> login [

	"Login by perform the REST API call.

	Implementation:
	Login is a POST call to the login endpoint."

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> loginChanged [

	success
		ifTrue: [ self loggedIn ]
		ifFalse: [ self loggedOut ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> logout [

	"Logout by resetting the REST API Client and setting the success status field"

	self restApiClient reset.
	success := false
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> removeSetting: aSymbol [

	"Remove the specified setting from the receiver.

	Implementation:
	This will be communicated to the server immediately, but we don't wait for the acknowledge."

	settings removeKey: aSymbol ifAbsent: [ "ignore" ].

	self restSettingAt: aSymbol put: nil
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> restSettingAt: aSymbol put: anObject [

	"Change the specified setting using the REST service.

	Implementation:
	This will be communicated to the server immediately, but we don't wait for the acknowledge."

	CpGlobalThis defer: [
		(self restApiClient patchUri: self settingsUri body: (CpJavaScriptJSON stringify: (Dictionary with: aSymbol -> anObject asJsonObjectValue)) timeoutPeriod: self restUpdateTimeoutPeriod)
			ifNotNil: [ :content | settings merge: content ] ]
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount >> settingsUri [

	^ '{1}/current/settings' format: { CynAccount uri }
]

{ #category : #'*CodeParadise-Canyon-App' }
CynLoginAccount class >> uri [

	^ '/accounts?action=login'
]
