Class {
	#name : #WaEvent,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-WebAwesome-Events'
}

{ #category : #accessing }
WaEvent class >> type [

	"Answer the JavaScript type (a String) representing the receiver.
	For WebAwesome events this means:
		WaCancelEvent type -> 'wa-cancel'
		WaAfterShowEvent type -> 'wa-after-show'
	"

	^ (self name withoutSuffix: 'Event') asKebabCase
]
