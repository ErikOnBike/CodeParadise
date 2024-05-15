Extension { #name : 'AdditionalMethodState' }

{ #category : '*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	self hasNonEmptyProperties
		ifTrue: [ self warnCr: 'Methods with properties are currently not supported: ' , method printString ].

	anEncoder encodeAdditionalMethodState: self
]

{ #category : '*CodeParadise-RemoteEnvironment' }
AdditionalMethodState >> hasNonEmptyProperties [

	"Answer whether the receiver has non-empty properties.
	(Properties are not supported in the client environment)

	Impementation:
	The property #containsHalt is allowed, because it simply indicates #halt is sent.
	The property #reflectiveMethod is allowed if it has a nil value (meaning 'no value',
	because a meta link has been removed)."

	^ self properties
		ifNotEmpty: [ :properties |
			properties allSatisfy: [ :property |
				property isNil
					or: [ property == #containsHalt
						or: [ property == #reflectiveMethod and: [ (self propertyAt: #reflectiveMethod) isNil ] ] ] ] ]
		ifEmpty: [ false ]
]
