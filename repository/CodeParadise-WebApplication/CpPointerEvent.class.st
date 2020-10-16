Class {
	#name : #CpPointerEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'elementId',
		'offset'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpPointerEvent >> elementId [

	"Answer the id of the DOM element which first received the event.
	This can be either the target of the event or a descendant. In case of a TemplateComponent
	this can also be the id of an element inside the shadow DOM."

	^ elementId
]

{ #category : #accessing }
CpPointerEvent >> elementId: aString [

	elementId := aString
]

{ #category : #accessing }
CpPointerEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpPointerEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpPointerEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', target: '.
	self target printOn: aStream.
	aStream nextPutAll: ', elementId: '.
	self elementId printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream
]
