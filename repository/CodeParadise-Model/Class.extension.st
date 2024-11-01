Extension { #name : #Class }

{ #category : #'*CodeParadise-Model' }
Class >> allInstVarNamesDo: aBlock [

	"Evaluate the specified Block for all instance variables in the order defined.
	The super class' instance variables are evaluated before the receiver's variables."

	<applicationExtension>

	self superclass
		ifNotNil: [ :sup | sup allInstVarNamesDo: aBlock ].

	self instVarNames do: aBlock
]
