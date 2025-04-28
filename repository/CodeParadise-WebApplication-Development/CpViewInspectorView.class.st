Class {
	#name : #CpViewInspectorView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'completionIndex',
		'classNameCache'
	],
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #'class initialization' }
CpViewInspectorView class >> beLoaded [

	SlButton beLoaded.
	SlButtonGroup beLoaded.
	SlCard beLoaded.
	SlDivider beLoaded.
	SlInput beLoaded.
	SlPopup beLoaded.
	SlSplitPanel beLoaded
]

{ #category : #'instance creation' }
CpViewInspectorView class >> createInstance [

	self first ifNotNil: [ ^ self ].

	CpHtmlElement documentBody
		appendChild: super new
]

{ #category : #'web resources' }
CpViewInspectorView class >> globalStyle [

	<webResource: #css>

	^ 'cp-view-inspector .completion {
	display: inline-block;
	width: 100%;
	height: var(--sl-input-height-small);
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	padding: 3px 8px;
	font-family: var(--sl-input-font-family);
	font-size: var(--sl-input-font-size-small);
	font-weight: var(--sl-input-font-weight);
	letter-spacing: var(--sl-input-letter-spacing);
}
cp-view-inspector .completion:not(.selected):hover {
	background-color: var(--sl-color-primary-200);
	cursor: pointer;
}
cp-view-inspector .selected.completion {
	background-color: #99f;
	color: #fff;
}'
]

{ #category : #'instance creation' }
CpViewInspectorView class >> new [

	self errorNewReplacedBy: #createInstance
]

{ #category : #'class initialization' }
CpViewInspectorView class >> postInstallOnce [

	"Add a single instance of the receiver to the DOM"

	CpClientEnvironment current objectRegistry
		registerObject: self
		withId: self name.

	self
		whenDefinedAll: {
			CpViewCodeInspectorView.
			SlIcon.
			SlIconButton }
		do: [ self createInstance ]
]

{ #category : #rendering }
CpViewInspectorView class >> showAlert: aString [

	SlAlert new
		beClosable ;
		appendChild: ((SlIcon named: 'info-circle')
			slot: 'icon' ;
			yourself) ;
		textContent: aString ;
		duration: 2500 ;
		beCountdownRightToLeft ;
		toast
]

{ #category : #rendering }
CpViewInspectorView class >> showErrorAlert: aString [

	SlAlert new
		beWarning ;
		beClosable ;
		appendChild: ((SlIcon named: 'exclamation-triangle')
			slot: 'icon' ;
			yourself) ;
		textContent: aString ;
		duration: 5000 ;
		beCountdownRightToLeft ;
		toast
]

{ #category : #rendering }
CpViewInspectorView class >> showGlobalStyle: styleString [

	"Show the provided style in the code inspector"

	self first
		showGlobalStyle: styleString
]

{ #category : #rendering }
CpViewInspectorView class >> showSaveSuccess: aSymbol [

	self first
		showSaveSuccess: aSymbol.

	self showAlert: 'Source code saved successfully'
]

{ #category : #rendering }
CpViewInspectorView class >> showStyle: styleString [

	"Show the provided style in the code inspector"

	self first
		showStyle: styleString
]

{ #category : #rendering }
CpViewInspectorView class >> showTemplate: templateString [

	"Show the provided template in the code inspector"

	self first
		showTemplate: templateString
]

{ #category : #'web resources' }
CpViewInspectorView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
		pointer-events: none;
		z-index: 9999;
	}
	#container {
		width: 100%;
		height: 100%;
		overflow: hidden;
		font-family: "Monaco", "Lucida Grande", "Andela Mono", "Courier";
		font-size: 12px;
		pointer-events: none;
	}
	#input {
		position: absolute;
		top: 30%;
		left: 50%;
		width: 30em;
		transform: translate(-50%, -50%);
		font-family: var(--sl-input-font-family);
		font-size: var(--sl-input-font-size-small);
		font-weight: var(--sl-input-font-weight);
		letter-spacing: var(--sl-input-letter-spacing);
		z-index: 9999;
		pointer-events: auto;
	}
	:host(:not(.active-input)) #input {
		display: none;
	}
	#completion {
		width: 30em;
		max-height: 300px;
		padding: 8px;
		overflow-y: scroll;
		border-bottom-left-radius: 6px;
		border-bottom-right-radius: 6px;
		background-color: #fff;
	}
	#tool {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}
	#tool::part(divider) {
		pointer-events: auto;
	}
	:host(:not(.active-code)) #tool {
		display: none;
	}'
]

{ #category : #'web resources' }
CpViewInspectorView class >> template [

	<webResource: #html>

	^ '<div id="container">
		<sl-card id="input">
			<div slot="header">
				Which WebComponent would you like to edit?
			</div>
			<sl-popup id="name-complete" placement="bottom" distance="6">
				<sl-input id="name-input" size="small" placeholder="CpSomeComponent" slot="anchor"></sl-input>
				<div id="completion">
					<slot name="completion"></slot>
				</div>
			</sl-popup>
		</sl-card>
		<sl-split-panel id="tool" vertical position="75">
			<slot name="start" slot="start"><div></div></slot>
			<slot name="end" slot="end"><div></div></slot>
		</sl-split-panel>
	</div>'
]

{ #category : #rendering }
CpViewInspectorView class >> updateHtmlTags: aCollection [

	CpCodeEditor updateHtmlTags: aCollection
]

{ #category : #accessing }
CpViewInspectorView >> codeElement [

	^ self firstChild
]

{ #category : #accessing }
CpViewInspectorView >> ensureInstanceOf: aClass [

	"Answer an instanece of the specified class"
	aClass first ifNotNil: [ :instance | ^ instance ].

	"Do a full DOM tree search (includes shadow DOMS)"
	CpHtmlElement documentBody allElementsDo: [ :each |
		each class == aClass
			ifTrue: [ ^ each ] ].

	"Finally try to instantiate one (can fail)"
	^ self newInstanceFor: aClass
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowse: aKeyEvent [

	"Prevent the key from being processed further"
	aKeyEvent preventDefault.

	self showInput
]

{ #category : #'event handling' }
CpViewInspectorView >> handleEndInput [

	(self shadowedElementWithId: #'name-complete')
		beNotActive.

	classNameCache := nil
]

{ #category : #'event handling' }
CpViewInspectorView >> handleEscape: aKeyEvent [

	"Prevent the key from being processed further"
	aKeyEvent preventDefault.

	self hideInput
]

{ #category : #'event handling' }
CpViewInspectorView >> handleInput [

	| input selectedClassName |

	input := (self shadowedElementWithId: #'name-input') value.

	selectedClassName := (completionIndex > 0
		ifTrue: [ (self childrenAtSlotNamed: #completion) at: completionIndex ifAbsent: [ nil ] ])
			ifNotNil: [ :selection | selection textContent ].

	self removeChildrenAtSlotNamed: #completion.
	completionIndex := 0.

	(classNameCache select: [ :each | each asLowercase includesSubstring: input asLowercase ]) withIndexDo: [ :each :index |
		| selection |
		selection := (self appendChild: each asHtmlElement atSlotNamed: #completion)
			addClass: #completion ;
			"Can't use CpClickEvent because the receiver will have been removed because the input loses focus"
			when: CpPointerDownEvent do: [ self showCodeForClassNamed: each ] for: self ;
			yourself.
		each = selectedClassName
			ifTrue: [
				selection addClass: #selected.
				completionIndex := index ] ]
]

{ #category : #'event handling' }
CpViewInspectorView >> handleNextCompletion [

	| completions |

	completions := (self childrenAtSlotNamed: #completion).

	completionIndex := completionIndex + 1 min: completions size.
	completions withIndexDo: [ :each :index |
		each classed: #selected if: index = completionIndex ]
]

{ #category : #'event handling' }
CpViewInspectorView >> handlePreviousCompletion [

	| completions |

	completions := (self childrenAtSlotNamed: #completion).

	completionIndex := completionIndex - 1 max: (completions ifNotEmpty: [ 1 ] ifEmpty: [ 0 ]).
	completions withIndexDo: [ :each :index |
		each classed: #selected if: index = completionIndex ]
]

{ #category : #'event handling' }
CpViewInspectorView >> handleSelectCompletion [

	completionIndex = 0
		ifTrue: [ ^ self ].

	self showCodeForClassNamed: ((self childrenAtSlotNamed: #completion) at: completionIndex) textContent.

	"Clear input"
	(self shadowedElementWithId: #'name-input') value: ''
]

{ #category : #'event handling' }
CpViewInspectorView >> handleStartInput [

	(self shadowedElementWithId: #'name-complete')
		beActive.

	classNameCache := SortedCollection new.
	CpTemplateComponent allSubclassesDo: [ :each |
		each hasAbstractTag
			ifFalse: [ classNameCache add: each name ] ].

	completionIndex := 0. "none selected"

	self handleInput
]

{ #category : #'event handling' }
CpViewInspectorView >> handleToggle: aKeyEvent [

	"Prevent the key from being processed further"
	aKeyEvent preventDefault.

	self toggle
]

{ #category : #rendering }
CpViewInspectorView >> hideCode [

	self removeClass: #'active-code'.

	self codeElement hideCode
]

{ #category : #rendering }
CpViewInspectorView >> hideInput [

	self removeClass: #'active-input'
]

{ #category : #initialization }
CpViewInspectorView >> initialize [

	super initialize.

	completionIndex := 0.

	self appendChild: CpViewCodeInspectorView new atSlotNamed: #end.

	"Set the key handler on the Window"
	CpBrowserWindow current
		when: (CpKeyDownEvent key: 'i') & CpActionKeyDown send: #handleToggle: to: self ;
		when: (CpKeyDownEvent key: 'b') & CpActionKeyDown send: #handleBrowse: to: self ;
		when: CpKeyPressEvent escape send: #handleEscape: to: self.

	"Show this info delayed, so it will appear at the bottom of the console"
	CpGlobalThis setTimeout: 1000 thenDo: [
	self traceCr: ('
===================== Installed ViewInspector tool =====================
Press Cmd-i or Ctrl-i to open the Inspector view.
Press Cmd-b or Ctrl-b to browse for a specific view by name.

In the Inspector view you can select WebComponents. Once selected you can edit the
#template and #style methods in your browser and have it update (all instances) in
the browser. This allows you to better see the results of your changes, before saving
it in the WebComponent (i.e. saving it in the Smalltalk image).

Inside the two editors:
Press Cmd-s or Ctrl-s to update the template or style (in browser only).
Press Shift-Cmd-s or Shift-Ctrl-s to save the template or style (in Smalltalk image).' replaceAll: Character cr with: Character lf) ]
]

{ #category : #initialization }
CpViewInspectorView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #'name-input')
		when: SlFocusEvent send: #handleStartInput to: self ;
		when: SlInputEvent send: #handleInput to: self ;
		when: SlBlurEvent send: #handleEndInput to: self ;
		when: CpKeyDownEvent arrowUp send: #handlePreviousCompletion to: self ;
		when: CpKeyDownEvent arrowDown send: #handleNextCompletion to: self ;
		when: CpKeyDownEvent enter send: #handleSelectCompletion to: self
]

{ #category : #rendering }
CpViewInspectorView >> makeTopView [

	"Make receiver top View by making it the last child within its parent"

	self nextSibling ifNil: [ ^ self ].

	self parent appendChild: self remove
]

{ #category : #accessing }
CpViewInspectorView >> newInstanceFor: aClass [

	"Answer a new instance of the specified TemplateComponent class.

	Implementation:
	Not all classes allow instantation, check for this and report any errors."

	| instance |

	instance := [ aClass basicNew initialize ; yourself ] on: Error do: [ nil ].

	instance
		ifNotNil: [ self class showAlert: 'WebComponent ', aClass name, ' is not present in the current page/DOM, a new instance is created' ]
		ifNil: [ self class showErrorAlert: 'WebComponent ', aClass name, ' can''t be instantiated and no instance is present in the current page/DOM' ].

	^ instance
]

{ #category : #rendering }
CpViewInspectorView >> retrieveHtmlTags [

	"Retrieve a collection of HTML tags from the server (for HTML completion in editor)"

	self serverAnnounce: CpCodeEditorHtmlTagsRequest
]

{ #category : #private }
CpViewInspectorView >> serverAnnounce: anAnnouncement [

	CpClientEnvironment current
		serverAnnounce: anAnnouncement
]

{ #category : #rendering }
CpViewInspectorView >> showCode [

	"Show code using the existing (or default) element"

	self showCodeFor: nil
]

{ #category : #rendering }
CpViewInspectorView >> showCodeFor: anElement [

	self hideInput.

	self makeTopView.

	self retrieveHtmlTags.

	self codeElement showElement: anElement.

	self addClass: #'active-code'
]

{ #category : #'event handling' }
CpViewInspectorView >> showCodeForClassNamed: aString [

	aString ifEmpty: [
		self hideInput.
		^ self ].

	CpTemplateComponent allSubclassesDo: [ :each |
		each name = aString
			ifTrue: [
				self hideInput.
				self showCodeFor: (self ensureInstanceOf: each).
				^ self ] ].

	self class showErrorAlert: 'Class not found: ', aString printString
]

{ #category : #rendering }
CpViewInspectorView >> showGlobalStyle: aString [

	self codeElement
		showGlobalStyle: aString
]

{ #category : #rendering }
CpViewInspectorView >> showInput [

	self addClass: #'active-input'.

	(self shadowedElementWithId: #'name-input') focus
]

{ #category : #rendering }
CpViewInspectorView >> showSaveSuccess: aSymbol [

	self codeElement
		showSaveSuccess: aSymbol
]

{ #category : #rendering }
CpViewInspectorView >> showStyle: aString [

	self codeElement
		showStyle: aString
]

{ #category : #rendering }
CpViewInspectorView >> showTemplate: aString [

	self codeElement
		showTemplate: aString
]

{ #category : #rendering }
CpViewInspectorView >> toggle [

	(self isClassed: #'active-code')
		ifTrue: [ self hideCode ]
		ifFalse: [ self showCode ]
]
