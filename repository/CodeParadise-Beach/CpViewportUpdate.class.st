Class {
	#name : #CpViewportUpdate,
	#superclass : #Announcement,
	#instVars : [
		'position'
	],
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpViewportUpdate class >> position: aPoint [

	^ self new
		position: aPoint ;
		yourself
]

{ #category : #accessing }
CpViewportUpdate >> position [

	^ position
]

{ #category : #accessing }
CpViewportUpdate >> position: aPoint [

	position := aPoint
]
