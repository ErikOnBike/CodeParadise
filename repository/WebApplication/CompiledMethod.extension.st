Extension { #name : #CompiledMethod }

{ #category : #'*WebApplication' }
CompiledMethod >> bindClassVariablesTo: aClass [

	"Bind class variables to the receiver (replace literal association with the
	class variable association)"

	<clientEnvironment>

	| classVariableClass |

	classVariableClass := Smalltalk at: #ClassVariable.
	1 to: self numLiterals do: [ :index |
		| literal |
		literal := self literalAt: index.
		(literal class == classVariableClass and: [ literal value isNil ])
			ifTrue: [ self literalAt: index put: (aClass classVariableNamed: literal key) ] ]

]

{ #category : #'*WebApplication' }
CompiledMethod >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeCompiledMethod: self
]

{ #category : #'*WebApplication' }
CompiledMethod >> install [
	"Install the receiver in its Class"

	<clientEnvironment>
	self methodClass
		ifNotNil: [ :methodClass | 
			methodClass addSelector: self selector withMethod: self.
			self bindClassVariablesTo: methodClass instanceSide ]
]
