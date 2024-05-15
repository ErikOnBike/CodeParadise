Class {
	#name : 'CpWindowUpdate',
	#superclass : 'Announcement',
	#instVars : [
		'position',
		'width',
		'height'
	],
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'initialization' }
CpWindowUpdate class >> position: aPoint width: widthInteger height: heightInteger [

	"Answer an instance of the receiver with specified properties. Width and height might be nil."

	^ self new
		initializeWithPosition: aPoint width: widthInteger height: heightInteger ;
		yourself
]

{ #category : 'accessing' }
CpWindowUpdate >> height [

	^ height
]

{ #category : 'initialization' }
CpWindowUpdate >> initializeWithPosition: aPoint width: widthInteger height: heightInteger [

	self initialize.

	position := aPoint.
	width := widthInteger.
	height := heightInteger
]

{ #category : 'accessing' }
CpWindowUpdate >> position [

	^ position
]

{ #category : 'accessing' }
CpWindowUpdate >> width [

	^ width
]
