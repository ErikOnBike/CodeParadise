"
I am a Slot that uses a specific instance variable in the CpPropertyModel to store all property slot values.
The property values are stored in a Dictionary, indexed by the property's name.

Furthermore my definitions are stored in a class instance variable of CpPropertyModel to allow interogating
my definitions. These definitions are dynamic to allow different applications to keep track of their own
set of definitions without the need to create new subclasses.

Be aware:
This technique can be used inside CodeParadise's tiny image, only because the code generated for this
type of slot is hardcoded to the specific superclass and does not require the elaborate SlotLayout
mechanism which is used in Pharo for all slots. Every slot access (i.e. access through the variable
name inside methods) will generate this specific code and is therefore free of any other dependencies.

"
Class {
	#name : #CpPropertySlot,
	#superclass : #DerivedSlot,
	#category : #'CodeParadise-Model-Property'
}

{ #category : #'class initialization' }
CpPropertySlot class >> postInstall [

	"This is a stop gap method to notice if the receiver is installed in a ClientEnvironment.
	This should NOT happen. Since it is part of the slot-mechanism of Pharo which is not
	present in the tiny image of CodeParadise."

	self error: 'I should not be installed in a ClientEnvironment!'
]

{ #category : #'code generation' }
CpPropertySlot >> emitStore: methodBuilder [

	"Generate bytecode for 'rcvr instVarNamed: self name put: <stackTop>'"

	| tempName |

	tempName := '0slotTempForStackManipulation'.

	methodBuilder
		addTemp: tempName ;
		storeTemp: tempName ;
		popTop ;
		pushReceiver ;
		pushLiteral: self name ;
		pushTemp: tempName ;
		send: #propertyAt:put:
]

{ #category : #'code generation' }
CpPropertySlot >> emitValue: methodBuilder [

	"Generate bytecode for 'rcvr instVarNamed: self name'"

	methodBuilder
		pushReceiver ;
		pushLiteral: self name ;
		send: #propertyAt:
]

{ #category : #testing }
CpPropertySlot >> isAccessedIn: aCompiledMethod [

	"Return whether the receiver is accessed in the specified Method.

	Pay attention that the compiler is free to remove unused variable. The access is only garanteed for used
	instance variables e.g. part of return, expression, assignment..."

	^ aCompiledMethod ast instanceVariableNodes
		anySatisfy: [ :node | node binding == self ]
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> read: anObject [

	"Delegate reading to property getter"

	^ anObject propertyAt: self name
]

{ #category : #'meta-object-protocol' }
CpPropertySlot >> write: aValue to: anObject [

	"Delegate writing to property setter"

	^ anObject propertyAt: self name put: aValue
]
