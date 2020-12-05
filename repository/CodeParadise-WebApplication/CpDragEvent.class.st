Class {
	#name : #CpDragEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'offset',
		'tracePoints',
		'endPoint'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpDragEvent >> addTracePoint: aPoint [

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
CpDragEvent >> lastPoint [

	^ self isEnded
		ifTrue: [ self endPoint ]
		ifFalse: [ self tracePoints last ]
]

{ #category : #accessing }
CpDragEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpDragEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #printing }
CpDragEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', endPoint: '.
	self endPoint printOn: aStream.
	aStream nextPutAll: ', offset: '.
	self offset printOn: aStream
]

{ #category : #visiting }
CpDragEvent >> sendTo: anObject [

	anObject handleDragEvent: self
]

{ #category : #accessing }
CpDragEvent >> tracePoints [

	^ tracePoints
]
