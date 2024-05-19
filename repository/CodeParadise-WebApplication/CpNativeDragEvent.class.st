"
I am a native drag event for browsers.
Except to support other native functions or external libraries,
I should probably not be used. There is a synthetic CpDragEvent
which has much better support for dragging (an CpDropEvent for
dropping).

"
Class {
	#name : 'CpNativeDragEvent',
	#superclass : 'CpMouseEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}

{ #category : 'accessing' }
CpNativeDragEvent class >> type [

	^ 'drag'
]
