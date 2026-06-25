"
I am a Model in a Model-View-Presenter pattern supporting PropertySlots.
I announce when one of my property values changed.

There is no need to explicitly announce a change when assigning a (new)
value to a PropertySlot. That is handled automagically for you by the slot.
Other types of changes need to be announced manually.

A change is announced when the value being assigned to a slot is unequal
to the existing slot value. This means that the following assignments
will NOT announce a change, even though both values are NOT identical.

```
	myObject prop: 'Hello world'.
	myObject prop: 'Hello ', 'world'.
```

The property does receive the new String value, so in that sense the
original assignment behavior is not changed. The announcement however is
only made when an unequal value is assigned.
"
Class {
	#name : #CpPropertyModel,
	#superclass : #CpModel,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #announcing }
CpPropertyModel >> asSingleChange: aBlock [

	"Evaluate the specified Block and only announce changes after the Block has completed.
	This method is useful to prevent updating the view while the receiver is not consistent
	yet. When all properties (set during the Block evaluation) are updated and the receiver's
	properties are in a consistent state, then the changes are announced."

	"If no interest is registered, simply evaluate the Block"
	announcer ifNil: [
		aBlock value.
		^ self ].

	announcer delayAnnouncementsAfter: aBlock
]

{ #category : #accessing }
CpPropertyModel >> mergeProperties: aDictionary [

	"Merge the properties from the specified Dictionary into the receiver.

	Implementation:
	The safe way to merge the properties is by using the slot names instead of
	Dictionary keys. Any unknown keys in the Dictionary are simply ignored here."

	"For performance make distinction between whether or not someone has interest
	in the receiver. If no Announcer is created, do not lazily create one."
	announcer
		ifNotNil: [ announcer delayAnnouncementsAfter: [ self rawMergePropertyValues: aDictionary ] ]
		ifNil: [ self rawMergePropertyValues: aDictionary ]
]

{ #category : #accessing }
CpPropertyModel >> properties [

	"Answer a Dictionary containing the receiver's property names and values"

	| properties |

	properties := Dictionary new: self propertyCount.

	self propertyNamesAndValuesDo: [ :name :value |
		properties at: name put: value ].

	^ properties
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol [

	"Answer the value of the specified property"

	^ (self class propertySlotNamed: aSymbol)
		read: self
]

{ #category : #accessing }
CpPropertyModel >> propertyAt: aSymbol put: anObject [

	"Set the value of the specified property"

	(self class propertySlotNamed: aSymbol)
		write: anObject to: self
]

{ #category : #accessing }
CpPropertyModel >> propertyCount [

	"Answer the number of properties (PropertySlots) in the receiver.

	Implementation:
	The most efficient way to get the count seems to be a simple
	iteration. It does not require any intermediate collections to
	be created."

	| count |

	count := 0.

	self class allPropertySlotsDo: [ :each |
		count := count + 1 ].

	^ count
]

{ #category : #accessing }
CpPropertyModel >> propertyNames [

	"Answer a Collection with all the receiver's property names
	in order from Object to receiver's class"

	^ Array new: self propertyCount streamContents: [ :stream |
		self propertyNamesDo: [ :each |
			stream nextPut: each ] ]
]

{ #category : #enumerating }
CpPropertyModel >> propertyNamesAndValuesDo: aBlock [

	"Evaluate the specified Block with all the receiver's property names and values
	in order from Object to receiver's class"

	self class allPropertySlotsDo: [ :each |
		aBlock value: each name value: (each read: self) ]
]

{ #category : #enumerating }
CpPropertyModel >> propertyNamesDo: aBlock [

	"Evaluate the specified Block with all the receiver's property names
	in order from Object to receiver's class"

	self class allPropertySlotsDo: [ :each |
		aBlock value: each name ]
]

{ #category : #announcing }
CpPropertyModel >> propertySlot: aSlot valueChangedFrom: oldValue to: newValue [

	"The specified PropertySlot's value changed.

	Implementation:
	The method contains some duplicate code with #announce: for performance reasons:
	No Announcement is created if no one is listening to the receiver."

	"Nobody has registered interest"
	announcer ifNil: [ ^ self ].

	announcer announce: (CpPropertyChanged name: aSlot name oldValue: oldValue newValue: newValue)
]

{ #category : #accessing }
CpPropertyModel >> propertyValues [

	"Answer a Collection with all the receiver's property values
	in order from Object to receiver's class"

	^ Array new: self propertyCount streamContents: [ :stream |
		self propertyValuesDo: [ :each |
			stream nextPut: each ] ]
]

{ #category : #enumerating }
CpPropertyModel >> propertyValuesDo: aBlock [

	"Evaluate the specified Block with all the receiver's property values
	in order from Object to receiver's class"

	self class allPropertySlotsDo: [ :each |
		aBlock value: (each read: self) ]
]

{ #category : #accessing }
CpPropertyModel >> rawMergePropertyValues: aDictionary [

	"Merge the property values from the specified Dictionary into the receiver.
	Announcements will be made directly for any property values which change.
	The default behavior in #mergePropertyValues: is to announce after the
	merge is complete.

	Implementation:
	The safe way to merge the properties is by using the slot names instead of
	Dictionary keys. Any unknown keys in the Dictionary are simply ignored here."

	self class allPropertySlotsDo: [ :each |
		aDictionary
			at: each name
			ifPresent: [ :value | each write: value to: self ] ]
]

{ #category : #accessing }
CpPropertyModel >> rawPropertyAt: aSymbol put: anObject [

	"Update the receiver without announcing any change"

	(self class propertySlotNamed: aSymbol)
		rawWrite: anObject to: self
]
