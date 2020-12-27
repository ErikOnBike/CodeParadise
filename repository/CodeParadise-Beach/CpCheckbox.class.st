Class {
	#name : #CpCheckbox,
	#superclass : #CpView,
	#instVars : [
		'state',
		'label'
	],
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

	^ '#container {
			display: inline-block;
			min-height: inherit;
			cursor: pointer;
		}
		#box {
			display: inline-block;
			position: relative;
			top: .125em;
			width: .8em;
			height: .8em;
			margin-bottom: 3px;
			margin-right: 3px;
			border-radius: 3px;
			border: 1px solid #333;
			overflow: hidden;
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
		}'
]

{ #category : #'web resources' }
CpCheckbox class >> template [

	<webResource: #html>

	^ '<div id="container">
			<div id="box">
				<div id="tick"></div>
			</div>
			<slot name="label"></slot>
		</div>'
]

{ #category : #'state handling' }
CpCheckbox >> deselect [

	"Remove the selected attribute of the receiver"

	self removeAttributeAt: #selected.
	state := false
]

{ #category : #'event handling' }
CpCheckbox >> handleClickEvent: anEvent [

	"Announce the new state of the receiver"

	self toggle.
	self announce: (CpSelectionChanged element: self)
]

{ #category : #accessing }
CpCheckbox >> label [

	"Answer label of receiver. If no label is set yet, check if label was set from a HTML string."

	^ label ifNil: [ label := self childAtSlotNamed: #label ]
]

{ #category : #accessing }
CpCheckbox >> label: anElement [

	"Set the specified element as the label of the receiver"

	label := self replaceAllChildrenWith: anElement asElement atSlotNamed: #label
]

{ #category : #'state handling' }
CpCheckbox >> makeMixed [

	"Set #mixed as value of the selected attribute of the receiver"

	self attributeAt: #selected put: #mixed.
	state := #mixed
]

{ #category : #'state handling' }
CpCheckbox >> select [

	"Add the selected attribute to the receiver"

	self attributeAt: #selected put: #''.
	state := true
]

{ #category : #accessing }
CpCheckbox >> state [

	^ state ifNil: [ state := (self attributeAt: #selected) notNil ]
]

{ #category : #'state handling' }
CpCheckbox >> toggle [

	"Toggle the state of the receiver.
	Implementation: state can be true, false or #mixed."

	self state = true
		ifTrue: [ self deselect ]
		ifFalse: [ self select ]
]
