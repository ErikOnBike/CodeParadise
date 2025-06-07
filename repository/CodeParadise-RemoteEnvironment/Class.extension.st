Extension { #name : #Class }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> beLoaded [

	"Empty method, but referring to this method directly (ie [[[ CpTransition beLoaded ]]])
	from a method to be installed in a ClientEnvironment will also install the receiver (class)
	in the ClientEnvironment"

	<applicationExtension>
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> containsDebuggingCode [

	"Answer whether the receiver contains debugging code.

	Implementation:
	Currently only breakpoints, since these can't be decoded in
	the client environment. See CpServerEnvironment >> #addClass:"

	| checkPresence |

	checkPresence := [ :compiledMethod |
		compiledMethod hasBreakpoint
			ifTrue: [ ^ true ] ].

	self methodDictionary do: checkPresence.
	self class methodDictionary do: checkPresence.

	^ false
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> cpEncodeWith: anEncoder [

	"This extension method should not be present in the ClientEnvironment!
	Otherwise classes within Announcements will be installed on the server."

	<serverEnvironment>

	anEncoder encodeClass: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> cpInstVarNames [

	"Answer the instance variable names for non-virtual slots.

	Be aware: this is a temporary implementation.
	When only using instance variable names of non-virtual slots, the size of the
	instances in the tiny image will match the ones in the 'server' image.

	Full support for slots is on the to-do list."

	^ self instVarNames select: [ :each |

		"Allow only non-virtual slots"
		self
			slotNamed: each
			ifFound: [ :slot | slot isVirtual not ]
			ifNone: [ true ] ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> errorNewReplacedBy: aString [

	"Signal the receiver should not be instantiated using #new
	but using the specified String. If a Symbol is used in the
	sending location, it will be recognized as a 'sender' allowing
	refactoring tools to update it.
	If there are mutiple alternatives use: (' or ' join: { #alt1 . #alt2 })"

	<applicationExtension>

	self error: 'Please create new or access current instances of ', self name, ' using method ', aString printString
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> installMethod: aCompiledMethod [

	"Install thw specified CompiledMethod in the receiver"

	<clientEnvironment>

	self installInstanceMethod: aCompiledMethod
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
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
	
	<applicationExtension>

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

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> postInstall [

	"Perform any necessary initialization after receiver is installed in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super postInstall ]]].
	In case initialization is strictly for the class itself (and should not be re-executed for
	any subclasses), use #postInstallOnce"

	<clientEnvironment>

	(self classSide includesSelector: #postInstallOnce)
		ifTrue: [ self postInstallOnce ]

]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> postInstallOnce [

	"Perform any necessary initialization after receiver is installed in the ClientEnvironment.
	In contrast with #postInstall, this method should NOT chain post install methods from the
	super class."

	<clientEnvironment>

]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> postSnapshot [

	"Perform any necessary initialization after receiver is (re)started in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super postSnapshot ]]].
	In case initialization is strictly for the class itself (and should not be re-executed for
	any subclasses), use #postSnapshotOnce"

	<applicationExtension>

	(self classSide includesSelector: #postSnapshotOnce)
		ifTrue: [ self postSnapshotOnce ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> postSnapshotOnce [

	"Perform any necessary initialization after receiver is (re)started in the ClientEnvironment.
	In contrast with #postSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> preSnapshot [

	"Perform any necessary preparation before receiver is saved in the ClientEnvironment.
	In contrast with a class side #initialize, this method should be called from subclasses
	using [[[ super preSnapshot ]]].
	In case preparation is strictly for the class itself (and should not be re-executed for
	any subclasses), use #preSnapshotOnce"

	<applicationExtension>

	(self classSide includesSelector: #preSnapshotOnce)
		ifTrue: [ self preSnapshotOnce ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> preSnapshotOnce [

	"Perform any necessary preparation before receiver is saved in the ClientEnvironment.
	In contrast with #preSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> removeMethod: aCompiledMethod [

	"Remove the specified CompiledMethod from the receiver"

	<clientEnvironment>

	self removeInstanceMethod: aCompiledMethod
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> subclass: className instanceVariableNames: instVarNames classVariableNames: classVarNames classInstanceVariableNames: classInstVarNames [

	"Placeholder for method in tiny image, to prevent Pharo from complaining about missing method"

	<clientEnvironment>
]
