Extension { #name : #CpNodeJSRestRequest }

{ #category : #'*CodeParadise-Canyon-Data' }
CpNodeJSRestRequest >> accountId [

	"Answer the custom property #accountId (signal an error if this value is not present)"

	^ (self propertyAt: #accountId)
		ifNil: [ self error: 'No accountId present in the REST Request' ]
]
