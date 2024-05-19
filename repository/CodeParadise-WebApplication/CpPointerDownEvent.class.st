Class {
	#name : 'CpPointerDownEvent',
	#superclass : 'CpPointerEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'converting' }
CpPointerDownEvent >> asClickEvent [

	"Answer an instance of CpAnyClickEvent (or one of its subclasses) representing
	the click event resulting from the receiver and a matching pointerup event."

	| button clickEventClass |

	button := self button.
	clickEventClass :=
		button = 0
			ifTrue: [ CpPrimaryClickEvent ]
			ifFalse: [
				button = 2
					ifTrue: [ CpSecondaryClickEvent ]
					ifFalse: [ CpAnyClickEvent ] ].

	^ clickEventClass newFromPointerEvent: self
]
