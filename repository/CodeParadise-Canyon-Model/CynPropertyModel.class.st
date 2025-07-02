"
I am a Model containing properties. I announce when my properties have changed.
I am responsible for keeping track of my property values.
My properties can have additional definitions. I don't use these definitions
but make them accessable. Subclasses can use thes definitions to adapt behavior.

Property definitions can be added (automagically) by adding methods which have the
pragma <propertyDefinition>. Such methods will be executed when updating the
definitions because a Class definition changed (or by manually selecting
either #updateAllPropertyDefinitions or #updatePropertyDefinitions of the class involved).

Example:
To create a 'required' flag which is part of a property definition, the following
could be added to the (base) class of the Model (assuming a method exists on that
same class and subclasses which answers the collection of property names which
are required):

```Smalltalk
defineRequiredProperties

	<propertyDefinition>

	self requiredPropertyNames do: [ :each |
		(self propertySlotAt: each) addFlag: #required ]
```

Implementation:
I use a Dictionary to store my property values. This allows a DerivedSlot to be used
to represent properties which have additional constraints. This way CodeParadise's
tiny image can be used with slots although slots are not supported. The PropertySlot
has an #emitValue: and #emitStore: which generate code to access the property Dictionary,
thereby not actually needing a slot instance. Any method accessing an instance
variable will have code generated which accesses the Dictionary directly.

"
Class {
	#name : #CynPropertyModel,
	#superclass : #CpBaseModel,
	#instVars : [
		'data'
	],
	#classInstVars : [
		'propertySlots'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynPropertyModel class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #()
]

