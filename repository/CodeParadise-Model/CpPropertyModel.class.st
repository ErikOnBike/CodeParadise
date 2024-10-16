"
I am a Model containing properties. I announce when my properties have changed.
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
	#superclass : #CpBaseModel,
	#instVars : [
		'data',
		'privateData'
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

	"Set the specified property to the specified value.

	Implementation:
	If a property receives nil as value, it is removed from the (appropriate) data collection.
	The private data collection is created lazily since it is assumed not to be used often.
	If this data collection becomes empty, it is not destroyed since it might be used again.
	The two branches: anObject being not nil and nil, seem similar in first part, but are in
	fact slightly different because of this private data collection that can be nil and requires
	instantiation ONLY in the non-nil branch."

	(self class hasDefinedProperty: aSymbol)
		ifFalse: [ self error: 'Undefined property ', aSymbol, ' in a ', self class name ].

	anObject
		ifNotNil: [

			| collection oldValue |

			"Select the correct  private or public data collection"
			collection := (aSymbol beginsWith: #_)
				ifTrue: [ privateData ifNil: [ privateData := Dictionary new ] ]
				ifFalse: [ data ].

			"Retrieve the old value"
			oldValue := collection at: aSymbol ifAbsent: [ nil ].

			"Update the value in the data collection only if new value is different"
			oldValue = anObject
				ifFalse: [
					collection at: aSymbol put: anObject.
					self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: anObject) ] ]
		ifNil: [

			| collection oldValue |

			"Select the corect private or public data collection"
			collection := (aSymbol beginsWith: #_)
				ifTrue: [ privateData ]
				ifFalse: [ data ].

			"Retrieve the old value (only if there is a collection)"
			oldValue := collection ifNotNil: [ collection at: aSymbol ifAbsent: [ nil ] ].

			"Update (i.e. remove) the value from the data collection only if it was present"
			oldValue ifNotNil: [
				collection removeKey: aSymbol.
				self announce: (CpPropertyChanged name: aSymbol oldValue: oldValue newValue: nil) ] ].

	^ anObject
]
