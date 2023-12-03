Class {
	#name : #CpDemoApplicationCodeContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoApplicationCodeContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: inline-block;
			vertical-align: top;
		}
		#container {
			padding-top: 8px;
			padding-bottom: 8px;
		}
		code {
			display: inline-block;
			font-family: monospace, monospace;
			font-size: 1em;
			white-space: pre;
			background-color: rgba(255, 255, 255, .1);
		}
		#actions {
			display: none;
		}
		code:hover ~ #actions,
		#actions:hover {
			position: absolute;
			display: block;
		}
		#clipboard, #inspector {
			padding: 4px 12px;
			border-radius: 8px;
			background-color: rgba(255, 240, 201, .7);
			color: rgba(0, 105, 148, 1);
			cursor: pointer;
		}
		#clipboard:hover, #inspector:hover {
			background-color: rgba(255, 240, 201, 1);
		}
		:host(.action-done) #actions {
			display: none;
		}'
]

{ #category : #'web resources' }
CpDemoApplicationCodeContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<code><slot></slot></code><div id="actions"><span id="clipboard">Copy to clipboard</span> <span id="inspector">(Re)open Inspector</span></div>
		</div>'
]

{ #category : #'event handling' }
CpDemoApplicationCodeContentView >> handleClickEvent: aClickEvent [

	aClickEvent target id = #clipboard
		ifTrue: [ ^ self serverAnnounce: CpDemoCodeCopyClipboard ].
	aClickEvent target id = #inspector
		ifTrue: [ ^ self serverAnnounce: CpDemoCodeOpenInspector ]
]

{ #category : #'event handling' }
CpDemoApplicationCodeContentView >> handlePointerMoveEvent: aPointerEvent [

	"Fix our little hack from #serverAnnounce:"

	self removeClass: #'action-done'
]

{ #category : #initialization }
CpDemoApplicationCodeContentView >> initializeShadowRoot [

	super initializeShadowRoot.

	self shadowRoot
		when: CpPrimaryClickEvent send: #handleClickEvent: to: self ;
		when: CpPointerMoveEvent send: #handlePointerMoveEvent: to: self
]

{ #category : #rendering }
CpDemoApplicationCodeContentView >> renderCode: aString [

	self textContent: (aString replaceAll: Character cr with: Character lf)
]

{ #category : #'event handling' }
CpDemoApplicationCodeContentView >> serverAnnounce: anAnnouncement [

	"Trick to remove the actions from the view.
	It is re-enabled in #handlePointerMoveEvent:"

	self addClass: #'action-done'.
	super serverAnnounce: anAnnouncement
]
