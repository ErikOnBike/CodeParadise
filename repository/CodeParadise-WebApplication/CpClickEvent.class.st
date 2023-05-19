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

{ #category : #conditionals }
CpClickEvent class >> addConditionsToDenySpecialsTo: aConditionalEvent [

	"Add condition to specified conditional event which prevents special conditions to be allowed.
	A short click is considered 'regular' therefore set this as a required condition (thereby
	prevent the special long click from being accepted)."

	aConditionalEvent addCondition: CpShortClick
]

{ #category : #announcing }
CpClickEvent class >> basicPrimary [

	"Answer a primary click event to be used as announcement class
	in which only a short click and no modifiers are allowed.

	For example:
		aButton when: ClickEvent basicPrimary send: #onBasicClick: to: self"

	^ self primary only
]

{ #category : #announcing }
CpClickEvent class >> basicSecondary [

	"Answer a secondary click event to be used as announcement class
	in which only a short click and no modifiers are allowed.

	For example:
		aButton when: ClickEvent basicSecondary send: #onBasicRightClick: to: self"

	^ self secondary only
]

{ #category : #announcing }
CpClickEvent class >> primary [

	"Answer a primary click event to be used as announcement class.

	For example:
		aButton when: ClickEvent primary send: #onClick: to: self"

	^ self primaryClickEventClass
]

{ #category : #announcing }
CpClickEvent class >> primaryClickEventClass [

	"Answer the class representing the primary click (a synthetic event)"

	^ CpPrimaryClickEvent
]

{ #category : #announcing }
CpClickEvent class >> secondary [

	"Answer a secondary click event to be used as announcement class.

	For example:
		aButton when: ClickEvent secondary send: #onRightClick: to: self"

	^ self secondaryClickEventClass
]

{ #category : #announcing }
CpClickEvent class >> secondaryClickEventClass [

	"Answer the class representing the secondary click (a synthetic event)"

	^ CpSecondaryClickEvent
]

{ #category : #testing }
CpClickEvent >> isStopped [

	"Answer whether the receiver has stopped propagation.

	Implementation:
	Since the synthetic event CpPrimaryClick is considered a click event,
	check there whether the receiver is stopped as well."

	^ super isStopped or: [ self class primaryClickEventClass isClickStopped: self ]
]
