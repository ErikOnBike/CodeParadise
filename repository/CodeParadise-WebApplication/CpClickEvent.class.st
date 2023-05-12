"
I am the default click event in a browser.
Browsers do not support click events for other then primary buttons.
For more flexibility look at CpAnyClickEvent and its subclasses.
These classes allow for more control, including 'long press'.

To simply specify only the primary button is allowed without any
modifiers being down, use the following example:

	aDomElement when: CpClickEvent noModifiers send: #onClick: to: self.

"
Class {
	#name : #CpClickEvent,
	#superclass : #CpMouseEvent,
	#classVars : [
		'PrimaryClickClass',
		'SecondaryClickClass'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpClickEvent class >> primaryClickEventClass [

	"Prevent circular dependencies, therefore use this indirect access"

	^ PrimaryClickClass ifNil: [ PrimaryClickClass := Smalltalk classNamed: #CpPrimaryClickEvent ]
]

{ #category : #announcing }
CpClickEvent class >> secondaryClickEventClass [

	"Prevent circular dependencies, therefore use this indirect access"

	^ SecondaryClickClass ifNil: [ SecondaryClickClass := Smalltalk classNamed: #CpSecondaryClickEvent ]
]

{ #category : #announcing }
CpClickEvent class >> shortPrimaryNoModifiers [

	"Answer a short primary click with no key modifiers to be used as announcement class.

	For example:
		aButton when: ClickEvent shortPrimaryNoModifiers send: #onClick: to: self"

	^ self primaryClickEventClass & CpShortClick & CpNoModifiersDown
]

{ #category : #announcing }
CpClickEvent class >> shortSecondaryNoModifiers [

	"Answer a short secondary click with no key modifiers to be used as announcement class.

	For example:
		aButton when: ClickEvent shortSecondaryNoModifiers send: #onClick: to: self"

	^ self secondaryClickEventClass & CpShortClick & CpNoModifiersDown
]

{ #category : #testing }
CpClickEvent >> isStopped [

	"Answer whether the receiver has stopped propagation.

	Implementation:
	Since the synthetic event CpPrimaryClick is considered a click event,
	check there whether the receiver is stopped as well."

	^ super isStopped or: [ self class primaryClickEventClass isClickStopped: self ]
]
