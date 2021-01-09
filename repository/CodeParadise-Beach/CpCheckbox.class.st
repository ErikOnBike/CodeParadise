Class {
	#name : #CpCheckbox,
	#superclass : #CpInputControl,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpCheckbox class >> label: labelElement [

	"Answer a new instance of the receiver with the specified label.
	Label can be a String in which case it is wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		yourself
]

{ #category : #'web resources' }
CpCheckbox class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		:host {
			display: inline;
			min-height: inherit;
			white-space: nowrap;
			cursor: pointer;
		}
		#box {
			display: inline-block;
			position: relative;
			top: .08em;
			width: .9em;
			height: .9em;
			border-radius: .2em;
			border: 1px solid #ccc;
			background-color: #fff;
			overflow: hidden;
			transition: border-color .1s;
			-webkit-mask-image: -webkit-radial-gradient(white, black);
		}
		:host(:not([selected]):hover) #box {
			border-color: #666;
		}
		#tick {
			position: absolute;
			left: -50%;
			top: -50%;
			right: -50%;
			bottom: -50%;
			background-color: var(--control-activated-background-color);
			transform: rotate(0) translate(0,100%);
			transition: transform .5s;
		}
		:host([selected=""]) #tick {
			transform: rotate(0) translate(0,0);
		}
		:host([selected="mixed"]) #tick {
			transform: rotate(-45deg) translate(0,50%);
		}
		:host([readonly]),
		:host([disabled]) {
			pointer-events: none;
			cursor: auto;
		}
		:host([readonly]) #box,
		:host([disabled]) #box {
			color: #aaa;
			border-color: #aaa;
		}
		:host([readonly]) #tick,
		:host([disabled]) #tick {
			background-color: #aaa;
		}
		:host([readonly]) slot,
		:host([disabled]) slot {
			color: #aaa;
		}
		/* Do not allow children to be clickable or selectable */
		*,
		::slotted(*) {
			/* pointer-events: none; -- Bug in Safari prevents using this outside a layout container */
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}'
]

{ #category : #'web resources' }
CpCheckbox class >> template [

	<webResource: #html>

	^ '<div id="box">
			<div id="tick"></div>
	</div>
	<slot name="label"></slot>'
]

{ #category : #announcing }
CpCheckbox >> announceChange [

	self announce: (CpSelectionChanged element: self)
]

{ #category : #'state handling' }
CpCheckbox >> deselect [

	"Make the receiver deselected.

	Implementation:
	Remove the selected attribute of the receiver."

	self ifNotSelected: [ ^ self ].

	self
		removeAttributeAt: #selected ;
		announceChange
]

{ #category : #'event handling' }
CpCheckbox >> handleClickEvent: anEvent [

	"Handle click on the receiver"

	self ifNotSelectable: [ ^ self ].

	self toggle
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifMixed: aBlock [

	"Evaluate the specified block if the receiver is mixed.

	Implementation: a checkbox can be in state selected, deselected or mixed."

	self ifSelected: [ "intentionally empty" ] ifMixed: aBlock ifNotSelected: [ "intentionally empty" ]
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifNotSelectable: aBlock [

	"Evaluate the specified block if the receiver is not selectable.

	Implementation: a checkbox can be read-only or disabled."

	self ifSelectable: [ "intentionally empty" ] ifNotSelectable: aBlock
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifNotSelected: aBlock [

	"Evaluate the specified block if the receiver is deselected.

	Implementation: a checkbox can be in state selected, deselected or mixed."

	self ifSelected: [ "intentionally empty" ] ifMixed: [ "intentionally empty" ] ifNotSelected: aBlock
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifSelectable: aBlock [

	"Evaluate the specified block if the receiver is selectable.

	Implementation: a checkbox can be read-only or disabled."

	self ifSelectable: aBlock ifNotSelectable: [ "intentionally empty" ]
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifSelectable: selectableBlock ifNotSelectable: notSelectableBlock [

	"Evaluate the block matching the receiver's selectability.

	Implementation: a checkbox can be read-only or disabled."

	(self attributeAt: #readonly)
		ifNotNil: [ notSelectableBlock value ]
		ifNil: [
			(self attributeAt: #disabled)
				ifNotNil: [ notSelectableBlock value ]
				ifNil: [ selectableBlock value ] ]
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifSelected: aBlock [

	"Evaluate the specified block if the receiver is selected.

	Implementation: a checkbox can be in state selected, deselected or mixed."

	self ifSelected: aBlock ifMixed: [ "intentionally empty" ] ifNotSelected: [ "intentionally empty" ]
]

{ #category : #'testing - conditionals' }
CpCheckbox >> ifSelected: selectedBlock ifMixed: mixedBlock ifNotSelected: deselectedBlock [

	"Evaluate the block which represents the receiver's state.

	Implementation:
	A checkbox can be in state selected, deselected or mixed.
	See the corresponding methods how state is represented."

	(self attributeAt: #selected)
		ifNotNil: [ :selected |
			selected
				ifEmpty: [ selectedBlock value ]
				ifNotEmpty: [ mixedBlock value ] ]
		ifNil: [ deselectedBlock value ]
]

{ #category : #initialization }
CpCheckbox >> initialize [

	super initialize.

	self when: CpClickEvent send: #handleClickEvent: to: self
]

{ #category : #accessing }
CpCheckbox >> label [

	"Answer label of receiver"

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
CpCheckbox >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #label
]

{ #category : #'state handling' }
CpCheckbox >> makeMixed [

	"Make the receiver mixed (state 'between' selected and deselected).

	Implementation:
	Set #mixed as value of the selected attribute of the receiver."

	self ifMixed: [ ^ self ].

	self
		attributeAt: #selected put: #mixed ;
		announceChange
]

{ #category : #'state handling' }
CpCheckbox >> select [

	"Make the receiver selected.

	Implementation:
	Add the selected attribute to the receiver (with empty value)."

	self ifSelected: [ ^ self ].

	self
		attributeAdd: #selected ;
		announceChange
]

{ #category : #'state handling' }
CpCheckbox >> toggle [

	"Toggle the state of the receiver.
	The receiver becomes selected if not already selected (not selected or mixed) and
	becomes not selected if already selected."

	self
		ifSelected: [ self deselect ]
		ifMixed: [ self select ]
		ifNotSelected: [ self select ]
]
