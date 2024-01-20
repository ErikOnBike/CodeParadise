Class {
	#name : #SlEvent,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-Shoelace-Events'
}

{ #category : #accessing }
SlEvent class >> type [

	"Answer the JavaScript type (a String) representing the receiver.
	For Shoelace events this means:
		SlFocusEvent type -> 'sl-focus'
		SlAfterShowEvent type -> 'sl-after-show'
	"

	^ (self name withoutSuffix: 'Event') asKebabCase
]
