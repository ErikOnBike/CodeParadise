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
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpClickEvent class >> shortPrimaryNoModifiers [

	"Answer a short primary click with no key modifiers to be used as announcement class.

	For example:
		aButton when: ClickEvent shortPrimaryUnmodified send: #onClick: to: self"

	^ CpPrimaryClickEvent & CpShortClick & CpNoModifiersDown
]

{ #category : #announcing }
CpClickEvent class >> shortSecondaryNoModifiers [

	"Answer a short secondary click with no key modifiers to be used as announcement class.

	For example:
		aButton when: ClickEvent shortSecondaryUnmodified send: #onClick: to: self"

	^ CpSecondaryClickEvent & CpShortClick & CpNoModifiersDown
]
