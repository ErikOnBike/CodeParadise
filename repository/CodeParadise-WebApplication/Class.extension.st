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

	| firstLowercaseIndex secondUppercaseIndex |

	firstLowercaseIndex := name findFirst: [ :each | each isLowercase ].
	firstLowercaseIndex < 2
		ifTrue: [ ^ name asString ].

	secondUppercaseIndex := name findNext: [ :each | each isUppercase ] after: firstLowercaseIndex.
	secondUppercaseIndex = 0
		ifTrue: [ ^ name asString allButFirst: firstLowercaseIndex - 2 ].

	^ secondUppercaseIndex <= 4
		ifTrue: [ name asString allButFirst: secondUppercaseIndex - 1 ]
		ifFalse: [ name asString allButFirst: firstLowercaseIndex - 2 ]

]
