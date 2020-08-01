Class {
	#name : #FuiEventHandler,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-Fomantic-Core'
}

{ #category : #events }
FuiEventHandler >> handleEvent: anEvent [

	self flag: #todo.	"Needs refactoring in different event handlers"

	anEvent isPointerEvent
		ifTrue: [ ^ self handlePointerEvent: anEvent ].

	self crTrace: 'FUI ', anEvent printString
]

{ #category : #events }
FuiEventHandler >> handlePointerEvent: aPointerEvent [

	| element |

	element := aPointerEvent target.
	element canHandleEvents
		ifFalse: [ ^ self ].

	aPointerEvent sendTo: element
]
