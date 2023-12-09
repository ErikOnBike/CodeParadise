Class {
	#name : #CpDemoCodeContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoCodeContentView class >> style [

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
			position: absolute;
			display: none;
			-webkit-user-select: none;
			user-select: none;
		}
		code:hover ~ #actions,
		#actions:hover {
			display: block;
		}
		::slotted([slot="actions"]) {
			padding: 4px 12px;
			margin-right: 8px;
			border-radius: 8px;
			background-color: rgba(255, 240, 201, .7);
			color: rgba(0, 105, 148, 1);
			cursor: pointer;
		}
		::slotted([slot="actions"]:hover) {
			background-color: rgba(255, 240, 201, 1);
		}
		:host(.action-done) #actions {
			display: none;
		}'
]

{ #category : #'web resources' }
CpDemoCodeContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<code><slot></slot></code><div id="actions"><slot name="actions"></slot></div>
		</div>'
]

{ #category : #'event handling' }
CpDemoCodeContentView >> copyToClipboard [

	self serverAnnounce: CpDemoCodeCopyClipboard
]

{ #category : #'event handling' }
CpDemoCodeContentView >> handlePointerMoveEvent: aPointerEvent [

	"Fix our little hack from #serverAnnounce:"

	self removeClass: #'action-done'
]

{ #category : #initialization }
CpDemoCodeContentView >> initialize [

	super initialize.

	self
		appendChild: ('Copy to clipboard' asHtmlElement
			when: CpPrimaryClickEvent only send: #copyToClipboard to: self ;
			yourself)
		atSlotNamed: #actions
]

{ #category : #initialization }
CpDemoCodeContentView >> initializeShadowRoot [

	super initializeShadowRoot.

	self shadowRoot when: CpPointerMoveEvent send: #handlePointerMoveEvent: to: self
]

{ #category : #rendering }
CpDemoCodeContentView >> renderCode: aString [

	self textContent: (aString replaceAll: Character cr with: Character lf)
]

{ #category : #'event handling' }
CpDemoCodeContentView >> serverAnnounce: anAnnouncement [

	"Trick to remove the actions from the view.
	It is re-enabled in #handlePointerMoveEvent:"

	self addClass: #'action-done'.
	super serverAnnounce: anAnnouncement
]
