"
I am an Input Event. I offer an interface to higher level text entry events.
To distinguish individual key strokes please also have a look at KeyEvent.
"
Class {
	#name : #CpInputEvent,
	#superclass : #CpUserInterfaceEvent,
	#instVars : [
		'data',
		'inputType'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpInputEvent >> data [

	^ data
]

{ #category : #accessing }
CpInputEvent >> data: aString [

	data := aString
]

{ #category : #accessing }
CpInputEvent >> inputType [

	^ inputType
]

{ #category : #accessing }
CpInputEvent >> inputType: aString [

	inputType := aString
]

{ #category : #printing }
CpInputEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', data: ' ;
		print: self data ;
		nextPutAll: ', inputType: ' ;
		print: self inputType
]
