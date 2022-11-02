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
		code {
			font-family: monospace, monospace;
			font-size: 1em;
			white-space: pre;
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

	^ '<div class="container">
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
CpDemoApplicationCodeContentView >> initialize [

	super initialize.

	self
		when: CpPrimaryClickEvent send: #handleClickEvent: to: self ;
		when: CpPointerMoveEvent send: #handlePointerMoveEvent: to: self
]

{ #category : #'event handling' }
CpDemoApplicationCodeContentView >> serverAnnounce: anAnnouncement [

	"Trick to remove the actions from the view.
	It is re-enabled in #handlePointerMoveEvent:"

	self addClass: #'action-done'.
	super serverAnnounce: anAnnouncement
]
