Class {
	#name : #CpAuth0PopupLoginOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0PopupLoginOptions >> authorizationParams [

	^ options at: #authorizationParams:
]

{ #category : #accessing }
CpAuth0PopupLoginOptions >> authorizationParams: anAuth0AuthorizationParams [

	options at: #authorizationParams put: anAuth0AuthorizationParams
]
