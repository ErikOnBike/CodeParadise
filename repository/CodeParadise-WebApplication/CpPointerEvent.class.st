Class {
	#name : #CpPointerEvent,
	#superclass : #CpMouseEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpPointerEvent >> pointerId [

	"Answer a Number representing the unique id of the 'active' pointer event
	(it should be equal between pointer up and down events)"

	^ self propertyAt: #pointerId
]

{ #category : #accessing }
CpPointerEvent >> pointerType [

	"Answer a String presenting the type of pointer.

	Possible values:
		'mouse'
		'pen'
		'touch'

	A browser might also answer an empty String (for non-compatible devices) or a vendor-prefixed
	value for other (non-standard) types of devices."

	^ self propertyAt: #pointerType
]

{ #category : #printing }
CpPointerEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', pointerId: ' ;
		print: self pointerId ;
		nextPutAll: ', pointerType: ' ;
		print: self pointerType
]
