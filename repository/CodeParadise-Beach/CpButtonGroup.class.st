Class {
	#name : #CpButtonGroup,
	#superclass : #CpControlGroup,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpButtonGroup class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		:host {
			display: inline-grid;
		}
		:host(:not([vertical])) {
			grid-template-columns: 1fr;
			grid-auto-flow: column;
			grid-auto-columns: 1fr;
		}
		:host([vertical]) {
			grid-template-rows: 1fr;
			grid-auto-flow: row;
			grid-auto-rows: 1fr;
		}
		:host(:not([vertical])) ::slotted(cp-button:first-of-type) {
			border-top-right-radius: 0;
			border-bottom-right-radius: 0;
		}
		:host(:not([vertical])) ::slotted(cp-button:not(:first-of-type):not(:last-of-type)) {
			border-radius: 0;
		}
		:host(:not([vertical])) ::slotted(cp-button:last-of-type) {
			border-top-left-radius: 0;
			border-bottom-left-radius: 0;
		}
		:host([vertical]) ::slotted(cp-button:first-of-type) {
			border-bottom-left-radius: 0;
			border-bottom-right-radius: 0;
		}
		:host([vertical]) ::slotted(cp-button:not(:first-of-type):not(:last-of-type)) {
			border-radius: 0;
		}
		:host([vertical]) ::slotted(cp-button:last-of-type) {
			border-top-left-radius: 0;
			border-top-right-radius: 0;
		}'
]

{ #category : #'web resources' }
CpButtonGroup class >> template [

	<webResource: #html>

	^ '<slot></slot>'
]
