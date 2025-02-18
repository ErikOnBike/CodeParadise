Class {
	#name : #CpForkedMessageSend,
	#superclass : #MessageSend,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #evaluating }
CpForkedMessageSend >> cull: anObject [

	"Evaluate the receiver in a separate Process"

	[ super cull: anObject ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> cull: arg1 cull: arg2 [

	"Evaluate the receiver in a separate Process"

	[ super cull: arg1 cull: arg2 ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> cull: arg1 cull: arg2 cull: arg3 [

	"Evaluate the receiver in a separate Process"

	[ super cull: arg1 cull: arg2 cull: arg3 ] fork
]

{ #category : #support }
CpForkedMessageSend >> forked [

	"Answer a forked version of the receiver"

	^ self
]

{ #category : #evaluating }
CpForkedMessageSend >> value [

	"Evaluate the receiver in a separate Process"

	[ super value ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> value: anObject [

	"Evaluate the receiver in a separate Process"

	[ super value: anObject ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> value: arg1 value: arg2 [

	"Evaluate the receiver in a separate Process"

	[ super value: arg1 value: arg2 ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> value: arg1 value: arg2 value: arg3 [

	"Evaluate the receiver in a separate Process"

	[ super value: arg1 value: arg2 value: arg3 ] fork
]

{ #category : #evaluating }
CpForkedMessageSend >> valueWithArguments: anArray [

	"Evaluate the receiver in a separate Process"

	[ super valueWithArguments: anArray ] fork
]
