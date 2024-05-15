Extension { #name : 'Class' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> beLoaded [

	"Empty method, but referring to this method directly (ie [[[ CpTransition beLoaded ]]])
	from a method to be installed in a ClientEnvironment will also install the receiver (class)
	in the ClientEnvironment"

	<applicationExtension>
]

{ #category : '*CodeParadise-RemoteEnvironment' }
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

{ #category : '*CodeParadise-RemoteEnvironment' }
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
		self flag: #TODO.	"A better check or preventing this situation all together would be useful"
		(class isObsolete and: [ (Smalltalk classNamed: #ESDevTools) isNotNil ])
			ifTrue: [ self halt ].

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
				requiredClasses addIfNotPresent: class ] ].

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

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> cpEncodeWith: anEncoder [

	"This extension method should not be present in the ClientEnvironment!
	Otherwise classes within Announcements will be installed on the server."

	self flag: #todo. "Add logic which works for both ClientEnvironment and ServerEnvironment"
	anEncoder encodeClass: self
]

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> cpRequiredClassesDo: anOneArgBlock [

	"Perform the specified Block on the receiver's required classes 'in order of dependency'"

	"Handle classes referenced in class and instance methods"
	self classSide referencedClasses do: anOneArgBlock.
	self instanceSide referencedClasses do: anOneArgBlock
]

{ #category : '*CodeParadise-RemoteEnvironment' }
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

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> postInstallOnce [

	"Perform any necessary initialization after receiver is installed in the ClientEnvironment.
	In contrast with #postInstall, this method should NOT chain post install methods from the
	super class."

	<clientEnvironment>

]

{ #category : '*CodeParadise-RemoteEnvironment' }
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

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> postSnapshotOnce [

	"Perform any necessary initialization after receiver is (re)started in the ClientEnvironment.
	In contrast with #postSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]

{ #category : '*CodeParadise-RemoteEnvironment' }
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

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> preSnapshotOnce [

	"Perform any necessary preparation before receiver is saved in the ClientEnvironment.
	In contrast with #preSnapshot, this method should NOT chain post snapshot methods from the
	super class."

	<applicationExtension>
]

{ #category : '*CodeParadise-RemoteEnvironment' }
Class >> subclass: className instanceVariableNames: instVarNames classVariableNames: classVarNames [

	"Create a new Class in the same package as the receiver"

	<clientEnvironment>

	^ self
		subclass: className
		instanceVariableNames: instVarNames
		classVariableNames: classVarNames
		package: self category
]
