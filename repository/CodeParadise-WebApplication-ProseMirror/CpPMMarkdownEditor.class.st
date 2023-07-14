Class {
	#name : #CpPMMarkdownEditor,
	#superclass : #CpDocumentEditor,
	#category : #'CodeParadise-WebApplication-ProseMirror-View'
}

{ #category : #primitives }
CpPMMarkdownEditor class >> addMarkdownEditorTo: anElement [

	"Add a ProseMirror Markdown editor to the specified element with the (optional) specified content and (collaborative) version.
	aString contains the Markdown description or is nil to indicate a new empty editor should be created."

	^ CpHtmlElement globalApply: #addMarkdownEditorTo: withArguments: { anElement }
]

{ #category : #primitives }
CpPMMarkdownEditor class >> getMarkdownEditorContentFrom: anElement [

	"Answer the Markdown content of the editor in the specified element
	(result is a String containing a Markdown description)"

	^ CpHtmlElement globalApply: #getMarkdownEditorContentFrom: withArguments: { anElement }
]

{ #category : #primitives }
CpPMMarkdownEditor class >> getMarkdownEditorSelectionFrom: anElement [

	"Answer the selection in the editor in the specified element
	(result is a Dictionary containing a from and to value)"

	^ CpHtmlElement globalApply: #getMarkdownEditorSelectionFrom: withArguments: { anElement }
]

{ #category : #'web resources' }
CpPMMarkdownEditor class >> globalStyle [

	<webResource: #css>

	^ '.ProseMirror {
			position: relative;
			height: 100%;
			overflow-y: scroll;
			word-wrap: break-word;
			white-space: pre-wrap;
			white-space: break-spaces;
			-webkit-font-variant-ligatures: none;
			font-variant-ligatures: none;
			font-feature-settings: "liga" 0; /* the above doesn''''''''t seem to work in Edge */
		}

		.ProseMirror p,
		.ProseMirror ul,
		.ProseMirror ol,
		.ProseMirror li,
		.ProseMirror pre {
			outline: none;
		}
		
		.ProseMirror pre {
			white-space: pre-wrap;
		}

		.ProseMirror li {
			position: relative;
		}

		.ProseMirror-widget.cursor::after {
			content: "";
			position: absolute;
			display: inline-block;
			width: 1px;
			height: 1.2em;
			background-color: rgba(255, 0, 0, .7);
			z-index: 1;
		}

		.ProseMirror .shared-selection {
			background-color: rgba(255, 255, 0, .4);
		}
		
		.ProseMirror-hideselection *::selection {
			background: transparent;
		}
		.ProseMirror-hideselection *::-moz-selection {
			background: transparent;
		}
		.ProseMirror-hideselection {
			caret-color: transparent;
		}

		.ProseMirror-selectednode {
			outline: 2px solid #8cf;
		}

		/* Make sure li selections wrap around markers */
		li.ProseMirror-selectednode {
			outline: none;
		}

		li.ProseMirror-selectednode:after {
			content: "";
			position: absolute;
			left: -32px;
			right: -2px; top: -2px; bottom: -2px;
			border: 2px solid #8cf;
			pointer-events: none;
		}

		/* Protect against generic img rules */
		img.ProseMirror-separator {
			display: inline !important;
			border: none !important;
			margin: 0 !important;
		}

		/* Shoelace styling */
		.ProseMirror {
			border: solid var(--sl-input-border-width) var(--sl-input-border-color);
			background-color: var(--sl-input-background-color);
		}
		.ProseMirror.medium {
			font-size: var(--sl-input-font-size-medium);
			border-radius: var(--sl-input-border-radius-medium);
			padding: 0 var(--sl-input-spacing-medium);
		}
		.ProseMirror.ProseMirror-focused {
			border-color: var(--sl-input-border-color-focus);
			background-color: var(--sl-input-background-color-focus);
		}

		.ProseMirror.medium > p:first-child {
			margin-top: 10px;
		}
		.ProseMirror.medium li > p {
			margin-top: 10px;
			margin-bottom: 10px;
		}'
]

{ #category : #'class initialization' }
CpPMMarkdownEditor class >> loadLibrary [

	"Load library"

	CpHtmlElement documentAddExternalScript: '/static/cp-prosemirror-markdown.js'
]

{ #category : #'class initialization' }
CpPMMarkdownEditor class >> postInstallOnce [

	self loadLibrary
]

{ #category : #primitives }
CpPMMarkdownEditor class >> removeMarkdownEditorFrom: anElement [

	"Remove a ProseMirror Markdown editor from the specified element"

	CpHtmlElement globalApply: #removeMarkdownEditorFrom: withArguments: { anElement }
]

{ #category : #'web resources' }
CpPMMarkdownEditor class >> style [

	<webResource: #css>

	^'* {
		box-sizing: border-box;
	}
	:host {
		display: block;
		height: 100%;
	}
	#container {
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		height: 100%;
		overflow-y: hidden;
	}'
]

{ #category : #'web resources' }
CpPMMarkdownEditor class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot name="header"></slot>
			<slot></slot>
			<slot name="footer"></slot>
		</div>'
]

{ #category : #primitives }
CpPMMarkdownEditor class >> updateMarkdownEditorIn: anElement removeSelectionClientID: idString [

	"Remove the selection for the specified client from the editor in the specified element"

	CpHtmlElement globalApply: #updateMarkdownEditorIn:removeSelectionClientID: withArguments: { anElement . idString }
]

{ #category : #primitives }
CpPMMarkdownEditor class >> updateMarkdownEditorIn: anElement setSelection: aDictionary clientID: idString [

	"Update the selection for the specified client of the editor in the specified element"

	CpHtmlElement globalApply: #updateMarkdownEditorIn:setSelection:clientID: withArguments: { anElement . aDictionary . idString }
]

{ #category : #primitives }
CpPMMarkdownEditor class >> updateMarkdownEditorIn: anElement withContent: aString version: anInteger clientID: idString [

	"Update the Markdown content of the editor in the specified element
	with the specified content and version. aString should contain a Markdown
	description and version is an integer for keeping collaboration versions
	in sync."

	CpHtmlElement globalApply: #updateMarkdownEditorIn:withContent:version:clientID: withArguments: { anElement . aString . anInteger . idString }
]

{ #category : #primitives }
CpPMMarkdownEditor class >> updateMarkdownEditorIn: anElement withSteps: aCollection version: anInteger selection: aDictionary clientID: aString [

	"Update the Markdown editor by providing a new set of (change) steps to be applied"

	CpHtmlElement globalApply: #updateMarkdownEditorIn:withSteps:version:selection:clientID: withArguments: { anElement . aCollection . anInteger . aDictionary . aString }
]

{ #category : #accessing }
CpPMMarkdownEditor >> content [

	^ self class getMarkdownEditorContentFrom: self
]

{ #category : #accessing }
CpPMMarkdownEditor >> cursorClientID: aString [

	"Answer the cursor for the specified client ID"

	| cssSelector |

	cssSelector := String streamContents: [ :stream |
		stream
			nextPutAll: CpPMCursor asCssSelector ;
			nextPutAll: '[data-clientid="' ;
			nextPutAll: aString ;
			nextPutAll: '"]' ].

	^ self firstDescendantMatching: cssSelector
]

{ #category : #'event handling' }
CpPMMarkdownEditor >> handleDocumentChange: aDocumentChange [

	"Create an announcement based on the document change event and announce it"

	self serverAnnounce: aDocumentChange asCollaborativeChangeAnnouncement
]

{ #category : #'event handling' }
CpPMMarkdownEditor >> handleFocusIn [

	self serverAnnounce: (CpPMCollaborativeDocumentFocusIn selection: self selection)
]

{ #category : #'event handling' }
CpPMMarkdownEditor >> handleFocusOut [

	self serverAnnounce: CpPMCollaborativeDocumentFocusOut
]

{ #category : #initialization }
CpPMMarkdownEditor >> initialize [

	super initialize.

	"Add the visual ProseMirror Markdown editor"
	(self class addMarkdownEditorTo: self)
		addClasses: #(#editor . #medium).

	"Add event listeners to receive changes"
	self
		when: CpPMDocumentChange send: #handleDocumentChange: to: self ;
		when: CpFocusInEvent send: #handleFocusIn to: self ;
		when: CpFocusOutEvent send: #handleFocusOut to: self
]

{ #category : #testing }
CpPMMarkdownEditor >> isInputComponent [

	^ true
]

{ #category : #rendering }
CpPMMarkdownEditor >> removeSelectionClientID: idString [

	self class
		updateMarkdownEditorIn: self
		removeSelectionClientID: idString
]

{ #category : #rendering }
CpPMMarkdownEditor >> renderCursorClientID: aString [

	"Update the cursor for the specified client ID"

	(self cursorClientID: aString)
		ifNotNil: [ :cursor | cursor update ]
]

{ #category : #rendering }
CpPMMarkdownEditor >> renderSteps: aCollection version: anInteger selection: aDictionary clientID: aString [

	"Render the specified steps/version/clientID"

	self class
		updateMarkdownEditorIn: self
		withSteps: aCollection
		version: anInteger
		selection: aDictionary
		clientID: aString.

	self renderCursorClientID: aString
]

{ #category : #accessing }
CpPMMarkdownEditor >> selection [

	^ self class getMarkdownEditorSelectionFrom: self
]

{ #category : #rendering }
CpPMMarkdownEditor >> setSelection: aDictionary clientID: aString [

	self class
		updateMarkdownEditorIn: self
		setSelection: aDictionary
		clientID: aString.

	self renderCursorClientID: aString
]

{ #category : #rendering }
CpPMMarkdownEditor >> updateContent: aString version: anInteger clientID: idString [

	self class
		updateMarkdownEditorIn: self
		withContent: aString
		version: anInteger
		clientID: idString
]
