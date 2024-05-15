Extension { #name : 'ProtoObject' }

{ #category : '*CodeParadise-RemoteEnvironment' }
ProtoObject >> crError: aString [

	self deprecated: 'Use #errorCr: instead' transformWith: '`@receiver crError: `@argument' -> '`@receiver errorCr: `@argument'.
	self errorCr: aString
]

{ #category : '*CodeParadise-RemoteEnvironment' }
ProtoObject >> errorCr: aString [

	self traceCr: 'ERROR: ', aString
]

{ #category : '*CodeParadise-RemoteEnvironment' }
ProtoObject >> warnCr: aString [

	self traceCr: 'WARNING: ', aString
]
