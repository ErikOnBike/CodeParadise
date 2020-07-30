Class {
	#name : #CpButton,
	#superclass : #CpView,
	#instVars : [
		'prefix',
		'label',
		'suffix'
	],
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

{ #category : #'instance creation' }
CpButton class >> new [

	"Answer new instance of the receiver.
	Register interest in this instance for event handling."

	| instance |

	instance := super new.
	CpBrowserEventHandler current registerInterestIn: instance.
	^ instance
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

	^ ':host {
			display: inline-flex;
			position: relative;
			white-space: nowrap;
			font-size: .8rem;
		}

		#container {
			display: inline-flex;
			width: 100%;
			height: 100%;
			min-height: inherit;
			padding: .25rem;
			border-radius: .25rem;
			align-items: baseline;
			justify-content: center;
			color: var(--control-text-color);
			background-color: var(--control-background-color);
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

		#prefix,
		#suffix {
			display: inline-block;
		}

		#prefix ::slotted(*) {
			margin-right: .25rem;		
		}

		#suffix ::slotted(*) {
			margin-left: .25rem;
		}

		#label {
			display: inline-block;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}'
]

{ #category : #'web resources' }
CpButton class >> template [

	<webResource: #html>

	^ '<div id="container">
			<div id="prefix">
				<slot name="prefix"></slot>
			</div>
			<div id="label">
				<slot name="label"></slot>
			</div>
			<div id="suffix">
				<slot name="suffix"></slot>
			</div>
		</div>'
]

{ #category : #'event handling' }
CpButton >> handleClickEvent: aClickEvent [

	"Announce the fact that receiver has been clicked"

	self announce: aClickEvent asAnnouncement
]

{ #category : #accessing }
CpButton >> label [

	"Answer label of receiver. If no label is set yet, check if label was set from a HTML string."

	^ label ifNil: [ label := self childAtSlotNamed: #label ]
]

{ #category : #accessing }
CpButton >> label: anElement [

	"Set the specified element as the label of the receiver"

	label := self replaceChild: anElement asElement atSlotNamed: #label
]

{ #category : #accessing }
CpButton >> prefix [

	"Answer prefix of receiver. If no prefix is set yet, check if prefix was set from a HTML string."

	^ prefix ifNil: [ prefix := self childAtSlotNamed: #prefix ]
]

{ #category : #accessing }
CpButton >> prefix: anElement [

	"Set the specified element as the prefix of the receiver"

	prefix := self replaceChild: anElement asElement atSlotNamed: #prefix
]

{ #category : #accessing }
CpButton >> suffix [

	"Answer suffix of receiver. If no suffix is set yet, check if suffix was set from a HTML string."

	^ suffix ifNil: [ suffix := self childAtSlotNamed: #suffix ]
]

{ #category : #accessing }
CpButton >> suffix: anElement [

	"Set the specified element as the suffix of the receiver"

	suffix := self replaceChild: anElement asElement atSlotNamed: #suffix
]
