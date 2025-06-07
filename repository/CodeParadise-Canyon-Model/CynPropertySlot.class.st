"
I am a Slot that uses a specific instance variable in the CpPropertyModel to store all property slot values.
The property values are stored in a Dictionary, indexed by the property's name.

Furthermore my definitions are stored in a class instance variable of CpPropertyModel to allow interogating
my definitions. These definitions are dynamic to allow different applications to keep track of their own
set of definitions without the need to create new subclasses.

Be aware:
This technique can be used inside CodeParadise's tiny image, only because the code generated for this
type of slot is hardcoded to use instance methods of the CpPropertyModel and does not require the elaborate
SlotLayout mechanism which is used in Pharo for all slots. Every slot access (i.e. access through the variable
name inside methods) will generate this specific code and is therefore free of any other dependencies.

"
Class {
	#name : #CynPropertySlot,
	#superclass : #CynAbstractPropertySlot,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'class initialization' }
CynPropertySlot class >> postInstall [

	"This is a stop gap method to notice if the receiver is installed in a ClientEnvironment.
	This should NOT happen. Since it is part of the slot-mechanism of Pharo which is not
	present in the tiny image of CodeParadise."

	self error: 'I should not be installed in a ClientEnvironment!'
]

{ #category : #accessing }
CynPropertySlot class >> propertyCategory [

	^ CynClientReadWritePropertySlot propertyCategory
]

{ #category : #'code generation' }
CynPropertySlot >> emitStore: methodBuilder [

	"Generate bytecode for 'rcvr rawAt: name put: <stackTop>'"

	| tempName |

	tempName := '0slotTempForStackManipulation'.

	methodBuilder
		addTemp: tempName ;
		storeTemp: tempName ;
		popTop ;
		pushReceiver ;
		pushLiteral: self name ;
		pushTemp: tempName ;
		send: #rawAt:put:
]

{ #category : #'code generation' }
CynPropertySlot >> emitValue: methodBuilder [

	"Generate bytecode for 'data at: name ifAbsent: nil'"

	methodBuilder
		pushInstVar: (self owningClass instVarIndexFor: #data) ;
		pushLiteral: self name ;
		pushLiteral: nil ;
		send: #at:ifAbsent:
]

{ #category : #'meta-object-protocol' }
CynPropertySlot >> read: anObject [

	"Delegate reading to property getter"

	^ anObject rawAt: name
]

{ #category : #'meta-object-protocol' }
CynPropertySlot >> write: aValue to: anObject [

	"Delegate writing to property setter"

	^ anObject rawAt: name put: aValue
]
