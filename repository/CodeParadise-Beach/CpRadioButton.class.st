Class {
	#name : 'CpRadioButton',
	#superclass : 'CpInputControl',
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'accessing' }
CpRadioButton class >> label: labelElement [

	"Answer a new instance of the receiver with the specified label.
	Label can be a String in which case it is wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		yourself
]

{ #category : 'web resources' }
CpRadioButton class >> style [

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
			border-radius: 50%;
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
			left: 0;
			top: 0;
			right: 0;
			bottom: 0;
			border-radius: 50%;
			background-color: var(--control-activated-background-color);
			transform: scale(0);
			transition: transform .5s;
		}
		:host([selected]) #tick {
			transform: scale(1);
		}
		:host([readonly]),
		:host([disabled]) {
			cursor: auto;
			pointer-events: none;
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

{ #category : 'web resources' }
CpRadioButton class >> template [

	<webResource: #html>

	^ '<div id="box">
			<div id="tick"></div>
	</div>
	<slot name="label"></slot>'
]

{ #category : 'announcing' }
CpRadioButton >> announceChange [

	self announce: (CpSelectionChanged element: self)
]

{ #category : 'state handling' }
CpRadioButton >> deselect [

	"Remove the selected attribute of the receiver"

	self ifNotSelected: [ ^ self ].

	self
		removeAttributeAt: #selected ;
		announceChange
]

{ #category : 'event handling' }
CpRadioButton >> handleClickEvent: anEvent [

	"Handle click on the receiver"

	self ifNotSelectable: [ ^ self ].

	self select
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifNotSelectable: aBlock [

	"Evaluate the specified block if the receiver is not selectable.

	Implementation: a radio button can be read-only or disabled."

	self ifSelectable: [ "intentionally empty" ] ifNotSelectable: aBlock
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifNotSelected: aBlock [

	"Evaluate the specified block if the receiver is not selected.

	Implementation: a radio button can be in state selected or deselected."

	self ifSelected: [ "intentionally empty" ] ifNotSelected: aBlock
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifSelectable: aBlock [

	"Evaluate the specified block if the receiver is selectable.

	Implementation: a radio button can be read-only or disabled."

	self ifSelectable: aBlock ifNotSelectable: [ "intentionally empty" ]
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifSelectable: selectableBlock ifNotSelectable: notSelectableBlock [

	"Evaluate the block matching the receiver's selectability.

	Implementation: a radio button can be read-only or disabled."

	(self attributeAt: #readonly)
		ifNotNil: [ notSelectableBlock value ]
		ifNil: [
			(self attributeAt: #disabled)
				ifNotNil: [ notSelectableBlock value ]
				ifNil: [ selectableBlock value ] ]
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifSelected: aBlock [

	"Evaluate the specified block if the receiver is selected.

	Implementation: a radio button can be in state selected or deselected."

	self ifSelected: aBlock ifNotSelected: [ "intentionally empty" ]
]

{ #category : 'testing - conditionals' }
CpRadioButton >> ifSelected: selectedBlock ifNotSelected: deselectedBlock [

	"Evaluate the block which represents the receiver's state.

	Implementation:
	A radio button can be in state selected or deselected.
	See the corresponding methods how state is represented."

	(self attributeAt: #selected)
		ifNotNil: [ selectedBlock value ]
		ifNil: [ deselectedBlock value ]
]

{ #category : 'initialization' }
CpRadioButton >> initialize [

	super initialize.

	self when: CpPrimaryClickEvent send: #handleClickEvent: to: self
]

{ #category : 'accessing' }
CpRadioButton >> label [

	"Answer label of receiver"

	^ self firstChildAtSlotNamed: #label
]

{ #category : 'accessing' }
CpRadioButton >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #label
]

{ #category : 'state handling' }
CpRadioButton >> select [

	"Add the selected attribute to the receiver"

	self ifSelected: [ ^ self ].

	self
		attributeAdd: #selected ;
		announceChange
]
