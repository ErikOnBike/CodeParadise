Class {
	#name : #CpButton,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpButton class >> label: labelElement [

	"Answer a new instance of the receiver with the specified label.
	Label can be a String in which case it is wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		yourself
]

{ #category : #accessing }
CpButton class >> label: labelElement suffix: suffixElement [

	"Answer a new instance of the receiver with the specified label and suffix.
	Label and suffix can be a String in which case they are wrapped inside a <span> tag."

	^ self new
		label: labelElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : #accessing }
CpButton class >> prefix: prefixElement label: labelElement [

	"Answer a new instance of the receiver with the specified prefix and label.
	Prefix and label can be a String in which case they are wrapped inside a <span> tag."

	^ self new
		prefix: prefixElement ;
		label: labelElement ;
		yourself
]

{ #category : #accessing }
CpButton class >> prefix: prefixElement label: labelElement suffix: suffixElement [

	"Answer a new instance of the receiver with the specified prefix, label and suffix.
	Prefix, label and suffix can be a String in which case they are wrapped inside a <span> tag."

	^ self new
		prefix: prefixElement ;
		label: labelElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : #'web resources' }
CpButton class >> style [

	<webResource: #css>

	^ '#container {
			display: inline-block;
			min-height: inherit;
			padding: 3px;
			border-radius: 3px;
			color: var(--control-text-color);
			background-color: var(--control-background-color, #fff);
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}
		#container:hover {
			color: var(--control-hovered-text-color); 
			background-color: var(--control-hover-background-color);
		}
		#container:active {
			color: var(--control-activated-text-color);
			background-color: var(--control-activated-background-color);
		}
		slot {
			display: inline-block;
		}
		slot[name="prefix"] {
			width: 1.25em;
			height: 1.25em;
		}
		slot[name="prefix"]::slotted(*) {
			margin-right: 3px;
		}
		slot[name="suffix"]::slotted(*) {
			margin-left: 3px;
		}
		slot[name="label"] {
			display: inline-block;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}
		slot,
		:slotted(*) {
			pointer-events: none;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}'
]

{ #category : #'web resources' }
CpButton class >> template [

	<webResource: #html>

	^ '<div id="container"><slot name="prefix"></slot><slot name="label"></slot><slot name="suffix"></slot></div>'
]

{ #category : #accessing }
CpButton >> label [

	"Answer label of receiver"

	^ self childAtSlotNamed: #label
]

{ #category : #accessing }
CpButton >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceChild: anElement asElement atSlotNamed: #label
]

{ #category : #accessing }
CpButton >> prefix [

	"Answer prefix of receiver"

	^ self childAtSlotNamed: #prefix
]

{ #category : #accessing }
CpButton >> prefix: anElement [

	"Set the specified element as the prefix of the receiver"

	self replaceChild: anElement asElement atSlotNamed: #prefix
]

{ #category : #accessing }
CpButton >> suffix [

	"Answer suffix of receiver"

	^ self childAtSlotNamed: #suffix
]

{ #category : #accessing }
CpButton >> suffix: anElement [

	"Set the specified element as the suffix of the receiver"

	self replaceChild: anElement asElement atSlotNamed: #suffix
]
