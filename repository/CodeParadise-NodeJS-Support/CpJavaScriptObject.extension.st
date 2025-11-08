Extension { #name : #CpJavaScriptObject }

{ #category : #'*CodeParadise-NodeJS-Support' }
CpJavaScriptObject class >> isProductionEnvironment [

	^ self nodeEnvironment = #production
]

{ #category : #'*CodeParadise-NodeJS-Support' }
CpJavaScriptObject class >> isTestEnvironment [

	^ self nodeEnvironment = #test
]

{ #category : #'*CodeParadise-NodeJS-Support' }
CpJavaScriptObject class >> nodeEnvironment [

	^ ((CpGlobalThis propertyAt: #process)
		propertyAt: #env)
			propertyAt: #NODE_ENV
]
