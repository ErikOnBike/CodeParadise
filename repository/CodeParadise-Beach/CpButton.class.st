Class {
	#name : #CpButton,
	#superclass : #CpControl,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #accessing }
CpButton class >> icon: anElement [

	"Answer a new instance of the receiver with the specified icon (acting as label)"

	^ self new
		addClass: #icon ;
		label: anElement ;
		yourself
]

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

	^ '	*, *:before, *:after {
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		:host {
			display: inline-grid;
			grid-template-columns: 1fr auto 1fr;
			min-height: inherit;
			padding: 4px 8px;
			border-radius: 4px;
			color: var(--control-text-color);
			background-color: var(--control-background-color, #fff);
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}
		:host(.icon) {
			padding: 4px;
		}
		:host(:not([disabled]):hover) {
			color: var(--control-hovered-text-color); 
			background-color: var(--control-hover-background-color);
		}
		:host(:not([disabled]):active) {
			color: var(--control-activated-text-color);
			background-color: var(--control-activated-background-color);
		}
		:host([disabled]) {
			color: #aaa;
			pointer-events: none;
			cursor: auto;
		}
		#prefix,
		#label,
		#suffix {
			display: inline;
			align-self: baseline;
			white-space: nowrap;
			overflow: hidden;
		}
		:host(:not(.icon)) #prefix {
			margin-right: .4em;
			text-align: right;
		}
		#label {
			text-overflow: ellipsis;
		}
		:host(:not(.icon)) #suffix {
			margin-left: .4em;
			text-align: left;
		}
		/* Do not allow children to be clickable or selectable */
		*,
		::slotted(*) {
			pointer-events: none;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}'
]

{ #category : #'web resources' }
CpButton class >> template [

	<webResource: #html>

	^ '<div id="prefix">
		<slot name="prefix"></slot>
	</div>
	<div id="label">
		<slot name="label"></slot>
	</div>
	<div id="suffix">
		<slot name="suffix"></slot>
	</div>'
]

{ #category : #accessing }
CpButton >> label [

	"Answer label of receiver"

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
CpButton >> label: anElement [

	"Set the specified element as the label of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #label
]

{ #category : #accessing }
CpButton >> prefix [

	"Answer prefix of receiver"

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
CpButton >> prefix: anElement [

	"Set the specified element as the prefix of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #prefix
]

{ #category : #accessing }
CpButton >> suffix [

	"Answer suffix of receiver"

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
CpButton >> suffix: anElement [

	"Set the specified element as the suffix of the receiver"

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: #suffix
]
