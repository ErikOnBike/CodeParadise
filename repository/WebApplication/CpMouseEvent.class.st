Class {
	#name : #CpMouseEvent,
	#superclass : #CpEvent,
	#instVars : [
		'mousePoint',
		'offset'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpMouseEvent class >> newFrom: aDictionary [

	"Create a new instance of the receiver based on the specified DOM event (a Javascript object encoded as a Dictionary)"

	| mousePoint offset |

	mousePoint := self pointFrom: aDictionary.
	offset := self offsetFrom: aDictionary.

	^ (super newFrom: aDictionary)
		mousePoint: mousePoint ;
		offset: offset ;
		yourself
]

{ #category : #accessing }
CpMouseEvent class >> type [

	^ #mouse
]

{ #category : #accessing }
CpMouseEvent >> mousePoint [

	^ mousePoint
]

{ #category : #accessing }
CpMouseEvent >> mousePoint: aPoint [

	mousePoint := aPoint
]

{ #category : #accessing }
CpMouseEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpMouseEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpMouseEvent >> printOn: aStream [

	self class name printOn: aStream.
	aStream nextPut: $(.
	self class type printOn: aStream.
	aStream nextPut: $,.
	self target printOn: aStream.
	aStream nextPut: $,.
	self mousePoint printOn: aStream.
	aStream nextPut: $,.
	self offset printOn: aStream.
	aStream nextPut: $)
]
