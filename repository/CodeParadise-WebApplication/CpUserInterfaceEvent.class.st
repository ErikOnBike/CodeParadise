Class {
	#name : #CpUserInterfaceEvent,
	#superclass : #CpEvent,
	#instVars : [
		'point'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpUserInterfaceEvent >> point [

	^ point
]

{ #category : #accessing }
CpUserInterfaceEvent >> point: aPoint [

	point := aPoint
]

{ #category : #printing }
CpUserInterfaceEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', point: '.
	self point printOn: aStream.

]
