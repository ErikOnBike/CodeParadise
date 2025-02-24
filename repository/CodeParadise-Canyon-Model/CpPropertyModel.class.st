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
	#name : #CpPropertyModel,
	#superclass : #CpBaseModel,
	#instVars : [
		'data'
	],
	#classInstVars : [
		'propertySlots'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'event handling' }
CpPropertyModel class >> classDefinitionChanged: aClassModifiedClassDefinition [

	<serverEnvironment>

	(aClassModifiedClassDefinition classAffected inheritsFrom: self)
		ifFalse: [ ^ self ].

	aClassModifiedClassDefinition classAffected
		updatePropertyDefinitions
]

{ #category : #'instance creation' }
CpPropertyModel class >> fromDictionary: aDictionary [

	| instance |

	instance := self new.

	aDictionary keysAndValuesDo: [ :key :value |
		instance propertyAt: key put: value ].

	^ instance
]

{ #category : #testing }
CpPropertyModel class >> hasPropertyNamed: aSymbol [

	"Answer whether the receiver has defined the specified property"

	^ propertySlots includesKey: aSymbol
]

{ #category : #initialization }
CpPropertyModel class >> initializeClassDefinitionChangeListener [

	<script>
	<serverEnvironment>

	SystemAnnouncer uniqueInstance weak
		when: ClassModifiedClassDefinition
		send: #classDefinitionChanged: to: self
]

{ #category : #initialization }
CpPropertyModel class >> initializeSlots: anObject [

	"I'm a dummy method, needed to allow interop with the SlotLayout mechanism of Pharo
	(which is absent in the tiny image of CodeParadise)."

	<serverEnvironment>
]

{ #category : #accessing }
CpPropertyModel class >> postInstall [

	"Install the property definitions (class instance variable) on the receiver"

	self updatePropertyDefinitions.

	super postInstall
]

{ #category : #accessing }
CpPropertyModel class >> propertyCount [

	"Answer the number of properties of the receiver"

	^ propertySlots size
]

{ #category : #accessing }
CpPropertyModel class >> propertyNames [

	"Answer the names of the properties of the receiver"

	^ propertySlots keys
]

{ #category : #accessing }
CpPropertyModel class >> propertyNamesDo: aBlock [

	"Evaluate the specified Block for the names of the properties of the receiver"

	^ propertySlots keysDo: aBlock
]

{ #category : #accessing }
CpPropertyModel class >> propertySlotAt: aSymbol [

	"Answer a ClientPropertySlot containing the definition for the specified property name"

	^ propertySlots at: aSymbol ifAbsent: [ self errorUndefinedProperty: aSymbol ]
]

{ #category : #accessing }
CpPropertyModel class >> propertySlotsDo: aBlock [

	"Evaluate the specified Block for all ClientPropertySlots of the receiver"

	propertySlots valuesDo: aBlock
]

{ #category : #initialization }
CpPropertyModel class >> release [

	<script>
	<serverEnvironment>

	SystemAnnouncer uniqueInstance
		unsubscribe: self
]

{ #category : #private }
CpPropertyModel class >> updateAllPropertyDefinitions [

	"Update the slot definitions for all subclasses of the receiver"

	<script>
	<serverEnvironment>

	self allSubclassesDo: [ :each |
		each updatePropertyDefinitions ]
]

{ #category : #private }
CpPropertyModel class >> updatePropertyDefinitions [

	"Update the property definitions for the receiver"

	| class |

	"The individual property definitions are stored in the (Client)PropertySlot"
	propertySlots := OrderedDictionary new.
	self allInstVarNamesBelow: CpPropertyModel do: [ :each | propertySlots at: each put: (CpClientPropertySlot named: each) ].

	"Perform the methods to set the property definitions (based on presence of pragma <propertyDefinition>.
	The order is not important here."
	class := self.
	[ class = CpPropertyModel ] whileFalse: [
		class classSide selectorsAndMethodsDo: [ :selector :method |
			method pragmas do: [ :each |
				each selector = #propertyDefinition
					ifTrue: [ self perform: selector ] ] ].
		class := class superclass ]
]

{ #category : #comparing }
CpPropertyModel >> = anObject [

	"Answer whether the specified Object is equal to the receiver.
	This method allows comparing against Dictionaries."

	self == anObject
		ifTrue: [ ^ true ].

	"If the specified Object is a PropertyModel as well, the following will
	invoke the same method again, this time with a Dictionary to compare against.
	If the specified Object is a Dictionary it will compare two Dictionaries."
	^ anObject = data
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> asDictionary [

	"Answer a Dictionary representing the receiver"

	^ data copy
]

{ #category : #converting }
CpPropertyModel >> asJsonObjectValue [

	"Answer a representation of the receiver to be used in a JSON Object.

	Implementation:
	Since values of the receiver's properties can be any value,
	convert these to JSON Object values. Keys are already Strings."

	| result |

	result := OrderedDictionary new.

	self keysAndValuesDo: [ :key :value |
		result at: key put: value asJsonObjectValue ].

	^ result
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> at: aSymbol [

	^ self at: aSymbol ifAbsent: [ self error: 'key not found' ]
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> at: aSymbol ifAbsent: aBlock [

	(self hasPropertyAt: aSymbol)
		ifFalse: [ ^ aBlock value ].

	^ self propertyAt: aSymbol
]

{ #category : #testing }
CpPropertyModel >> hasPropertyAt: aSymbol [

	"Answer whether the receiver has the specified property"

	^ self class hasPropertyNamed: aSymbol
]

{ #category : #comparing }
CpPropertyModel >> hash [

	^ data hash
]

{ #category : #initialization }
CpPropertyModel >> initialize [

	"Initialize the receiver.

	Implementation:
	Only the data Dictionary is created.
	The private data Dictionary will be created lazily, since it will probably not be used often."

	super initialize.

	data := Dictionary new
]

{ #category : #introspection }
CpPropertyModel >> instVarNamed: aSymbol [

	^ self propertyAt: aSymbol
]

{ #category : #introspection }
CpPropertyModel >> instVarNamed: aSymbol put: anObject [

	^ self propertyAt: aSymbol put: anObject
]

{ #category : #testing }
CpPropertyModel >> isValidPropertyAt: aSymbol [

	| value |

	value := self propertyAt: aSymbol.

	^ (self propertySlotAt: aSymbol) constraints allSatisfy: [ :each |
		each isValid: value ]
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> keys [

	"Answer the property names of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyNames
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> keysAndValuesDo: aBlock [

	"Evaluate the specified Block for the property names and values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyNamesAndValuesDo: aBlock
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> keysDo: aBlock [

	"Evaluate the specified Block for all property names of the receiver.

	This gives the receiver a Dictionary like interface."

	self propertyNamesDo: aBlock
]

{ #category : #merging }
CpPropertyModel >> merge: anObject [

	"Merge the specified Object into the receiver.
	Assuming the Object is Dictionary-like (like MaEntity but also a JSON Object).
	Answer the Object merged into the receiver."

	anObject keysAndValuesDo: [ :key :value |
		self propertyAt: key put: value ].

	^ anObject
]

{ #category : #normalizing }
CpPropertyModel >> normalize [

	"Normalize the properties of the receiver.
	Normalization should not change the effective content of the property.
	It is allowed to remove whitespace or control characters or change
	character casing, but prevent removal of unwanted special characters
	for example. Either try to prevent the user from entering an invalid
	value and/or provide a clear description (or error message) what is
	incorrect wrt the provided value/input. The user might otherwise not
	notice their input is silently replaced by something else.

	Implementation:
	Constrained properties have an optional normalization step.
	Perform these for all constraints."

	self propertySlotsDo: [ :each |
		each constraints do: [ :eachConstraint | eachConstraint normalizeProperty: each name in: self ] ]
]

{ #category : #copying }
CpPropertyModel >> postCopy [

	super postCopy.

	data := data copy
]

{ #category : #printing }
CpPropertyModel >> printOn: aStream [

	"Print the receiver on the specified Stream.
	Only public properties are printed."

	aStream
		nextPutAll: self class name ;
		nextPutAll: ': '.
	data printOn: aStream
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol [

	"Answer the value of the specified property"

	(self class hasPropertyNamed: aSymbol)
		ifFalse: [ self class errorUndefinedProperty: aSymbol ].

	^ data at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol put: anObject [

	"Set the specified property to the specified value.

	Implementation:
	If a property receives nil as value, it is removed from the data collection."

	| oldValue |

	(self class hasPropertyNamed: aSymbol)
		ifFalse: [ self class errorUndefinedProperty: aSymbol ].

	"Retrieve the old value"
	oldValue := data at: aSymbol ifAbsent: [ nil ].

	anObject
		ifNotNil: [

			"Update the value in the data collection only if new value is different"
			oldValue = anObject
				ifFalse: [
					data at: aSymbol put: anObject.
					self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: anObject) ] ]
		ifNil: [

			"Update (i.e. remove) the value from the data collection only if some value was present"
			oldValue ifNotNil: [
				data removeKey: aSymbol ifAbsent: [ "ignore" ].
				self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: nil) ] ].

	^ anObject
]

{ #category : #accessing }
CpPropertyModel >> propertyNames [

	"Answer the property names of the receiver"

	^ self class propertyNames
]

{ #category : #accessing }
CpPropertyModel >> propertyNamesAndValuesDo: aBlock [

	"Evaluate the specified Block for the property names and values of the receiver"

	^ self propertyNamesDo: [ :name | aBlock value: name value: (self propertyAt: name) ]
]

{ #category : #accessing }
CpPropertyModel >> propertyNamesDo: aBlock [

	"Evaluate the specified Block for all property names of the receiver"

	self class propertyNamesDo: aBlock
]

{ #category : #accessing }
CpPropertyModel >> propertySlotAt: aSymbol [

	"Answer a ClientPropertySlot containing the definition for the specified slot name"

	^ self class propertySlotAt: aSymbol
]

{ #category : #accessing }
CpPropertyModel >> propertySlotsDo: aBlock [

	"Evaluate the specified Block for all property slots of the receiver"

	self class propertySlotsDo: aBlock
]

{ #category : #accessing }
CpPropertyModel >> propertyValues [

	"Answer a Collection containing the property values of the receiver"

	^ Array
		new: self size
		streamContents: [ :aStream | self propertyValuesDo: [ :value | aStream nextPut: value ] ]
]

{ #category : #accessing }
CpPropertyModel >> propertyValuesDo: aBlock [

	"Evaluate the specified Block for the property values of the receiver"

	^ self propertyNamesDo: [ :name | aBlock value: (self propertyAt: name) ]
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> removeKey: aSymbol [

	^ self removeKey: aSymbol ifAbsent: [ self error: 'key not found' ]
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> removeKey: aSymbol ifAbsent: aBlock [

	^ self removePropertyAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CpPropertyModel >> removePropertyAt: aSymbol [

	"Remove the specified property and answer its original value
	or nil if the property does not exist"

	^ self removePropertyAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpPropertyModel >> removePropertyAt: aSymbol ifAbsent: aBlock [

	"Remove the specified property and answer its original value
	or evaluate the specified Block if the property does not exist"

	^ (self propertyAt: aSymbol)
		ifNotNil: [ :value |
			self propertyAt: aSymbol put: nil.
			value ]
		ifNil: [ aBlock value ]
]

{ #category : #accessing }
CpPropertyModel >> reset [

	"Restore to initial (empty) state"

	| oldData |

	data ifEmpty: [ ^ self ].

	oldData := data.
	data := Dictionary new.

	"Announce the receiver's value(s) changed"
	oldData keysAndValuesDo: [ :key :value |
		self announce: (CpPropertyChanged name: key oldValue: value newValue: nil) ]
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> size [

	"Answer the number of properties of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self class propertyCount
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> values [

	"Answer a Collection containing the property values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyValues
]

{ #category : #'accessing - dictionary access' }
CpPropertyModel >> valuesDo: aBlock [

	"Evaluate the specified Block for the property values of the receiver.

	This gives the receiver a Dictionary like interface."

	^ self propertyValuesDo: aBlock
]
