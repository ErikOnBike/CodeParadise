Class {
	#name : #CpCalculatedPropertySlot,
	#superclass : #CpAbstractPropertySlot,
	#category : #'CodeParadise-WebApplication-MVP-Slots'
}

{ #category : #'code generation' }
CpCalculatedPropertySlot >> emitStore: methodBuilder [

	"The receiver is a calculated property and should not be written to"

	self error: ('Property {1} is calculated and can''t be written to' format: { name })
]

{ #category : #'code generation' }
CpCalculatedPropertySlot >> emitValue: methodBuilder [

	"Generate bytecode for 'self perform: name' (i.e. method send)"

	methodBuilder
		pushReceiver ;
		pushLiteral: self name ;
		send: #perform:
]

{ #category : #testing }
CpCalculatedPropertySlot >> isVirtual [

	"Answer whether the receiver is virtual.
	A virtual PropertySlot does not take up any slot 'space', whereas a non-virtual slot does."

	^ true
]

{ #category : #'meta-object-protocol' }
CpCalculatedPropertySlot >> read: anObject [

	"Delegate reading to performing 'calculation' method.

	Be aware: don't call your instVar #halt :-)"

	^ anObject perform: name
]

{ #category : #'meta-object-protocol' }
CpCalculatedPropertySlot >> write: aValue to: anObject [

	"The receiver is a calculated property and should not be written to"

	self error: ('Property {1} is calculated and can''t be written to' format: { name })
]
