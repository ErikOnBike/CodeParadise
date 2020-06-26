Class {
	#name : #CpDragEvent,
	#superclass : #CpEvent,
	#instVars : [
		'startPoint',
		'tracePoints',
		'endPoint',
		'clientOffset'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpDragEvent class >> newFrom: aDictionary [

	"Create a new instance of the receiver based on the specified DOM event (a Javascript object encoded as a Dictionary)"

	| startPoint |

	startPoint := self pointFrom: aDictionary.

	^ (super newFrom: aDictionary)
		startPoint: startPoint ;
		yourself
]

{ #category : #accessing }
CpDragEvent class >> type [

	^ #drag
]

{ #category : #visiting }
CpDragEvent >> accept: aVisitor [

	aVisitor dragEvent: self
]

{ #category : #accessing }
CpDragEvent >> addTracePoint: aPoint [
tracePoints := OrderedCollection new.
	^ self tracePoints add: aPoint
]

{ #category : #accessing }
CpDragEvent >> endPoint [

	^ endPoint
]

{ #category : #accessing }
CpDragEvent >> endPoint: aPoint [

	endPoint := aPoint
]

{ #category : #testing }
CpDragEvent >> hasTracePoints [

	^ tracePoints isEmpty not
]

{ #category : #initialization }
CpDragEvent >> initialize [

	super initialize.

	tracePoints := OrderedCollection new
]

{ #category : #testing }
CpDragEvent >> isEnded [

	^ self endPoint notNil
]

{ #category : #accessing }
CpDragEvent >> offset [

	^ clientOffset
]

{ #category : #accessing }
CpDragEvent >> offset: aPoint [

	clientOffset := aPoint
]

{ #category : #sending }
CpDragEvent >> sendTo: anObject [

	anObject handleDragEvent: self
]

{ #category : #accessing }
CpDragEvent >> startPoint [

	^ startPoint
]

{ #category : #accessing }
CpDragEvent >> startPoint: aPoint [

	startPoint := aPoint
]

{ #category : #accessing }
CpDragEvent >> tracePoints [

	^ tracePoints
]
