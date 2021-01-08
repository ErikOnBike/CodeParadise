Class {
	#name : #CpLink,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpLink class >> label: labelElement [

	"Answer a new instance of the receiver with the specified label.
	Label can be a String in which case it is wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		yourself
]

{ #category : #'web resources' }
CpLink class >> style [

	<webResource: #css>

	^ ':host {
			display: inline;
			min-height: inherit;
			color: var(--link-text-color);
			background-color: var(--link-background-color);
			cursor: pointer;
		}
		:host(:hover) {
			color: var(--link-hovered-text-color);
			background-color: var(--link-hovered-background-color);
		}
		:host(:hover) ::slotted(*) {
			text-decoration: underline;
		}
		:host(:active) {
			color: var(--link-activated-text-color);
			background-color: var(--link-activated-background-color);
		}'
]

{ #category : #'web resources' }
CpLink class >> template [

	<webResource: #html>

	^ '<slot name="label"></slot>'
]

{ #category : #accessing }
CpLink >> label [

	"Answer label of receiver"

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
CpLink >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #label
]
