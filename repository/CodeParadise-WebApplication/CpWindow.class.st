"
I am a View representing a Window.
"
Class {
	#name : #CpWindow,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #'web resources' }
CpWindow class >> style [

	<webResource: #css>

	^':host {
		position: absolute;
		left: 0;
		top: 0;
		width: 30em;
		height: 6em;
		background-color: rgba(255, 0, 0, .1);
		cursor: move;
		user-select: none;
		-webkit-user-select: none;
	}'
]

{ #category : #'web resources' }
CpWindow class >> template [

	<webResource: #html>

	^ '<div><slot></slot></div>'
]

{ #category : #'event handling' }
CpWindow >> handleClickEvent: clickEvent [

	self crTrace: clickEvent printString
]

{ #category : #'event handling' }
CpWindow >> handleDragEvent: aDragEvent [

	| clientOffset point |

	clientOffset := aDragEvent offset.
	point := aDragEvent isEnded
		ifTrue: [ aDragEvent endPoint ]
		ifFalse: [ aDragEvent tracePoints last ].

	self styleAt: 'transform' put: 'translate(', (point x - clientOffset x) printString, 'px,', (point y - clientOffset y) printString, 'px)'

]
