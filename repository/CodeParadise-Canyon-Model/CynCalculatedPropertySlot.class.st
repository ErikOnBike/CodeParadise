Class {
	#name : #CynCalculatedPropertySlot,
	#superclass : #CynAbstractPropertySlot,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynCalculatedPropertySlot class >> propertyCategory [

	^ CynClientCalculatedPropertySlot propertyCategory
]

{ #category : #nil }
CynCalculatedPropertySlot >> emitStore: methodBuilder [

	self error: ('Property {1} is calculated and can''t be written to' format: { name })
]

{ #category : #'code generation' }
CynCalculatedPropertySlot >> emitValue: methodBuilder [

	"Generate bytecode for 'self perform: name"

	methodBuilder
		pushReceiver ;
		pushLiteral: self name ;
		send: #perform:
]

{ #category : #'meta-object-protocol' }
CynCalculatedPropertySlot >> read: anObject [

	"Delegate reading to performing 'calculation' method.

	Be aware: don't call your instVar #halt :-)"

	^ anObject perform: name
]

{ #category : #'meta-object-protocol' }
CynCalculatedPropertySlot >> write: aValue to: anObject [

	self error: ('Property {1} is calculated and can''t be written to' format: { name })
]
