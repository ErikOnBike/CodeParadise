Class {
	#name : #CpUserInterfaceEvent,
	#superclass : #CpEvent,
	#instVars : [
		'pageX',
		'pageY'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpUserInterfaceEvent >> pageX [

	^ pageX
]

{ #category : #accessing }
CpUserInterfaceEvent >> pageX: aNumber [

	pageX := aNumber
]

{ #category : #accessing }
CpUserInterfaceEvent >> pageY [

	^ pageY
]

{ #category : #accessing }
CpUserInterfaceEvent >> pageY: aNumber [

	pageY := aNumber
]

{ #category : #accessing }
CpUserInterfaceEvent >> point [

	^ pageX @ pageY
]

{ #category : #accessing }
CpUserInterfaceEvent >> point: aPoint [

	pageX := aPoint x.
	pageY := aPoint y
]

{ #category : #printing }
CpUserInterfaceEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', point: ' ;
		print: self point

]
