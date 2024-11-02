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
Class >> cpAllRequiredClassesMatching: matchBlock [

	"Answer a collection of Classes the receiver is dependent on in the ClientEnvironment
	and which match the specified (one argument) Block"

	| requiredClasses processingClasses addUniqueClassBlock |

	requiredClasses := OrderedCollection new.
	processingClasses := Set new.

	"Only unique instances should be added"
	addUniqueClassBlock := [ :class |

		"Validate the class is not obsolete. Sometimes during class updates, including Iceberg operations,
		a class can become obsolete. When a debugger in the CodeParadise class loader code is triggered
		during a class update, it might leave such a class obsolete. Installing an obsolete class is of
		course useless."
		class isObsolete
			ifTrue: [ self errorCr: 'Obsolete class ', class name, ' is referenced, please manually remove references. Application(s) might have become unstable.' ]
			ifFalse: [

				"Check for matched classes which are not already in the process of being added"
				((matchBlock value: class) and: [ (processingClasses includes: class) not ])
					ifTrue: [

						"Mark class for processing to prevent infinite recursion"
						processingClasses add: class.

						"First add the super class"
						addUniqueClassBlock value: class superclass.

						"Then add the required classes"
						class cpRequiredClassesDo: addUniqueClassBlock.

						"Because of circular references add the class itself only if not already present"
						requiredClasses addIfNotPresent: class ] ] ].

	"Fire of the process with the receiver"
	addUniqueClassBlock value: self.

	"Because of circular references a superclass can still be added after its subclass, repair this"
	[
		| changed |

		changed := false.
		requiredClasses withIndexDo: [ :each :index |
			| nextIndex |

			"Check if superclass is defined at higher index"
			nextIndex := requiredClasses indexOf: each superclass startingAt: index + 1 ifAbsent: [ 0 ].
			nextIndex > 0
				ifTrue: [
					"Swap sub and super class (it is okay to change collection during #withIndexDo: here)"
					requiredClasses swap: index with: nextIndex.
					changed := true ] ].

		changed ] whileTrue.

	^ requiredClasses
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> cpEncodeWith: anEncoder [

	"This extension method should not be present in the ClientEnvironment!
	Otherwise classes within Announcements will be installed on the server."

	<serverEnvironment>

	anEncoder encodeClass: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Class >> cpRequiredClassesDo: anOneArgBlock [

	"Perform the specified Block on the receiver's required classes 'in order of dependency'"

	"Handle classes referenced (in non server side only methods) in class and instance methods"
	self classSide nonServerReferencedClasses do: anOneArgBlock.
	self instanceSide nonServerReferencedClasses do: anOneArgBlock
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
