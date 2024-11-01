"
I am a Model containing properties. I announce when my properties have changed.
I am responsible for keeping track of my property values.
My properties can have additional definitions. I don't use these definitions
but make them accessable. Subclasses can use thes definitions to adapt behavior.

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
		'propertyDefinitions'
	],
	#category : #'CodeParadise-Model-Property'
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
CpPropertyModel class >> hasPropertyDefinitionAt: aSymbol [

	"Answer whether the receiver has defined the specified property"

	^ propertyDefinitions includesKey: aSymbol
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
CpPropertyModel class >> propertyDefinitionAt: aSymbol [

	"Answer a ClientPropertySlot containing the definition for the specified property name"

	^ propertyDefinitions at: aSymbol ifAbsent: [ self error: 'Undefined property ', aSymbol, ' in a ', self name ]
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

	"Update the slot definitions for the receiver"

	| class |

	"The individual property definitions are Dictionaries to allow adding definitions dynamically"
	propertyDefinitions := OrderedDictionary new.
	self allInstVarNamesDo: [ :each | propertyDefinitions at: each put: (CpClientPropertySlot named: each) ].

	"Perform the methods to set the property definitions (based on presence of pragma <propertyDefinition>.
	The order is not important here."
	class := self.
	[ class = CpPropertyModel ] whileFalse: [
		class selectorsAndMethodsDo: [ :selector :method |
			method pragmas do: [ :each |
				each keyword = #propertyDefinition
					ifTrue: [ self perform: selector ] ] ].
		class := class superclass ]
]

{ #category : #accessing }
CpPropertyModel >> hasPropertyAt: aSymbol [

	"Answer whether the receiver has the specified property"

	^ self class hasPropertyDefinitionAt: aSymbol
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

	(self class hasPropertyDefinitionAt: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	^ data at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol put: anObject [

	"Set the specified property to the specified value.

	Implementation:
	If a property receives nil as value, it is removed from the data collection."

	| oldValue |

	(self class hasPropertyDefinitionAt: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	"Retrieve the old value (only if there is a collection)"
	oldValue := data at: aSymbol ifAbsent: [ nil ].

	anObject
		ifNotNil: [

			"Update the value in the data collection only if new value is different"
			oldValue = anObject
				ifFalse: [
					data at: aSymbol put: anObject.
					self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: anObject) ] ]
		ifNil: [

			"Update (i.e. remove) the value from the data collection only if it was present"
			oldValue ifNotNil: [
				data removeKey: aSymbol ifAbsent: [ "ignore" ].
				self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: nil) ] ].

	^ anObject
]

{ #category : #accessing }
CpPropertyModel >> propertyDefinitionAt: aSymbol [

	"Answer a ClientPropertySlot containing the definition for the specified slot name"

	^ self class propertyDefinitionAt: aSymbol
]

{ #category : #accessing }
CpPropertyModel >> propertyNamed: aSymbol [

	"Answer a Property instance for the receiver with the specified property name"

	(self class hasPropertyDefinitionAt: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	^ CpProperty on: self name: aSymbol
]
