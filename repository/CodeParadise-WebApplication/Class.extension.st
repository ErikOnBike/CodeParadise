Extension { #name : #Class }

{ #category : #'*CodeParadise-WebApplication' }
Class >> nameWithoutPrefix [

	"Answer a String representing the receiver's name without any prefixes.

	Implementation: Prefixes are either 2 or 3 character Strings coming before a
	capitalized name. For prefixes with all uppercase characters the first lowercase
	character indicates where the name starts (just one character before it ;-).
	If no prefix can be found the full name is answered.
	For example:
		Class nameWithoutPrefix -> 'Class'
		SUnitVisitor nameWithoutPrefix -> 'UnitVisitor' 
		CpCommunicator nameWithoutPrefix -> 'Communicator'
		ClyQuery nameWithoutPrefix -> 'Query'
		RBNode nameWithoutPrefix -> 'Node'
		SDL2Handle nameWithoutPrefix -> 'Handle'
	"
	
	<webApplicationExtension>

	| className firstLowercaseIndex secondUppercaseIndex |

	"Retrieve class name using method, since in P11 the class layout is different than
	P10/P12 and it would access the wrong instVar in the tiny Smalltalk image in the
	remote environment which is based on P10/P12 layout."
	className := self name.

	firstLowercaseIndex := className findFirst: [ :each | each isLowercase ].
	firstLowercaseIndex < 2
		ifTrue: [ ^ className asString ].

	secondUppercaseIndex := className findNext: [ :each | each isUppercase ] after: firstLowercaseIndex.
	secondUppercaseIndex = 0
		ifTrue: [ ^ className asString allButFirst: firstLowercaseIndex - 2 ].

	^ secondUppercaseIndex <= 4
		ifTrue: [ className asString allButFirst: secondUppercaseIndex - 1 ]
		ifFalse: [ className asString allButFirst: firstLowercaseIndex - 2 ]

]
