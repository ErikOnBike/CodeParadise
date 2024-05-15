Class {
	#name : 'CpLink',
	#superclass : 'CpControl',
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'accessing' }
CpLink class >> label: labelElement [

	"Answer a new instance of the receiver with the specified label.
	Label can be a String in which case it is wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		yourself
]

{ #category : 'web resources' }
CpLink class >> style [

	<webResource: #css>

	^ ':host {
			display: inline;
			min-height: inherit;
			color: var(--link-text-color);
			white-space: nowrap;
			cursor: pointer;
		}
		:host(:not([disabled]):hover) {
			color: var(--link-hovered-text-color);
		}
		:host(:not([disabled]):active) {
			color: var(--link-activated-text-color);
		}
		:host([disabled]) {
			color: #aaa;
			cursor: auto;
		}
		:host(:hover) slot,
		:host(:hover) ::slotted(*) {
			text-decoration: underline;
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
CpLink class >> template [

	<webResource: #html>

	^ '<slot name="label"></slot>'
]

{ #category : 'accessing' }
CpLink >> label [

	"Answer label of receiver"

	^ self firstChildAtSlotNamed: #label
]

{ #category : 'accessing' }
CpLink >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #label
]
