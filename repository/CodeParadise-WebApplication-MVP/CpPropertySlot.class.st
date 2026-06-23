"
I am a Slot for Properties in a PropertyModel.
I will let the PropertyModel announce a PropertyChange whenever
the Slot receives a new value. New values are considered values
which are unequal to the existing value. Be aware that this means
that sometimes values can be equal but not identical. So assigning
an equal value which is NOT identical to the existing value, will
NOT trigger a PropertyChange announcement.

So I am a convenience Slot which prevents you from having to write
tedious code to check if something changed in a Slot on each Slot
write.
"
Class {
	#name : #CpPropertySlot,
	#superclass : #CpAbstractPropertySlot,
	#instVars : [
		'index'
	],
	#category : #'CodeParadise-WebApplication-MVP-Slots'
}

{ #category : #comparing }
CpPropertySlot >> = anObject [

	"Answer whether the receiver is equal to the specified Object"

	self == anObject
		ifTrue: [ ^ true ].

	^ super = anObject
		and: [ index = anObject index ]
]

{ #category : #'code generation' }
CpPropertySlot >> emitStore: aMethodBuilder [

	"Generate bytecode for:
		| newValue |
		newValue := <top>.
		newValue = <slot value>
			ifTrue: [ <slot value> := newValue ]
			ifFalse: [
				| oldValue |
				oldValue := <slot value>.
				<slot value> := newValue.
				<receiver> propertySlot: self valueChangedFrom: oldValue to: <slot value> ].
		^ <slot value>

	Implementation:
	Although we checked whether the new value is equal to the already stored value,
	the new value is still assigned to the slot. The reason is that it might be
	equal, but not identical. To comply with standard behavior, the new value is
	always assigned. The call to the change handler is only done when values are
	not equal."

	| tempNameNewSlotValue tempNameOldSlotValue |

	tempNameNewSlotValue := '0newSlotValue'.
	tempNameOldSlotValue := '0oldSlotValue'.

	aMethodBuilder

		"Store: <newValue> := <top>"
		addTemp: tempNameNewSlotValue ;
		storeTemp: tempNameNewSlotValue ;

		"Compare: newValue = <slot value>"
		pushInstVar: index ;
		send: #= ;

		"Jump: ifFalse:"
		jumpAheadTo: #unequal if: false ;

		"Store: <slot value> := newValue"
		pushTemp: tempNameNewSlotValue ;
		storeInstVar: index ;

		"Done: assigned new value remains at <top>"
		jumpAheadTo: #done ;

		"Location ifFalse block"
		jumpAheadTarget: #unequal ;

		"Store: oldValue := <slot value>"
		pushInstVar: index ;
		addTemp: tempNameOldSlotValue ;
		storeTemp: tempNameOldSlotValue ;
		popTop ;

		"Store: <slot value> := newValue"
		pushTemp: tempNameNewSlotValue ;
		storeInstVar: index ;

		"Call: <receiver> propertySlot: <self> changedFrom: <oldValue> to: <newValue>"
		pushReceiver ;
		pushLiteral: self ;
		pushTemp: tempNameOldSlotValue ;
		pushTemp: tempNameNewSlotValue ;
		send: #propertySlot:valueChangedFrom:to: ;

		"Ignore result of previous method send (assigned new value remains on <top>)"
		popTop ;

		"Target: #done"
		jumpAheadTarget: #done
]

{ #category : #'code generation' }
CpPropertySlot >> emitValue: methodBuilder [

	"Generate bytecode for 'name' (ie variable access)"

	methodBuilder pushInstVar: index
]

{ #category : #comparing }
CpPropertySlot >> hash [

	"Answer the hash of the receiver"

	^ super hash
		bitXor: index hash
]

{ #category : #accessing }
CpPropertySlot >> index [

	"Answer the index of the receiver.
	If the receiver is virtual, this result is undefined."

	^ index
]

{ #category : #accessing }
CpPropertySlot >> index: anInteger [

	"Set the index of the receiver.
	If the receiver is virtual, setting the index is undefined."

	index := anInteger
]

{ #category : #testing }
CpPropertySlot >> isVirtual [

	"Answer whether the receiver is virtual.
	A virtual PropertySlot does not take up any slot 'space', whereas a non-virtual slot does."

	^ false
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> object: anObject instVarAt: anIndex [

	"Answer the value of the instance variable at the specified index.

	Implementation:
	This method is a copy of IndexedSlot >> #object:instVarAt:"

	<reflection: 'Object Inspection - State inspection'>

	<primitive: 73>

	"Instead of copying the fail code here, just call the method that has it"
	^ thisContext object: anObject instVarAt: anIndex
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> object: anObject instVarAt: anIndex put: aValue [

	"Set the value of the instance variable at the specified index.

	Implementation:
	This method is a copy of IndexedSlot >> #object:instVarAt:put:"

	<reflection: 'Object Modification - State modification'>

	<primitive: 74>

	"Instead of copying the fail code here, just call the method that has it"
	^ thisContext object: anObject instVarAt: anIndex put: aValue
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> read: anObject [

	"Answer the value of the specified Object's slot matching the receiver"

	<reflection: 'Object Inspection - State inspection'>

	^ self object: anObject instVarAt: index
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> write: aValue to: anObject [

	"Set the value of the specified Object's slot matching the receiver.

	Implementation:
	Also see the comment in #emitStore:"

	<reflection: 'Object Modification - State modification'>

	| oldValue |

	"If old and new value are equal (not necessarily identical) assign value and stop"
	(oldValue := self object: anObject instVarAt: index) = aValue
		ifTrue: [ ^ self object: anObject instVarAt: index put: aValue ].

	"Assign new value"
	self object: anObject instVarAt: index put: aValue.

	"Let the Object handle the value changed"
	anObject propertySlot: self valueChangedFrom: oldValue to: aValue.

	^ aValue
]
