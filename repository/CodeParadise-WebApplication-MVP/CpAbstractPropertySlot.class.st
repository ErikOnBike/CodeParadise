"
I am the base class for PropertySlots.
PropertySlots allow definitions to be added to Slots which can be used
for different purposes. The definitions are described using methods
having the Pragma <propertySlotDefinition: #SomeClassName>. The Class
name provided as argument is taken as the type or category of the
definitions in the method. If no Class exists with the specified name,
a warning will be written to the Transcript but no error is signaled.

"
Class {
	#name : #CpAbstractPropertySlot,
	#superclass : #Slot,
	#instVars : [
		'info',
		'definitions'
	],
	#category : #'CodeParadise-WebApplication-MVP-Slots'
}

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleClassAdded: aClassAdded [

	"If a Class is added, check if any PropertySlots need updating.

	Implementation:
	A new Class will have its normal definition attached so no work there.
	The special situation is a property slot definition referring to a
	Class which did not exist before, but is now added. Check for the
	reference to this new Class' name."

	(CpFinder allMethodsSending: aClassAdded classAdded name) do: [ :each |
		self halt.
		self updatePropertySlotDefinitionsForMethod: each ]
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleClassModified: aClassModifiedDefinition [

	"If a Class definition is modified, check if any PropertySlots need updating.

	Implementation:
	By default, the property slot definitions are updated during modification.
	If some definition is depending on some other properties and/or order of
	properties, a subclass (of the Class containing the definition) might override
	this behavior (in a class side method)."

	"Nothing to do here (see comment above)"
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleClassRemoved: aClassRemoved [

	"If a Class is removed, check if any PropertySlots need updating.

	Implementation:
	The special situation is a property slot definition referring to a
	Class which did exist before, but is now removed. Check for the
	reference to this old Class' name."

	(CpFinder allMethodsSending: aClassRemoved classRemoved name) do: [ :each |
		self halt.
		self updatePropertySlotDefinitionsForMethod: each ]
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleMethodAdded: aMethodAdded [

	"If a CompiledMethod is added, check if any PropertySlots need updating"

	self updatePropertySlotDefinitionsForMethod: aMethodAdded method
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleMethodModified: aMethodModified [

	"If a CompiledMethod is modified, check if any PropertySlots need updating.

	Implementation:
	Check both the old and the new CompiledMethod, since modification might have
	changed the definitions."

	(self updatePropertySlotDefinitionsForMethod: aMethodModified oldMethod)
		ifFalse: [ self updatePropertySlotDefinitionsForMethod: aMethodModified newMethod ]
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> handleMethodRemoved: aMethodRemoved [

	"If a CompiledMethod is removed, check if any PropertySlots need updating"

	self updatePropertySlotDefinitionsForMethod: aMethodRemoved methodRemoved
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> registerInterestInMethodChanges [

	<script>

	self unregisterInterestInMethodChanges.

	self codeChangeAnnouncer weak
		when: MethodAdded send: #handleMethodAdded: to: self ;
		when: MethodModified send: #handleMethodModified: to: self ;
		when: MethodRemoved send: #handleMethodRemoved: to: self ;
		when: ClassAdded send: #handleClassAdded: to: self ;
		when: ClassModifiedClassDefinition send: #handleClassModified: to: self ;
		when: ClassRemoved send: #handleClassRemoved: to: self
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> unregisterInterestInMethodChanges [

	<script>

	self codeChangeAnnouncer unsubscribe: self
]

{ #category : #'event handling' }
CpAbstractPropertySlot class >> updatePropertySlotDefinitionsForMethod: aCompiledMethod [

	"Update all PropertySlotDefinitions if the specified CompiledMethod contains our definition Pragma.
	Updating will be performed on the Class where the specified CompiledMethod is compiled in and also
	any subclasses it has (because slot definitions are inherited too).

	Answer a Boolean indicating if updating has been performed."

	aCompiledMethod pragmasDo: [ :eachPragma |
		eachPragma selector == #propertySlotDefinition:
			ifTrue: [

				"Update definitions for Class and all its subclasses"
				aCompiledMethod methodClass withAllSubclassesDo: [ :eachClass |
					eachClass updatePropertySlotDefinitions ].

				"Stop after first full update (no need to perform that on a subsequent match)"
				^ true ] ].

	^ false
]

{ #category : #comparing }
CpAbstractPropertySlot >> = anObject [

	"Answer whether the receiver is equal to the specified Object"

	self == anObject
		ifTrue: [ ^ true ].

	"Use the accessor for #info instead of direct instance variable,
	because the info value is calculated."
	^ super = anObject
		and: [ self info = anObject info ]
]

{ #category : #printing }
CpAbstractPropertySlot >> definitionOn: aStream [

	"Store the receiver's definition on the specified Stream.

	Implementation:
	Slots are either defined by reimplementing #definitionOn: or #printOn:.
	It is chosen to use #definitionOn: since it seems to specify the intent
	better. Beware that mose Slots however reimplement #printOn:."

	aStream
		store: self name ;
		nextPutAll: ' => ' ;
		nextPutAll: self class name.

	info ifNotNil: [ :infoDictionary |
		infoDictionary ifNotEmpty: [
			aStream nextPutAll: ' info: '.
			infoDictionary asPropertySlotDefinitionOn: aStream ] ]
]

{ #category : #testing }
CpAbstractPropertySlot >> hasSameDefinitionAs: aSlot [

	"Answer whether the receiver and the specified Slot share the same definition.
	This method is used to check if anything changed when saving a Class definition.
	If false is answered, instances using the original slot are morphed so they can
	start using the new slot."

 	^ (super hasSameDefinitionAs: aSlot) and: [ self info = aSlot info ]
]

{ #category : #comparing }
CpAbstractPropertySlot >> hash [

	"Answer the hash of the receiver"

	^ super hash
		bitXor: self info hash
]

{ #category : #accessing }
CpAbstractPropertySlot >> info [

	"Answer the info for the receiver as an Array of Associations.

	Implementation:
	Although the info is specified and represented as an Array, it is internally
	stored as an OrderedDictionary. This means that if the same key is set twice,
	the latter value is used."

	^ info ifNotNil: [ :infoDictionary |
		infoDictionary associations ]
]

{ #category : #accessing }
CpAbstractPropertySlot >> info: anArray [

	"Set the info for the receiver to the specified Array of Associations.

	Implementation:
	Although the info is specified and represented as an Array, it is internally
	stored as an OrderedDictionary. This means that if the same key is set twice,
	the latter value is used."

	info := OrderedDictionary newFrom: anArray
]

{ #category : #initialization }
CpAbstractPropertySlot >> initialize: anObject [

	super initialize: anObject.

	"self halt"
]

{ #category : #'class building' }
CpAbstractPropertySlot >> installingIn: aClass [

	"Install the receiver in the specified Class.

	Implementation:
	Now that the receiver is being installed into a Class, ensure the definitions
	of the receiver are also updated. This could not have been done when setting
	the owningClass, since the owningClass is not fully ready yet at that time
	(it lacks a superclass for example)."

	super installingIn: aClass.

	self updatePropertySlotDefinitions
]

{ #category : #testing }
CpAbstractPropertySlot >> isPropertySlot [

	^ true
]

{ #category : #updating }
CpAbstractPropertySlot >> updatePropertySlotDefinitions [

	"Update the definitions of the receiver.

	Implementation:
	Class side methods can define definitions, so let the owning Class
	extract the current definitions."

	definitions := owningClass propertySlotDefinitionsForSlot: self
]
