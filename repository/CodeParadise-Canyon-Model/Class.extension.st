Extension { #name : #Class }

{ #category : #'*CodeParadise-Canyon-Model' }
Class >> allInstVarNamesBelow: aClass do: aBlock [

	"Evaluate the specified Block for all instance variables in the order defined.
	The super class' instance variables are evaluated before the receiver's variables.
	Only instance variables of subclasses of the specified Class are handled."

	<canyonModelExtension>

	self superclass
		ifNotNil: [ :sup |
			sup = aClass
				ifFalse: [ sup allInstVarNamesBelow: aClass do: aBlock ] ].

	self instVarNames do: aBlock
]
