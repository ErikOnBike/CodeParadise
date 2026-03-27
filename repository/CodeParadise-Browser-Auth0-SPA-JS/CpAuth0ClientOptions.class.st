Class {
	#name : #CpAuth0ClientOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0ClientOptions >> authorizationParams [

	^ options at: #authorizationParams:
]

{ #category : #accessing }
CpAuth0ClientOptions >> authorizationParams: anAuth0AuthorizationParams [

	options at: #authorizationParams put: anAuth0AuthorizationParams
]

{ #category : #accessing }
CpAuth0ClientOptions >> authorizeTimeoutInSeconds [

	^ options at: #authorizeTimeoutInSeconds:
]

{ #category : #accessing }
CpAuth0ClientOptions >> authorizeTimeoutInSeconds: anInteger [

	options at: #authorizeTimeoutInSeconds put: anInteger
]

{ #category : #accessing }
CpAuth0ClientOptions >> cacheLocation [

	" 'memory' | 'localstorage' "

	^ options at: #cacheLocation:
]

{ #category : #accessing }
CpAuth0ClientOptions >> cacheLocation: aString [

	" 'memory' | 'localstorage' "

	options at: #cacheLocation put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> clientId [

	^ options at: #clientId:
]

{ #category : #accessing }
CpAuth0ClientOptions >> clientId: aString [

	options at: #clientId put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> cookieDomain [

	^ options at: #cookieDomain:
]

{ #category : #accessing }
CpAuth0ClientOptions >> cookieDomain: aString [

	options at: #cookieDomain put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> domain [

	^ options at: #domain:
]

{ #category : #accessing }
CpAuth0ClientOptions >> domain: aString [

	options at: #domain put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> httpTimeoutInSeconds [

	^ options at: #httpTimeoutInSeconds:
]

{ #category : #accessing }
CpAuth0ClientOptions >> httpTimeoutInSeconds: anInteger [

	options at: #httpTimeoutInSeconds put: anInteger
]

{ #category : #accessing }
CpAuth0ClientOptions >> issuer [

	^ options at: #issuer:
]

{ #category : #accessing }
CpAuth0ClientOptions >> issuer: aString [

	options at: #issuer put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> leeway [

	"The value in seconds used to account for clock skew in JWT expirations. Typically, this value is no more than a minute or two at maximum. Defaults to 60s."

	^ options at: #leeway:
]

{ #category : #accessing }
CpAuth0ClientOptions >> leeway: anInteger [

	"The value in seconds used to account for clock skew in JWT expirations. Typically, this value is no more than a minute or two at maximum. Defaults to 60s."

	options at: #leeway put: anInteger
]

{ #category : #accessing }
CpAuth0ClientOptions >> legacySameSiteCookie [

	^ options at: #legacySameSiteCookie:
]

{ #category : #accessing }
CpAuth0ClientOptions >> legacySameSiteCookie: aBoolean [

	options at: #legacySameSiteCookie put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> nowProvider [

	"Modify the value used as the current time during the token validation.
	Note: Using this improperly can potentially compromise the token validation."

	^ options at: #nowProvider:
]

{ #category : #accessing }
CpAuth0ClientOptions >> nowProvider: anIntegerOrPromise [

	"Modify the value used as the current time during the token validation.
	Note: Using this improperly can potentially compromise the token validation."

	options at: #nowProvider put: anIntegerOrPromise
]

{ #category : #'accessing - convenience' }
CpAuth0ClientOptions >> nowProviderBlock: aBlock [

	"Modify the value used as the current time during the token validation.
	Note: Using this improperly can potentially compromise the token validation.

	The specified Block should answer the current time value."

	self nowProvider: (CpJavaScriptPromise on: [ :resolveBlock :rejectBlock |
		resolveBlock value: aBlock value ])
]

{ #category : #accessing }
CpAuth0ClientOptions >> sessionCheckExpiryDays [

	^ options at: #sessionCheckExpiryDays:
]

{ #category : #accessing }
CpAuth0ClientOptions >> sessionCheckExpiryDays: anInteger [

	options at: #sessionCheckExpiryDays put: anInteger
]

{ #category : #accessing }
CpAuth0ClientOptions >> sessionTransferTokenQueryParamName [

	^ options at: #sessionTransferTokenQueryParamName:
]

{ #category : #accessing }
CpAuth0ClientOptions >> sessionTransferTokenQueryParamName: aString [

	options at: #sessionTransferTokenQueryParamName put: aString
]

{ #category : #accessing }
CpAuth0ClientOptions >> useCookiesForTransactions [

	^ options at: #useCookiesForTransactions:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useCookiesForTransactions: aBoolean [

	options at: #useCookiesForTransactions put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> useDpop [

	^ options at: #useDpop:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useDpop: aBoolean [

	options at: #useDpop put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> useFormData [

	^ options at: #useFormData:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useFormData: aBoolean [

	options at: #useFormData put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> useMrrt [

	^ options at: #useMrrt:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useMrrt: aBoolean [

	options at: #useMrrt put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> useRefreshTokens [

	^ options at: #useRefreshTokens:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useRefreshTokens: aBoolean [

	options at: #useRefreshTokens put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> useRefreshTokensFallback [

	^ options at: #useRefreshTokensFallback:
]

{ #category : #accessing }
CpAuth0ClientOptions >> useRefreshTokensFallback: aBoolean [

	options at: #useRefreshTokensFallback put: aBoolean
]

{ #category : #accessing }
CpAuth0ClientOptions >> workerUrl [

	^ options at: #workerUrl:
]

{ #category : #accessing }
CpAuth0ClientOptions >> workerUrl: aString [

	options at: #workerUrl put: aString
]
