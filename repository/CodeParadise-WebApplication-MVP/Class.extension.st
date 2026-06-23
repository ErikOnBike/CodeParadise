Extension { #name : #Class }

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> addPropertySlotDefinitionMethodsForSlot: aSlot to: aCollection [

	"Add method selectors for PropertySlotDefiniions for the specified Slot
	to the specified Collection.

	Implementation:
	Collect methods to execute. Since methods can be overridden in superclasses,
	only store the method selectors which will be performed on the receiver. The
	order of methods is kept (from methods defined in Object to methods defined
	in the receiver) for reproducability."

	"Iterate from Object to the receiver"
	self name == #Object
		ifFalse: [ ^ self superclass addPropertySlotDefinitionMethodsForSlot: aSlot to: aCollection ].

	(Pragma allNamed: #propertySlotDefinition: in: self) do: [ :each |

		"Only process definition for which the Class actually exists,
		otherwise write a warning to the Transcript."
		(Smalltalk classNamed: each argument)
			ifNotNil: [ :class | aCollection addIfNotPresent: each methodSelector ]
			ifNil: [ self warnCr: ('Unknown Class {1} in property slot definition of {2}' format: { each argument asString . each method printString }) ] ]
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> allPropertySlotsDo: aBlock [

	"Evaluate the specified Block with all the PropertySlots of the receiver and its superclasses
	in the order from Object to the receiver"

	self classLayout allSlotsDo: [ :each |
		each isPropertySlot
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> hasPropertySlotNamed: aSymbol [

	"Answer whether the receiver has a PropertySlot with the specified name"

	self classLayout
		resolveSlot: aSymbol
		ifFound: [ :slot |
			slot isPropertySlot
				ifTrue: [ ^ true ] ]
		ifNone: [ "ignore here, will answer below" ].

	^ false
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> propertySlotDefinitionsForSlot: aSlot [

	"Answer a new PropertySlotDefiniions for the specified Slot.

	The PropertySlotDefinitions are specified in a Pragma in class side methods:
		<propertySlotDefinition: #className>.

	Where the Class name refers to the class/type of definition (to allow different
	definitions for different purposes to co-exist without name clashes)."

	| propertySlotDefinitions methodSelectors |

	propertySlotDefinitions := CpPropertySlotDefinitions new.

	"Collect method selectors (in order)"
	methodSelectors := OrderedCollection new.
	self addPropertySlotDefinitionMethodsForSlot: aSlot to: methodSelectors.

	"Perform methods"
	methodSelectors do: [ :each |
		self perform: each with: propertySlotDefinitions ].

	^ propertySlotDefinitions
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> propertySlotNamed: aSymbol [

	"Answer the PropertySlot with the specified name.
	An Error is signaled if the Slot does not exist or is not a PropertySlot."

	self classLayout
		resolveSlot: aSymbol
		ifFound: [ :slot |
			slot isPropertySlot
				ifTrue: [ ^ slot ] ]
		ifNone: [ "ignore here, will signal below" ].

	CpPropertySlotNotFound signalForName: aSymbol
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Class >> updatePropertySlotDefinitions [

	"Update the PropertySlots of the receiver"

	self allPropertySlotsDo: [ :each |
		each updatePropertySlotDefinitions ]
]
