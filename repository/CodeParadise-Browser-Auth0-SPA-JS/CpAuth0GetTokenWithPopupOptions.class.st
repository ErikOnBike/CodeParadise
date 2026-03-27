Class {
	#name : #CpAuth0GetTokenWithPopupOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0GetTokenWithPopupOptions >> authorizationParams [

	^ options at: #authorizationParams:
]

{ #category : #accessing }
CpAuth0GetTokenWithPopupOptions >> authorizationParams: anAuth0AuthorizationParams [

	options at: #authorizationParams put: anAuth0AuthorizationParams
]

{ #category : #accessing }
CpAuth0GetTokenWithPopupOptions >> cacheMode [

	" 'cache-only' | 'on' | 'off' "

	^ options at: #cacheMode:
]

{ #category : #accessing }
CpAuth0GetTokenWithPopupOptions >> cacheMode: aString [

	" 'cache-only' | 'on' | 'off' "

	options at: #cacheMode put: aString
]