{ #category : #'accessing - generated' }
CynPropertyModel class >> calculatedProperties [

	"Generated code. DO NOT EDIT"

	^ #()
]

{ #category : #'event handling' }
CynPropertyModel class >> classDefinitionChanged: aClassModifiedClassDefinition [

	<serverEnvironment>

	(aClassModifiedClassDefinition classAffected inheritsFrom: self)
		ifFalse: [ ^ self ].

	aClassModifiedClassDefinition classAffected
		updatePropertySelectors ;
		updatePropertyDefinitions
]

{ #category : #'instance creation' }
CynPropertyModel class >> fromDictionary: aDictionary [

	| instance |

	instance := self new.

	aDictionary keysAndValuesDo: [ :key :value |
		instance propertyAt: key put: value ].

	^ instance
]

{ #category : #private }
CynPropertyModel class >> generateGetPropertiesMethod: aSymbol with: aCollection [

	<serverEnvironment>

	| sourceCode firstSeen |

	"Remove the method if no properties are present (it will have a fallback method answering an empty collection)"
	aCollection ifEmpty: [

		"Remove the class side method"
		self classSide
			compiledMethodAt: aSymbol
			ifPresent: [ :method | self classSide removeSelector: aSymbol ].

		^ self ].

	sourceCode := String streamContents: [ :stream |
		stream
			nextPutAll: aSymbol ; cr ;
			cr ;
			tab ; nextPutAll: '"Generated code. DO NOT EDIT"' ; cr ;
			cr ;
			tab ; nextPutAll: '^ #('.

		"Add the property names to the collection"
		firstSeen := false.
		aCollection do: [ :each |
			firstSeen
				ifTrue: [ stream space ]
				ifFalse: [ firstSeen := true ].
			stream nextPutAll: each value ].
		
		stream nextPut: $) ].

	"Check if anything changed"
	self classSide
		compiledMethodAt: aSymbol
		ifPresent: [ :method |
			method sourceCode = sourceCode
				ifTrue: [ ^ self ] ].

	"Compile as class side method"
	self classSide compile: sourceCode classified: 'accessing - generated'
]

{ #category : #testing }
CynPropertyModel class >> hasPropertyNamed: aSymbol [

	"Answer whether the receiver has defined the specified property"

	^ propertySlots includesKey: aSymbol
]

{ #category : #initialization }
CynPropertyModel class >> initializeClassDefinitionChangeListener [

	<script>
	<serverEnvironment>

	SystemAnnouncer uniqueInstance weak
		when: ClassModifiedClassDefinition
		send: #classDefinitionChanged: to: self
]

{ #category : #initialization }
CynPropertyModel class >> initializeSlots: anObject [

	"I'm a dummy method, needed to allow interop with the SlotLayout mechanism of Pharo
	(which is absent in the tiny image of CodeParadise)."

	<serverEnvironment>
]

{ #category : #accessing }
CynPropertyModel class >> installClassMethod: aCompiledMethod [

	"Install thw specified CompiledMethod in the receiver"

	super installClassMethod: aCompiledMethod.

	"Only if the propertySlots are already defined"
	propertySlots ifNil: [ ^ self ].

	(#(allPropertyNames propertyConstraints) includes: aCompiledMethod selector)
		ifFalse: [ ^ self ].

	self updatePropertyDefinitions
]

{ #category : #testing }
CynPropertyModel class >> isRunningClientSide [

	"Answer whether the receiver is executing in a client environment"

	^ (Smalltalk classNamed: #CpDomElement) isNotNil
]

{ #category : #testing }
CynPropertyModel class >> isRunningServerSide [

	"Answer whether the receiver is executing in a server environment"

	^ self isRunningClientSide not
]

{ #category : #private }
CynPropertyModel class >> newClientPropertySlotNamed: aSymbol [

	| propertyNames |

	CynClientPropertySlot allSubclassesDo: [ :each |
		propertyNames := (self perform: each propertyCategory).
		(propertyNames includes: aSymbol)
			ifTrue: [ ^ each named: aSymbol ] ].

	self error: ('Unknown property type for property {1} of {2}' format: { aSymbol . name })
]

{ #category : #accessing }
CynPropertyModel class >> nonCalculatedPropertySlotsDo: aBlock [

	"Evaluate the specified Block for all non-calculated ClientPropertySlots of the receiver"

	self propertySlotsDo: [ :each |
		each isCalculated
			ifFalse: [ aBlock value: each ] ]
]

{ #category : #initialization }
CynPropertyModel class >> postInstall [

	"Install the property definitions (class instance variable) on the receiver"

	self updatePropertyDefinitions.

	super postInstall
]

{ #category : #accessing }
CynPropertyModel class >> propertyConstraintsAt: aSymbol do: aBlock [

	"Evaluate the specified Block for each of the constraints of the specified property"

	^ (self propertySlotAt: aSymbol)
		constraintsDo: aBlock
]

{ #category : #accessing }
CynPropertyModel class >> propertyCount [

	"Answer the number of properties of the receiver"

	^ propertySlots size
]

{ #category : #accessing }
CynPropertyModel class >> propertyNames [

	"Answer the names of the properties of the receiver"

	^ self allPropertyNames
]

{ #category : #accessing }
CynPropertyModel class >> propertyNamesDo: aBlock [

	"Evaluate the specified Block for the names of the properties of the receiver"

	^ self allPropertyNames do: aBlock
]

{ #category : #accessing }
CynPropertyModel class >> propertySelectionConstraintsAt: aSymbol do: aBlock [

	"Evaluate the specified Block for each of the selection constraints of the specified property"

	^ self propertyConstraintsAt: aSymbol do: [ :each |
		each isSelection
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
CynPropertyModel class >> propertySlotAt: aSymbol [

	"Answer a ClientPropertySlot containing the definition for the specified property name"

	^ propertySlots at: aSymbol ifAbsent: [ self errorUndefinedProperty: aSymbol ]
]

{ #category : #accessing }
CynPropertyModel class >> propertySlotAt: aSymbol ifAbsent: aBlock [

	"Answer a ClientPropertySlot containing the definition for the specified property name"

	^ propertySlots at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CynPropertyModel class >> propertySlotsDo: aBlock [

	"Evaluate the specified Block for all ClientPropertySlots of the receiver"

	propertySlots valuesDo: aBlock
]

{ #category : #'accessing - generated' }
CynPropertyModel class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #()
]

{ #category : #initialization }
CynPropertyModel class >> release [

	<script>
	<serverEnvironment>

	SystemAnnouncer uniqueInstance
		unsubscribe: self
]

{ #category : #accessing }
CynPropertyModel class >> removeClassMethod: aCompiledMethod [

	"Remove thw specified CompiledMethod from the receiver"

	super removeClassMethod: aCompiledMethod.

	"Only if the propertySlots are already defined"
	propertySlots ifNil: [ ^ self ].

	aCompiledMethod selector = #allPropertyNames
		ifFalse: [ ^ self ].

	self updatePropertyDefinitions
]

{ #category : #private }
CynPropertyModel class >> updateAllPropertyDefinitions [

	"Update the slot definitions for all subclasses of the receiver"

	<script>
	<serverEnvironment>

	"This will recurse into all subclasses"
	self subclassesDo: [ :each |
		each updatePropertyDefinitions ]
]

{ #category : #private }
CynPropertyModel class >> updateAllPropertySelectors [

	"Update the property selectors for all subclasses of the receiver"

	<script>
	<serverEnvironment>

	self allSubclassesDo: [ :each |
		each updatePropertySelectors ]
]

{ #category : #private }
CynPropertyModel class >> updatePropertyDefinitions [

	"Update the property definitions for the receiver"

	| class |

	"The individual property definitions are stored in the (Client)PropertySlot"
	propertySlots := OrderedDictionary new.
	self allPropertyNames do: [ :each |
		propertySlots at: each put: (self newClientPropertySlotNamed: each) ].

	"Perform the methods to set the property definitions (based on presence of pragma <propertyDefinition>.
	The order is not important here."
	class := self.
	[ class = CynPropertyModel ] whileFalse: [
		class classSide selectorsAndMethodsDo: [ :selector :method |
			method pragmas do: [ :each |
				each selector = #propertyDefinition
					ifTrue: [ self perform: selector ] ] ].
		class := class superclass ].

	"Also update subclasses (will recurse into all subclasses)"
	self subclassesDo: [ :each |
		each updatePropertyDefinitions ]
]

{ #category : #private }
CynPropertyModel class >> updatePropertySelectors [

	"Update (re-generate) the property selectors for the receiver"

	<serverEnvironment>

	| selectors |

	selectors := OrderedCollection new.

	self classLayout
		allSlotsDo: [ :slot | slot addPropertyTo: selectors ].

	"Generate a method per property category"
	CynAbstractPropertySlot allSubclassesDo: [ :eachClass |
		self generateGetPropertiesMethod: eachClass propertyCategory with: (selectors select: [ :each | each key = eachClass propertyCategory ]) ].

	"Generate the #allPropertyNames method last (this is important, because it is used in #installClassMethod:)"
	self generateGetPropertiesMethod: #allPropertyNames with: selectors
]

{ #category : #comparing }
CynPropertyModel >> = anObject [

	"Answer whether the specified Object is equal to the receiver.
	This method allows comparing against Dictionaries."

	self == anObject
		ifTrue: [ ^ true ].

	"If the specified Object is a PropertyModel as well, the following will
	invoke the same method again, this time with a Dictionary to compare against.
	If the specified Object is a Dictionary it will compare two Dictionaries."
	^ anObject = data
]

{ #category : #accessing }
CynPropertyModel >> addChangeHandlers [

	"Add any change handlers.
	Subclasses should call the super implementation."

	self class isRunningClientSide
		ifTrue: [ self addClientChangeHandlers ]
]

{ #category : #accessing }
CynPropertyModel >> addClientChangeHandlers [

	"Add any change handlers specific for client environment (i.e. where a UI is present).
	Subclasses should call the super implementation and preferrable add the following pragma:
		<environment: #browser>
	"
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> asDictionary [

	"Answer a Dictionary representing the receiver"

	^ data copy
]

{ #category : #converting }
CynPropertyModel >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Do not serialize calculated properties (they should be re-creatable).
	Since values of the receiver's properties can be any value,
	convert these to JSON Object values. Keys are already Strings."

	| result |

	result := OrderedDictionary new.

	self class nonCalculatedPropertySlotsDo: [ :each |
		result at: each name put: (each read: self) asJsonObjectValue ].

	^ result
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> at: aSymbol [

	^ self at: aSymbol ifAbsent: [ self error: 'key not found' ]
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> at: aSymbol ifAbsent: aBlock [

	^ (self class propertySlotAt: aSymbol ifAbsent: [ ^ aBlock value ])
		read: self
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> at: aSymbol ifPresent: aBlock [

	^ aBlock value: (self at: aSymbol ifAbsent: [ ^ nil ])
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> at: aSymbol put: anObject [

	^ (self class propertySlotAt: aSymbol)
		write: anObject to: self
]

{ #category : #accessing }
CynPropertyModel >> clientPostCopy [

	"Add post copy actions specific for client environment (i.e. where a UI is present).
	Subclasses should call the super implementation and preferrable add the following pragma:
		<environment: #browser>
	"
]

{ #category : #testing }
CynPropertyModel >> hasPropertyAt: aSymbol [

	"Answer whether the receiver has the specified property"

	^ self class hasPropertyNamed: aSymbol
]

{ #category : #comparing }
CynPropertyModel >> hash [

	^ data hash
]

{ #category : #initialization }
CynPropertyModel >> initialize [

	"Initialize the receiver.

	Implementation:
	First create the data Dictionary.
	Then initialize the property values.
	Finally add any change handlers. This is a mechanism to allow the receiver
	to act on changes without having to perform checks to see if any property
	actually changed value. These checks are already performed in methods like
	#propertyAt:put:. Also it allows to decouple (typically) the setter methods
	from performing some side effects.
	Change handlers can be added for the 'general' purpose and specific ones
	for when running client side (i.e. when a UI is present)."

	super initialize.

	data := Dictionary new.

	"When the data Dictionary is setup, set the initial values"
	self initializeProperties.
	self class isRunningClientSide
		ifTrue: [ self initializeClientProperties ].

	"When the initial property values are set, add change handlers"
	self addChangeHandlers
]

{ #category : #initialization }
CynPropertyModel >> initializeClientProperties [

	"Set the receiver's initial values specific for client environment (i.e. where a UI is present).
	Subclasses should call the super implementation and preferrable add the following pragma or store
	the method in a client side only package:
		<environment: #browser>
	"
]

{ #category : #initialization }
CynPropertyModel >> initializeProperties [

	"Set the receiver's initial values.
	Subclasses should call the super implementation."
]

{ #category : #introspection }
CynPropertyModel >> instVarNamed: aSymbol [

	^ self propertyAt: aSymbol
]

{ #category : #introspection }
CynPropertyModel >> instVarNamed: aSymbol put: anObject [

	^ self propertyAt: aSymbol put: anObject
]

{ #category : #testing }
CynPropertyModel >> isValid [

	"Answer whether the receiver has valid properties"

	self propertyNamesDo: [ :each |
		(self isValidPropertyAt: each)
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #testing }
CynPropertyModel >> isValidPropertyAt: aSymbol [

	"Answer whether the specified property is valid.

	Implementation:
	Because of conditional constraints use #isValidProperty:in: repeatedly.
	Do NOT retrieve the property value and use #isValid: since it will fail
	on those conditional constraints."

	self class propertyConstraintsAt: aSymbol do: [ :each |
		(each isValidProperty: aSymbol in: self)
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #testing }
CynPropertyModel >> isValidValue: anObject forPropertyAt: aSymbol [

	"Answer whether the specified value would be valid for the property specified.
	This method will IGNORE any conditional constraints."

	self class propertyConstraintsAt: aSymbol do: [ :each |
		(each isValidValue: anObject in: self)
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> keys [

	"Answer the property names of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyNames
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> keysAndValuesDo: aBlock [

	"Evaluate the specified Block for the property names and values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyNamesAndValuesDo: aBlock
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> keysDo: aBlock [

	"Evaluate the specified Block for all property names of the receiver.

	This gives the receiver a Dictionary like interface."

	self propertyNamesDo: aBlock
]

{ #category : #merging }
CynPropertyModel >> merge: anObject [

	"Merge the specified Object into the receiver.
	Assuming the Object is Dictionary-like (like the receiver but also a JSON Object).
	Answer the Object merged into the receiver."

	anObject mergeIntoPropertyModel: self.

	^ anObject
]

{ #category : #merging }
CynPropertyModel >> mergeIntoPropertyModel: aPropertyModel [

	"Merge the receiver into the specified PropertyModel.

	Implementation:
	Do not try to store calculated properties."

	self class nonCalculatedPropertySlotsDo: [ :each |
		aPropertyModel propertyAt: each name put: (each read: self) ]
]

{ #category : #constraints }
CynPropertyModel >> modelViolationsDo: aBlock [

	"Evaluate the specified Block for each (integrity) violation in the receiver.
	The Block will be evaluated with a key (a Symbol or CynTextReference)
	representing the violation.

	In contrast with #propertyViolationsAt:do: the Block should NOT be evaluated
	for property specific (constraint based) violations.

	Subclasses should implement this."
]

{ #category : #normalizing }
CynPropertyModel >> normalize [

	"Normalize the properties of the receiver.
	Normalization should not change the effective content of the property.
	It is allowed to remove whitespace or control characters or change
	character casing, but prevent removal of unwanted special characters
	for example. Either try to prevent the user from entering an invalid
	value and/or provide a clear description (or error message) what is
	incorrect wrt the provided value/input. The user might otherwise not
	notice their input is silently replaced by something else.

	Implementation:
	Do not try to normalize calculated properties (has no effect).
	Constrained properties have an optional normalization step.
	Perform these for all constraints."

	self class nonCalculatedPropertySlotsDo: [ :each |
		each constraintsDo: [ :eachConstraint |
			eachConstraint normalizeProperty: each name in: self ] ]
]

{ #category : #normalizing }
CynPropertyModel >> normalizePropertyAt: aSymbol [

	"Normalize the specified property of the receiver"

	self class propertyConstraintsAt: aSymbol do: [ :each |
		each normalizeProperty: aSymbol in: self ]
]

{ #category : #copying }
CynPropertyModel >> postCopy [

	"After my instance and data are copied, add the required change handlers.
	This copy is a shallow copy. If the receiver has relations to other Objects,
	these related Objects will be shared."

	super postCopy.

	data := data copy.

	self class isRunningClientSide
		ifTrue: [ self clientPostCopy ].

	self addChangeHandlers
]

{ #category : #printing }
CynPropertyModel >> printOn: aStream [

	"Print the receiver on the specified Stream.
	Only public properties are printed."

	aStream
		nextPutAll: self class name ;
		nextPut: $:.
	data
		ifNotEmpty: [
			data associationsDo: [ :each |
				aStream
					space ;
					nextPutAll: each key ;
					nextPutAll: '->' ;
					print: each value ] ]
		ifEmpty: [ aStream nextPutAll: '<empty>' ]
]

{ #category : #accessing }
CynPropertyModel >> propertyAt: aSymbol [

	"Answer the value of the specified property"

	^ (self class propertySlotAt: aSymbol)
		read: self
]

{ #category : #accessing }
CynPropertyModel >> propertyAt: aSymbol put: anObject [

	"Set the specified property to the specified value"

	^ (self class propertySlotAt: aSymbol)
		write: anObject to: self
]

{ #category : #accessing }
CynPropertyModel >> propertyNames [

	"Answer the property names of the receiver"

	^ self class propertyNames
]

{ #category : #accessing }
CynPropertyModel >> propertyNamesAndValuesDo: aBlock [

	"Evaluate the specified Block for the property names and values of the receiver"

	^ self class propertySlotsDo: [ :propertySlot |
		propertySlot nameAndValueIn: self do: aBlock ]
]

{ #category : #accessing }
CynPropertyModel >> propertyNamesDo: aBlock [

	"Evaluate the specified Block for all property names of the receiver"

	self class propertyNamesDo: aBlock
]

{ #category : #accessing }
CynPropertyModel >> propertyValues [

	"Answer a Collection containing the property values of the receiver"

	^ Array
		new: self size
		streamContents: [ :aStream | self propertyValuesDo: [ :value | aStream nextPut: value ] ]
]

{ #category : #accessing }
CynPropertyModel >> propertyValuesDo: aBlock [

	"Evaluate the specified Block for the property values of the receiver"

	^ self class propertySlotsDo: [ :propertySlot |
		propertySlot valueIn: self do: aBlock ]
]

{ #category : #constraints }
CynPropertyModel >> propertyViolationsAt: aSymbol do: aBlock [

	"Evaluate the specified Block for each violation in the specified
	property of the receiver.
	The Block will be evaluated with a key (a Symbol or CynTextReference)
	representing the violation."

	self class propertyConstraintsAt: aSymbol do: [ :each |

		"Per constraint evaluate all violations. Use the 'long' form with
		the model, since conditional constraints require access to the model.
		Do NOT use #violationsIn:do: here."
		each violationsForProperty: aSymbol in: self do: aBlock ]
]

{ #category : #private }
CynPropertyModel >> rawAt: aSymbol [

	"Answer the value of the specified property without explicit check for property existence.
	Use with caution."

	^ data at: aSymbol ifAbsent: [ nil ]
]

{ #category : #private }
CynPropertyModel >> rawAt: aSymbol put: anObject [

	"Set the specified property to the specified value without explicit check for property existence.
	Use with caution.

	Implementation:
	If a property receives nil as value, it is removed from the data collection."

	| oldValue |

	"Retrieve the old value"
	oldValue := data at: aSymbol ifAbsent: [ nil ].

	anObject
		ifNotNil: [

			"Update the value in the data collection only if new value is different"
			oldValue = anObject
				ifFalse: [
					data at: aSymbol put: anObject.
					self announce: (CynPropertyChanged name: aSymbol oldValue: oldValue newValue: anObject) ] ]
		ifNil: [

			"Update (i.e. remove) the value from the data collection only if some value was present"
			oldValue ifNotNil: [
				data removeKey: aSymbol ifAbsent: [ "ignore" ].
				self announce: (CynPropertyChanged name: aSymbol oldValue: oldValue newValue: nil) ] ].

	^ anObject
]

{ #category : #initialization }
CynPropertyModel >> release [

	super release.

	data := nil
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> removeKey: aSymbol [

	^ self removeKey: aSymbol ifAbsent: [ self error: 'key not found' ]
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> removeKey: aSymbol ifAbsent: aBlock [

	^ self removePropertyAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CynPropertyModel >> removePropertyAt: aSymbol [

	"Remove the specified property and answer its original value
	or nil if the property does not exist"

	^ self removePropertyAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CynPropertyModel >> removePropertyAt: aSymbol ifAbsent: aBlock [

	"Remove the specified property and answer its original value
	or evaluate the specified Block if the property does not exist"

	^ (self propertyAt: aSymbol)
		ifNotNil: [ :value |
			self rawAt: aSymbol put: nil.
			value ]
		ifNil: [ aBlock value ]
]

{ #category : #accessing }
CynPropertyModel >> reset [

	"Restore to initial (empty) state"

	| oldAnnouncer oldData |

	data ifEmpty: [ ^ self ].

	"Prevent announcing changes while resetting"
	[
		oldAnnouncer := announcer.
		announcer := nil.

		oldData := data.
		data := Dictionary new.

		"Initialize the properties"
		self initializeProperties.
		self class isRunningClientSide
			ifTrue: [ self initializeClientProperties ]
	] ensure: [ announcer := oldAnnouncer ].

	"Announce the receiver's value(s) changed"
	oldData keysAndValuesDo: [ :key :value |
		self announce: (CynPropertyChanged name: key oldValue: value newValue: (self rawAt: key)) ]
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> size [

	"Answer the number of properties of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self class propertyCount
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> values [

	"Answer a Collection containing the property values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyValues
]

{ #category : #'accessing - dictionary access' }
CynPropertyModel >> valuesDo: aBlock [

	"Evaluate the specified Block for the property values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyValuesDo: aBlock
]
