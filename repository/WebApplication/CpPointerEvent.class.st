Class {
	#name : #CpPointerEvent,
	#superclass : #CpEvent,
	#instVars : [
		'target',
		'elementId',
		'point',
		'offset'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpPointerEvent class >> newFrom: aDictionary [

	| target |

	target := aDictionary at: #target ifAbsent: [ self error: 'DOM event should have a target' ].

	^ (super newFrom: aDictionary)
		target: target ;
		elementId: (aDictionary at: #elementId ifAbsent: [ nil ]) ;
		point: (self pointFrom: aDictionary) ;
		offset: (self offsetFrom: aDictionary) ;
		yourself
]

{ #category : #utilities }
CpPointerEvent class >> offsetFrom: aDictionary [

	^ ((aDictionary at: #offsetX ifAbsent: [ 0 ]) ifNil: [ 0 ]) @ ((aDictionary at: #offsetY ifAbsent: [ 0 ]) ifNil: [ 0 ])
]

{ #category : #utilities }
CpPointerEvent class >> pointFrom: aDictionary [

	^ (aDictionary at: #x ifAbsent: [ 0 ]) @ (aDictionary at: #y ifAbsent: [ 0 ])
]

{ #category : #accessing }
CpPointerEvent class >> type [

	^ #pointer
]

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

{ #category : #testing }
CpPointerEvent >> isPointerEvent [

	^ true
]

{ #category : #accessing }
CpPointerEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpPointerEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #accessing }
CpPointerEvent >> point [

	^ point
]

{ #category : #accessing }
CpPointerEvent >> point: aPoint [

	point := aPoint
]

{ #category : #printing }
CpPointerEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', target: '.
	self target printOn: aStream.
	aStream nextPutAll: ', elementId: '.
	self elementId printOn: aStream.
	aStream nextPutAll: ', point: '.
	self point printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream
]

{ #category : #accessing }
CpPointerEvent >> target [

	^ target
]

{ #category : #accessing }
CpPointerEvent >> target: aDomElement [

	target := aDomElement
]
