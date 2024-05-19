"
I am an Input Event. I offer an interface to higher level text entry events.
To distinguish individual key strokes please also have a look at KeyEvent.
"
Class {
	#name : #CpInputEvent,
	#superclass : #CpUserInterfaceEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpInputEvent >> data [

	"Answer a String representing the inserted characters"

	^ self propertyAt: #data
]

{ #category : #accessing }
CpInputEvent >> inputType [

	"Answer a String representing the type of input.

	Valid values include:
		'insertText'
		'insertReplacementText' (when using spell-checker or autocorrect for example)
		'deleteContextBackward'
		'deleteContentForward'
		'insertFromPaste'

	For a more complete list see:
		https://rawgit.com/w3c/input-events/v1/index.html#interface-InputEvent-Attributes
	"

	^ self propertyAt: #inputType
]

{ #category : #testing }
CpInputEvent >> isComposing [

	"Answer a Boolean indicating a key is being composed"

	^ self propertyAt: #isComposing
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
