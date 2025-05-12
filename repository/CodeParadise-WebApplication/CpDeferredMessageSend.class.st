"
I am a MessageSend that gets send in a forked Process.
My purpose is very specific for situations where an event handler
is using a Promise await. The event processor does not allow any
event handler to wait, therefore such event handlers need to be
executed in a forked Process.

My implementation is limited to the above scenario. I do not work
as expected when more than one argument is provided, for example.
I only expect a single argument, the Event/Announcement being handled.

Typically I am used in the form:
	someElement when: CpClickEvent forkedSend: #handleClick: to: self
"
Class {
	#name : #CpDeferredMessageSend,
	#superclass : #MessageSend,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #evaluating }
CpDeferredMessageSend >> cull: anEvent [

	"Evaluate the receiver in a separate Process"

	self selector numArgs = 0
		ifTrue: [ CpGlobalThis defer: [ super value ] ]
		ifFalse: [
			| copyEvent |

			"Because events change while bubbling, create a (stopped) copy"
			copyEvent := anEvent copy.
			CpGlobalThis defer: [ super value: copyEvent ] ]
]

{ #category : #support }
CpDeferredMessageSend >> deferred [

	"Answer a deferred version of the receiver"

	^ self
]
