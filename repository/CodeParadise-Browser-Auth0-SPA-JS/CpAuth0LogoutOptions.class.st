Class {
	#name : #CpAuth0LogoutOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0LogoutOptions >> clientId [

	^ options at: #clientId:
]

{ #category : #accessing }
CpAuth0LogoutOptions >> clientId: aString [

	options at: #clientId put: aString
]

{ #category : #accessing }
CpAuth0LogoutOptions >> logoutParams [

	^ options at: #logoutParams:
]

{ #category : #accessing }
CpAuth0LogoutOptions >> logoutParams: aLogoutParams [

	options at: #logoutParams put: aLogoutParams
]

{ #category : #accessing }
CpAuth0LogoutOptions >> onRedirect [

	"Used to control the redirect and not rely on the SDK to do the actual redirect."

	^ options at: #onRedirect:
]

{ #category : #accessing }
CpAuth0LogoutOptions >> onRedirect: aJavaScriptFunction [

	"Used to control the redirect and not rely on the SDK to do the actual redirect."

	options at: #onRedirect put: aJavaScriptFunction
]

{ #category : #accessing }
CpAuth0LogoutOptions >> openUrl [

	"Used to control the redirect and not rely on the SDK to do the actual redirect.

	Set to false to disable the redirect, or provide a function to handle the actual redirect yourself."

	^ options at: #openUrl:
]

{ #category : #accessing }
CpAuth0LogoutOptions >> openUrl: aJavaScriptFunction [

	"Used to control the redirect and not rely on the SDK to do the actual redirect.

	Set to false to disable the redirect, or provide a function to handle the actual redirect yourself."

	options at: #openUrl put: aJavaScriptFunction
]
