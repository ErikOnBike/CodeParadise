Class {
	#name : 'CpTextField',
	#superclass : 'CpInputControl',
	#category : 'CodeParadise-Beach-Components',
	#package : 'CodeParadise-Beach',
	#tag : 'Components'
}

{ #category : 'web resources' }
CpTextField class >> style [

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
			cursor: text;
		}
		::slotted(input) {
			margin: 0;
			border-radius: 4px;
			border: 1px solid #333;
			padding: 3px;
			font-size: 1em;
		}
		:host(:hover) ::slotted(input) {
			border-color: #666;
		}
		:host([disabled]) ::slotted(input) {
			pointer-events: none;
			-webkit-user-select: none;
			-moz-user-select: none;
			user-select: none;
		}
		:host([readonly]) ::slotted(input) {
			/* ? */
		}
		::slotted(input:focus) {
			outline: none;
		}'
]

{ #category : 'web resources' }
CpTextField class >> template [

	<webResource: #html>

	^ '<slot></slot>'
]

{ #category : 'initialization' }
CpTextField >> initialize [

	super initialize.

	self appendChild: ((CpHtmlElement newWithTag: #input)
		attributeAt: #type put: #text ;
		yourself)
]

{ #category : 'accessing' }
CpTextField >> text [

	^ self firstChild propertyAt: #value
]

{ #category : 'accessing' }
CpTextField >> text: aString [

	self firstChild propertyAt: #value put: aString
]
