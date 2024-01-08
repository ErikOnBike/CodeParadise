Class {
	#name : #CpDemoCodeContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoCodeContentView class >> globalStyle [

	<webResource: #css>

	^ '#messages {
		position: absolute;
		top: 0;
		right: 0;
		width: 20em;
		height: 100%;
		overflow: hidden;
		font-size: 2em;
		pointer-events: none;
		z-index: 10;
	}'
]

{ #category : #'class initialization' }
CpDemoCodeContentView class >> postInstallOnce [

	CpHtmlElement documentBody appendChild: ((CpHtmlElement newWithTag: #div)
		id: #messages ;
		yourself)
]

{ #category : #'web resources' }
CpDemoCodeContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: inline-block;
			vertical-align: top;
			--code-zoom-factor: 0.7;
		}
		#container {
			position: relative;
			padding-top: 8px;
			padding-bottom: 8px;
			line-height: 1.2em;
		}
		code {
			display: inline-block;
			position: relative;
			min-width: 80%;
			font-family: monospace, monospace;
			font-size: 1em;
			white-space: pre;
			max-height: 19.5em;
			overflow-y: scroll;
			overflow-x: hidden;
			background-color: rgba(255, 255, 255, .1);
			transition: width .5s;
		}
		::slotted(:not([slot])) {
			display: block;
			width: 100%;
			overflow-x: scroll;
			transition: width .5s, font-size .5s;
		}
		::slotted([slot="other"]) {
			display: block;
			position: absolute;
			top: 0;
			left: 100%;
			width: 50%;
			height: 0;
			overflow-x: scroll;
			transition: left .5s, font-size .5s;
		}
		:host(.show-other) code {
			width: 100%;
		}
		:host(.show-other) ::slotted(:not([slot])) {
			width: 50%;
			font-size: calc(1em * var(--code-zoom-factor));
		}
		:host(.show-other) ::slotted([slot="other"]) {
			left: 50%;
			font-size: calc(1em * var(--code-zoom-factor));
			height: auto;
			border-left: 1px solid white;
		}
		::slotted([slot="banner"]) {
			display: block;
			position: absolute;
			top: 0;
			right: 0;
			width: 10em;
			text-align: center;
			font-family: "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;
			font-size: .6em;
			font-weight: bold;
			transform: translate(30%,60%)rotate(45deg);
			background-color: rgba(255, 0, 0, .1);
			color: white;
		}
		#actions {
			position: absolute;
			bottom: 0;
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
			<code><slot></slot><slot name="other"></slot><slot name="banner"></slot></code><div id="actions"><slot name="actions"></slot></div>
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

{ #category : #actions }
CpDemoCodeContentView >> hideOther [

	self removeClass: #'show-other'
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
CpDemoCodeContentView >> renderBanner: aString [

	aString
		ifNotNil: [ self replaceAllChildrenWith: aString asHtmlElement atSlotNamed: #banner ]
		ifNil: [ self removeChildrenAtSlotNamed: #banner ]
]

{ #category : #rendering }
CpDemoCodeContentView >> renderCode: aString [

	aString
		ifNotNil: [ self replaceAllChildrenWith: (aString replaceAll: Character cr with: Character lf) asHtmlElement atSlotNamed: nil ]
		ifNil: [ self removeChildrenAtSlotNamed: nil ]
]

{ #category : #rendering }
CpDemoCodeContentView >> renderMessage: aString [

	(CpHtmlElement elementWithId: #messages)
		ifNotNil: [ :messages |
			messages appendChild: (CpDemoMessageView new
				renderMessage: aString ;
				yourself) ]
]

{ #category : #rendering }
CpDemoCodeContentView >> renderOtherCode: aString [

	aString
		ifNotNil: [
			self
				replaceAllChildrenWith: (aString replaceAll: Character cr with: Character lf) asHtmlElement
				atSlotNamed: #other ]
		ifNil: [ self removeChildrenAtSlotNamed: #other ]
]

{ #category : #'event handling' }
CpDemoCodeContentView >> serverAnnounce: anAnnouncement [

	"Trick to remove the actions from the view.
	It is re-enabled in #handlePointerMoveEvent:"

	self addClass: #'action-done'.
	super serverAnnounce: anAnnouncement
]

{ #category : #actions }
CpDemoCodeContentView >> showOther [

	self addClass: #'show-other'
]

{ #category : #actions }
CpDemoCodeContentView >> toggleOther [

	self toggleClass: #'show-other'
]
