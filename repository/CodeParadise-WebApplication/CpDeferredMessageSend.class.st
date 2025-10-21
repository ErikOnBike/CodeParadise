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

	"Evaluate the receiver in a separate Process.

	Implementation:
	Either use the 'fixed' argument set in the receiver
	or if not present, use the event leading to this invocation.
	In the latter case, copy the event, because it will change
	while bubbling up and become unusable once the receiver is
	sent (deferred)."

	self selector numArgs = 0
		ifTrue: [ CpGlobalThis defer: [ super value ] ]
		ifFalse: [
			| argument |

			"Either use the 'fixed' argument, otherwise the even"
			argument := self numArgs > 0
				ifTrue: [ self arguments first ]
				ifFalse: [
					"Because events change while bubbling, create a (stopped) copy"
					argument := anEvent copy ].
			CpGlobalThis defer: [ super value: argument ] ]
]

{ #category : #support }
CpDeferredMessageSend >> deferred [

	"Answer a deferred version of the receiver"

	^ self
]
