Class {
	#name : #CpCursor,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpCursor class >> style [

	<webResource: #css>

	^ ':host {
			display: inline-flex;
			position: relative;
			white-space: nowrap;
			font-size: .8rem;
		}

		#container {
			display: inline-block;
			position: relative;
			width: 0px;
			height: 100%;
			min-height: inherit;
		}

		#cursor {
			display: inline-block;
			position: absolute;
			top: -.8rem;
			left: 0;
			width: 1px;
			height: 1rem;
			background-color: #333;
			-webkit-animation: 1s blink step-end infinite;
			-moz-animation: 1s blink step-end infinite;
			animation: 1s blink step-end infinite;
		}
		
		input,
		input:focus {
			position: fixed;
			display: inline-block;
			left: 0;
			top: 0;
			width: 0;
			height: 0;
			margin: 0;
			padding: 0;
			font-family: inherit;
			font-size: 100%;
			border: none;
			outline: none;
			-webkit-box-shadow: none;
			-moz-box-shadow: none;
			box-shadow: none;
			background: none;
		}

		@keyframes "blink" {
			from, to {
				background-color: transparent;
			}
			50% {
				background-color: #333;
			}
		}

		@-moz-keyframes blink {
			from, to {
				background-color: transparent;
			}
			50% {
				background-color: #333;
			}
		}

		@-webkit-keyframes "blink" {
			from, to {
				background-color: transparent;
			}
			50% {
				background-color: #333;
			}
		}'
]

{ #category : #'web resources' }
CpCursor class >> template [

	<webResource: #html>

	^ '<div id="container"><div id="cursor"></div></div><input type="text">'
]

{ #category : #'event handling' }
CpCursor >> handleBeforeInputEvent: aBeforeInputEvent [

	self flag: #todo.	"For now let the parent handle it, might need to change"

	self parent handleBeforeInputEvent: aBeforeInputEvent
]

{ #category : #events }
CpCursor >> handleFocusEvent: aFocusEvent [

	self crTrace: aFocusEvent printString
]

{ #category : #'event handling' }
CpCursor >> handleKeyPressEvent: aKeyPressEvent [

	self flag: #todo.	"For now let the parent handle it, might need to change"

	self parent handleKeyPressEvent: aKeyPressEvent
]
