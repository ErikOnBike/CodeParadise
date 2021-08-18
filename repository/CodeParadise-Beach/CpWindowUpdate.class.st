Class {
	#name : #CpWindowUpdate,
	#superclass : #Announcement,
	#instVars : [
		'position',
		'size'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #initialization }
CpWindowUpdate class >> position: aPoint size: anotherPoint [

	^ self new
		position: aPoint size: anotherPoint ;
		yourself
]

{ #category : #accessing }
CpWindowUpdate >> position [

	^ position
]

{ #category : #initialization }
CpWindowUpdate >> position: aPoint size: anotherPoint [

	position := aPoint.
	size := anotherPoint
]

{ #category : #accessing }
CpWindowUpdate >> size [

	^ size
]
