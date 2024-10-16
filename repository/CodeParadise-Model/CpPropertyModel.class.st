"
I am a Model containing properties.
I am responsible for keeping track of my property values.
My properties can have conditional constraints.
Property values can be public or private, distinguished by their name.
A property name starting with #_ is assumed to be private.

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
	#superclass : #Object,
	#instVars : [
		'data',
		'privateData',
		'_test'
	],
	#category : #'CodeParadise-Model-Property'
}

{ #category : #initialization }
CpPropertyModel class >> initializeSlots: anObject [

	"I'm a dummy method, needed to allow interop with the SlotLayout mechanism of Pharo
	(which is absent in the tiny image of CodeParadise)."
]

{ #category : #initialization }
CpPropertyModel >> initialize [

	"Initialize the receiver.

	Implementation:
	Only the data Dictionary is created.
	The private data Dictionary will be created lazyly,
	since it will probably not be used often."

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

	(self class hasDefinedProperty: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	"privateData might be nil, so check for this"
	^ ((aSymbol beginsWith: #_)
		ifTrue: [ privateData ]
		ifFalse: [ data ])
			ifNotNil: [ :dict | dict at: aSymbol ifAbsent: [ nil ] ]
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol put: anObject [

	"Set the specified property to the specified value"

	(self class hasDefinedProperty: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	"privateData might be nil, so check for this"
	^ anObject
		ifNotNil: [
			((aSymbol beginsWith: #_)
				ifTrue: [ privateData ifNil: [ privateData := Dictionary new ] ]
				ifFalse: [ data ])
					at: aSymbol put: anObject ]
		ifNil: [
			((aSymbol beginsWith: #_)
				ifTrue: [ privateData ]
				ifFalse: [ data ])
					ifNotNil: [ :dict | dict removeKey: aSymbol ifAbsent: [ "ignore" ] ] ]
]
