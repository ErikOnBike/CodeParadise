Class {
	#name : #CpLink,
	#superclass : #CpView,
	#instVars : [
		'label'
	],
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

	^ '#container {
			display: inline-block;
			min-height: inherit;
			color: var(--link-text-color);
			background-color: var(--link-background-color);
			cursor: pointer;
		}	
		#container:hover {
			text-decoration: underline;
			color: var(--link-hovered-text-color);
			background-color: var(--link-hovered-background-color);
		}
		#container:active {
			color: var(--link-activated-text-color);
			background-color: var(--link-activated-background-color);
		}'
]

{ #category : #'web resources' }
CpLink class >> template [

	<webResource: #html>

	^ '<div id="container"><slot name="label"></slot></div>'
]

{ #category : #accessing }
CpLink >> label [

	"Answer label of receiver. If no label is set yet, check if label was set from a HTML string."

	^ label ifNil: [ label := self childAtSlotNamed: #label ]
]

{ #category : #accessing }
CpLink >> label: anElement [

	"Set the specified element as the label of the receiver"

	label := self replaceAllChildrenWith: anElement asElement atSlotNamed: #label
]
