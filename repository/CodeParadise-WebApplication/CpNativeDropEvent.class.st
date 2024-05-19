"
I am a native drop event for browsers.
Except to support other native functions or external libraries,
I should probably not be used. There is a synthetic CpDragEvent
which has much better support for dragging (an CpDropEvent for
dropping). I am used internally by the synthetic CpDropEvent
to target drop zones.

"
Class {
	#name : 'CpNativeDropEvent',
	#superclass : 'CpMouseEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'accessing' }
CpNativeDropEvent class >> type [

	^ 'drop'
]
