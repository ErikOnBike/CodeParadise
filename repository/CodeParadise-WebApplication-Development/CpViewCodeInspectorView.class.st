Class {
	#name : #CpViewCodeInspectorView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'element',
		'selectedDomElement',
		'originalStyle',
		'styleType',
		'cssEditor',
		'htmlEditor'
	],
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #'class initialization' }
CpViewCodeInspectorView class >> beLoaded [

	SlIconButton beLoaded.
	SlInput beLoaded.
	SlIcon beLoaded.
	SlTooltip beLoaded.
	CpBrowserCSSStyleDeclaration beLoaded
]

{ #category : #'web resources' }
CpViewCodeInspectorView class >> globalStyle [

	<webResource: #css>

	^ 'cp-view-code-inspector sl-tree-item::part(expand-button) {
	padding: 0;
}
cp-view-code-inspector sl-tree-item {
	--sl-font-sans: "Monaco", "Lucida Grande", "Andela Mono", "Courier";
	--sl-font-size-medium: 12px;
}
cp-view-code-inspector sl-tree-item span {
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
cp-view-code-inspector sl-tree-item::part(label) {
	overflow: hidden;
}
cp-view-code-inspector sl-icon-button {
	position: absolute;
	left: 2px;
	font-size: 1.2em;
	color: #00f;
}
cp-view-code-inspector sl-icon-button::part(base) {
	padding: 0;
}'
]

{ #category : #'web resources' }
CpViewCodeInspectorView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}
:host {
	height: 100%;
	overflow: hidden;
	--sl-input-height-small: 17px;
}
#container {
	position: relative;
	height: 100%;
	overflow: hidden;
	background-color: #fff;
	pointer-events: auto;
}
#controls {
	position: absolute;
	top: 0;
	right: 0;
	font-size: 1.5em;
	border-bottom-left-radius: 8px;
	background-color: #ccc;
	z-index: 10;
}
#panes {
	height: 100%;
	overflow: hidden;
}
#dom,
#template,
#style {
	position: relative;
	width: 100%;
	height: 100%;
	overflow-x: hidden;
	overflow-y: scroll;
}
#code {
	width: 100%;
	height: 100%;
	overflow: hidden;
}
.controls {
	display: inline-flex;
	flex-direction: row;
	justify-content: end;
	align-items: center;
	position: absolute;
	top: 0;
	right: 0;
	font-size: 1.5em;
	z-index: 20;
}
.controls sl-icon-button::part(base) {
	padding: 4px;
}
[slot="end"] > .controls {
	right: 4.6em;
}
header {
	display: block;
	border-bottom: 1px solid #666;
	padding: 3px 4px;
	margin-bottom: 2px;
	line-height: 1.5em;
}
slot,
::slotted(*) {
	height: 100%;
	overflow-x: hidden;
	overflow-y: scroll;
}'
]

{ #category : #'web resources' }
CpViewCodeInspectorView class >> template [

	<webResource: #html>

	^ '<div id="container">
	<div id="controls">
		<sl-icon-button id="swap" name="arrow-down-up"></sl-icon-button>
		<sl-icon-button id="close" name="x-circle"></sl-icon-button>
	</div>
	<sl-split-panel id="panes" position="33" slot="end">
		<div id="dom" slot="start">
			<div class="controls">
				<sl-tooltip content="Refresh DOM"><sl-icon-button id="refresh-dom" name="arrow-counterclockwise"></sl-icon-button></sl-tooltip>
				<sl-tooltip content="Start at root DOM"><sl-icon-button id="root-dom" name="house"></sl-icon-button></sl-tooltip>
			</div>
			<slot name="dom"></slot>
		</div>
		<sl-split-panel id="code" slot="end">
			<div id="template" slot="start">
				<div class="controls">
					<sl-tooltip content="Refresh template"><sl-icon-button id="refresh-template" name="arrow-counterclockwise"></sl-icon-button></sl-tooltip>
					<sl-tooltip content="Apply template"><sl-icon-button id="save-template" name="save"></sl-icon-button></sl-tooltip>
					<sl-tooltip content="Save template"><sl-icon-button id="sync-template" name="send-check"></sl-icon-button></sl-tooltip>
				</div>
				<header>Template</header>
				<slot name="template"></slot>
			</div>
			<div id="style" slot="end">
				<div class="controls">
					<sl-tooltip content="Refresh style"><sl-icon-button id="refresh-style" name="arrow-counterclockwise"></sl-icon-button></sl-tooltip>
					<sl-tooltip content="Apply style"><sl-icon-button id="save-style" name="save"></sl-icon-button></sl-tooltip>
					<sl-tooltip content="Save style"><sl-icon-button id="sync-style" name="send-check"></sl-icon-button></sl-tooltip>
				</div>
				<header><span>Style </span><sl-button-group><sl-button id="local-style-button" size="small" pill>local</sl-button><sl-button id="global-style-button" size="small" pill>global</sl-button></sl-button-group></header>
				<slot name="style"></slot>
			</div>
		</sl-split-panel>
	</sl-split-panel>
</div>'
]

{ #category : #rendering }
CpViewCodeInspectorView >> applyStyle [

	self elementIsTemplateComponent
		ifFalse: [ ^ self ].

	styleType = #style
		ifTrue: [
			element class
				installStyle: self styleContent ;
				updateAllInstances ]
		ifFalse: [
			element class
				updateGlobalStyleUsing: self styleContent ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> applyTemplate [

	self elementIsTemplateComponent
		ifFalse: [ ^ self ].

	element class
		installTemplate: self templateContent ;
		updateAllInstances
]

{ #category : #rendering }
CpViewCodeInspectorView >> confirm: aString options: aCollection [

	| dialog |

	dialog := SlDialog new
		labelText: 'Please confirm' ;
		appendChild: aString asHtmlElement ;
		yourself.

	aCollection do: [ :each |
		dialog appendChild: ((SlButton label: each key)
			slot: #footer ;
			bePrimary ;
			when: CpClickEvent do: [ dialog close. each value value ] for: self ;
			yourself) ].

	(dialog firstDescendantMatching: SlButton asCssSelector)
		attributeAt: #autofocus put: ''.

	(CpHtmlElement documentBody
		appendChild: dialog) show
]

{ #category : #rendering }
CpViewCodeInspectorView >> controlsDisable: aCollection [

	aCollection do: [ :each | each beDisabled ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> controlsEnable: aCollection [

	aCollection do: [ :each | each beEnabled ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> domSelectionKeep [

	"Keep original styling of DOM selection"
	originalStyle := {
		#'background-color' -> (selectedDomElement styleAt: #'background-color').
		#'border-color' -> (selectedDomElement styleAt: #'border-color')
	} asDictionary.

	selectedDomElement
		styleAt: #'background-color' put: 'rgba(0, 0, 255, .5)' ;
		styleAt: #'border-color' put: '#00f'
]

{ #category : #rendering }
CpViewCodeInspectorView >> domSelectionRemove [

	selectedDomElement ifNil: [ ^ self ].

	selectedDomElement
		styleAt: #'background-color' put: (originalStyle at: #'background-color') ;
		styleAt: #'border-color' put: (originalStyle at: #'border-color').

	selectedDomElement := nil.
	originalStyle := nil
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTree [

	"Answer a DOM tree"

	^ SlTree new
		appendChild: (self domTreeFor: element) ;
		yourself
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTreeExpand: aTreeItem recurse: aBoolean [

	| domElement shadowTree |

	aTreeItem isLazy
		ifFalse: [ ^ self ].

	domElement := aTreeItem propertyAt: #element.
	shadowTree := nil.

	domElement isWebComponent
		ifTrue: [
			domElement shadowRoot ifNotNil: [ :shadowRoot |
				shadowRoot children ifNotEmpty: [ :children |
					"Add the Shadow DOM (fully expanded, because we need to search in it)"
					shadowTree := aTreeItem appendChild: (SlTreeItem new
						appendChild: '-- shadow DOM --' asHtmlElement ;
						yourself).
					children do: [ :each |
						| shadowDom |
						shadowDom := self domTreeFor: each.
						self domTreeExpand: shadowDom recurse: true.
						shadowTree appendChild: shadowDom ] ] ] ].

	domElement children ifNotEmpty: [ :children |
		children do: [ :each |
			| attachPoint |

			"Select which slot to add the child to (if any)"	
			attachPoint:= shadowTree ifNotNil: [
				self domTreeSelectSlotFor: each in: shadowTree ].

			"Append child to found attachment point or tree item itself"
			(attachPoint ifNil: [ aTreeItem ])
				beNotLazy ;
				appendChild: (self domTreeFor: each) ] ].

	aTreeItem beNotLazy
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTreeFor: anElement [

	"Answer a DOM tree for the specified Element"

	| treeItem isWebComponent |

	treeItem := SlTreeItem new
		appendChild: (self domTreeItemContentFor: anElement) ;
		propertyAt: #element put: anElement ;
		when: CpClickEvent send: #handleDomElementSelected: to: self ;
		yourself.

	isWebComponent := anElement isKindOf: CpTemplateComponent.

	(isWebComponent or: [ anElement children isNotEmpty ])
		ifTrue: [
			treeItem
				beLazy ;
				when: SlLazyLoadEvent send: #handleLazyLoadElement: to: self ].

	"Add a 'select' button for template based WebComponents (not being the selected element)"
	(isWebComponent and: [ anElement ~= element ])
		ifTrue: [
			treeItem appendChild: ((SlIconButton named: 'box-arrow-in-right')
				when: CpClickEvent do: [ self showElement: anElement ] for: self ;
				yourself) ].

	^ treeItem
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTreeItemContentFor: anElement [

	"Answer a new DOM element for the sl-tree-item of the specified element"

	^ (String streamContents: [ :stream |
		| value width height|
		stream
			nextPut: $< ;
			nextPutAll: anElement tagName.

		"Add id attribute"
		(value := anElement id) isEmptyOrNil ifFalse: [
			stream
				nextPutAll: ' id="' ;
				nextPutAll: value ;
				nextPut: $" ].

		"Add name attribute"
		(value := anElement attributeAt: #name) isEmptyOrNil ifFalse: [
			stream
				nextPutAll: ' name="' ;
				nextPutAll: value ;
				nextPut: $" ].

		"Add class attribute"
		(value := anElement attributeAt: #class) isEmptyOrNil ifFalse: [
			stream
				nextPutAll: ' class="' ;
				nextPutAll: value ;
				nextPut: $" ].

		stream	
			nextPut: $>.

		"Add size"
		width := anElement propertyAt: #clientWidth.
		height := anElement propertyAt: #clientHeight.
		(width > 0 and: [ height > 0 ])
			ifTrue: [
				stream
					nextPutAll: ' (' ;
					nextPutAll: width printString ;
					nextPut: $, ;
					nextPutAll: height printString ;
					nextPut: $) ].

		anElement localTextContent trim
			ifNotEmpty: [ :content |
				stream
					nextPutAll: ' - [' ;
					nextPutAll: content ; nextPutAll: ']' ] ]) asHtmlElement
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTreeSelectSlotFor: anElement in: shadowTree [

	"Select the slot element in the Tree (SlTreeItems in in the tool) for the specified Element"

	shadowTree allNonShadowedElementsDo: [ :each |
		| childElement |
		childElement := each propertyAt: #element.
		(childElement isNotNil and: [ childElement tagName = #slot and: [ (anElement isSlotted and: [ (childElement attributeAt: #name) = anElement slot ]) or: [ anElement isSlotted not and: [ (childElement attributeAt: #name) isEmptyOrNil ] ] ] ])
			ifTrue: [ ^ each ] ].

	^ nil
]

{ #category : #accessing }
CpViewCodeInspectorView >> elementIsTemplateComponent [

	"Answer whether the element is a WebComponent with a template"

	^ element isNotNil and: [ element isWebComponent and: [ element hasTemplate ] ]
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleApplyStyle: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	"Update deferred, because of possible awaits being used in #initializeShadowRoot"
	self defer: [ self applyStyle ]
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleApplyTemplate: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	"Update deferred, because of possible awaits being used in #initializeShadowRoot"
	self defer: [ self applyTemplate ]
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleClose: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self parent hideCode
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleDomElementSelected: aClickEvent [

	"Do not prevent the click event, since it might overlap with the collapse button"

	self domSelectionRemove.

	selectedDomElement := aClickEvent target propertyAt: #element.
	selectedDomElement
		ifNil: [
			| parent |
			parent := aClickEvent target parent.
			[ parent isNotNil and: [ selectedDomElement isNil ] ] whileTrue: [
				selectedDomElement := parent propertyAt: #element.
				parent := parent parent ].
			selectedDomElement
				ifNil: [ ^ self ] ].

	self domSelectionKeep
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleLazyLoadElement: aLazyLoadEvent [

	aLazyLoadEvent stopImmediatePropagation.

	self domTreeExpand: aLazyLoadEvent target recurse: false
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRefreshDom: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self showDom
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRefreshStyle: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self refreshStyle
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRefreshTemplate: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self refreshTemplate
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRequestGlobalStyle: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self requestGlobalStyle
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRequestLocalStyle: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self requestLocalStyle
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleRootDom: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self showElement: CpHtmlElement documentBody
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSaveStyle: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self saveStyle
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSaveTemplate: anEvent [

	anEvent
		stopPropagation ;
		preventDefault.

	self saveTemplate
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSwap: anEvent [

	| position |

	anEvent
		stopPropagation ;
		preventDefault.

	position := self attributeAt: #slot.
	self attributeAt: #slot put: (
		position = #start
			ifTrue: [ #end ]
			ifFalse: [ #start ])
]

{ #category : #rendering }
CpViewCodeInspectorView >> hideCode [

	self domSelectionRemove
]

{ #category : #initialization }
CpViewCodeInspectorView >> initialize [

	super initialize.

	styleType := #style.

	CpBrowserWindow current
		when: (CpKeyDownEvent fromString: 'X-s') send: #preventDefault: to: self ;
		when: (CpKeyDownEvent fromString: 'X-S-s') send: #preventDefault: to: self.

	self
		removeTemplate ;
		removeStyle
]

{ #category : #initialization }
CpViewCodeInspectorView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #swap)
		when: CpClickEvent send: #handleSwap: to: self.
	(self shadowedElementWithId: #close)
		when: CpClickEvent send: #handleClose: to: self.
	(self shadowedElementWithId: #'refresh-dom')
		when: CpClickEvent send: #handleRefreshDom: to: self.
	(self shadowedElementWithId: #'root-dom')
		when: CpClickEvent send: #handleRootDom: to: self.
	(self shadowedElementWithId: #'refresh-template')
		when: CpClickEvent send: #handleRefreshTemplate: to: self.
	(self shadowedElementWithId: #'refresh-style')
		when: CpClickEvent send: #handleRefreshStyle: to: self.
	((self shadowedElementWithId: #'save-template')
		when: CpClickEvent send: #handleApplyTemplate: to: self ;
		parent) attributeAt: 'content' put: 'Apply template - ', (CpActionKeyDown visualStringForKey: 's').
	((self shadowedElementWithId: #'save-style')
		when: CpClickEvent send: #handleApplyStyle: to: self ;
		parent) attributeAt: 'content' put: 'Apply style - ', (CpActionKeyDown visualStringForKey: 's').
	((self shadowedElementWithId: #'sync-template')
		when: CpClickEvent send: #handleSaveTemplate: to: self ;
		parent) attributeAt: 'content' put: 'Save template - ', (CpShiftKeyDown visualStringForKey: (CpActionKeyDown visualStringForKey: 's')).
	((self shadowedElementWithId: #'sync-style')
		when: CpClickEvent send: #handleSaveStyle: to: self ;
		parent) attributeAt: 'content' put: 'Save style - ', (CpShiftKeyDown visualStringForKey: (CpActionKeyDown visualStringForKey: 's')).
	(self shadowedElementWithId: #'local-style-button')
		when: CpClickEvent send: #handleRequestLocalStyle: to: self.
	(self shadowedElementWithId: #'global-style-button')
		when: CpClickEvent send: #handleRequestGlobalStyle: to: self.
]

{ #category : #rendering }
CpViewCodeInspectorView >> refreshStyle [

	self elementIsTemplateComponent
		ifFalse: [ ^ self ].

	(cssEditor isNotNil and: [ cssEditor isDirty ])
		ifTrue: [
			self
				confirm: 'The source code for the style is changed. What do you want to do with the code?'
				options: {
					'Keep' -> [ "Nothing to do" ] .
					'Discard' -> [ self revertStyle ; refreshStyle ] } ]
		ifFalse: [ self requestStyle ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> refreshTemplate [

	self elementIsTemplateComponent
		ifFalse: [ ^ self ].

	htmlEditor isDirty
		ifTrue: [
			self
				confirm: 'The source code for the template is changed. What do you want to do with the code?'
				options: {
					'Keep' -> [ "Nothing to do" ] .
					'Discard' -> [ self revertTemplate ; refreshTemplate ] } ]
		ifFalse: [ self requestTemplate ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> removeStyle [
	
	self replaceAllChildrenWith: '<no style>' asHtmlElement atSlotNamed: #style.
	self controlsDisable: ((self shadowedElementWithId: #style) allDescendantsMatching: '.controls sl-icon-button').
	self elementIsTemplateComponent
		ifTrue: [
			(self shadowedElementWithId: #'local-style-button') beEnabled.
			(self shadowedElementWithId: #'global-style-button') beEnabled ]
		ifFalse: [
			(self shadowedElementWithId: #'local-style-button') beDisabled.
			(self shadowedElementWithId: #'global-style-button') beDisabled ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> removeTemplate [
	
	self replaceAllChildrenWith: '<no template>' asHtmlElement atSlotNamed: #template.
	self controlsDisable: ((self shadowedElementWithId: #template) allDescendantsMatching: '.controls sl-icon-button')
]

{ #category : #private }
CpViewCodeInspectorView >> requestGlobalStyle [

	"Request global style"

	styleType = #globalStyle
		ifTrue: [ ^ self ].

	(cssEditor isNotNil and: [ cssEditor isDirty ])
		ifTrue: [
			self
				confirm: 'The source code for the style is changed. What do you want to do with the code?'
				options: {
					'Keep' -> [ "Nothing to do" ] .
					'Discard' -> [ self revertStyle ; requestGlobalStyle ] } ]
		ifFalse: [
			styleType := #globalStyle.
			self requestStyle ]
]

{ #category : #private }
CpViewCodeInspectorView >> requestLocalStyle [

	"Request local style"

	styleType = #style
		ifTrue: [ ^ self ].

	(cssEditor isNotNil and: [ cssEditor isDirty ])
		ifTrue: [
			self
				confirm: 'The source code for the style is changed. What do you want to do with the code?'
				options: {
					'Keep' -> [ "Nothing to do" ] .
					'Discard' -> [ self revertStyle ; requestLocalStyle ] } ]
		ifFalse: [
			styleType := #style.
			self requestStyle ]
]

{ #category : #private }
CpViewCodeInspectorView >> requestStyle [

	"Request local or global style"

	self removeStyle.

	self serverAnnounce: ((styleType = #style
		ifTrue: [ CpViewInspectorStyleRequest ]
		ifFalse: [ CpViewInspectorGlobalStyleRequest ])
			viewTagName: element tagName)
]

{ #category : #private }
CpViewCodeInspectorView >> requestTemplate [

	"Request template"

	self serverAnnounce: (CpViewInspectorTemplateRequest viewTagName: element tagName)
]

{ #category : #accessing }
CpViewCodeInspectorView >> revertStyle [

	cssEditor ifNil: [ ^ self ].

	cssEditor revert
]

{ #category : #accessing }
CpViewCodeInspectorView >> revertTemplate [

	htmlEditor revert
]

{ #category : #private }
CpViewCodeInspectorView >> saveStyle [

	self serverAnnounce: ((styleType = #style
		ifTrue: [ CpViewInspectorSaveStyleRequest ]
		ifFalse: [ CpViewInspectorSaveGlobalStyleRequest ]) viewTagName: element tagName style: self styleContent)
]

{ #category : #private }
CpViewCodeInspectorView >> saveTemplate [

	self serverAnnounce: (CpViewInspectorSaveTemplateRequest viewTagName: element tagName template: self templateContent)
]

{ #category : #private }
CpViewCodeInspectorView >> serverAnnounce: anAnnouncement [

	CpClientEnvironment current
		serverAnnounce: anAnnouncement
]

{ #category : #rendering }
CpViewCodeInspectorView >> showDom [

	| domTree |

	domTree := self domTree.

	self replaceAllChildrenWith: domTree atSlotNamed: #dom.

	"Expand 2 levels"
	"Perform update after short delay because it otherwise will not trigger actual update sl-tree-item"
	CpGlobalThis setTimeout: 10 thenDo: [
		(domTree allDescendantsMatching: ':scope > sl-tree-item') do: [ :each | each beExpanded ].	

		CpGlobalThis setTimeout: 10 thenDo: [
			(domTree allDescendantsMatching: ':scope > sl-tree-item > sl-tree-item') do: [ :each | each beExpanded ] ] ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> showElement: anElement [

	"Show the specified element.

	Implementation:
	If the element is a WebComponent, (request the server for template and style."

	"Do nothing if specified element already showing or if some element is showing and none is specified"
	anElement
		ifNotNil: [
			element = anElement
				ifTrue: [ ^ self ] ]
		ifNil: [
			element
				ifNotNil: [ ^ self ] ].

	self domSelectionRemove.

	element := anElement ifNil: [ CpHtmlElement documentBody ].
	styleType := #style.

	"Empty the current editors"
	self
		removeTemplate ;
		removeStyle.

	"Request the server for the template and style info (will render once results arrive)"
	self elementIsTemplateComponent
		ifTrue: [
			self
				requestTemplate ;
				requestStyle ].

	self showDom
]

{ #category : #rendering }
CpViewCodeInspectorView >> showGlobalStyle: aString [

	self showStyle: aString type: #globalStyle
]

{ #category : #rendering }
CpViewCodeInspectorView >> showSaveSuccess: aSymbol [

	aSymbol = styleType
		ifTrue: [ cssEditor markClean ]
		ifFalse: [
			aSymbol = #template
				ifTrue: [ htmlEditor markClean ]
				ifFalse: [ self error: 'Invalid state when receiving successful save of code' ] ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> showStyle: aString [

	self showStyle: aString type: #style
]

{ #category : #rendering }
CpViewCodeInspectorView >> showStyle: aString type: aSymbol [

	| container |

	aString ifNil: [ ^ self ].

	container := #div asHtmlTag
		when: (CpKeyDownEvent fromString: 'X-s') send: #handleApplyStyle: to: self ;
		when: (CpKeyDownEvent fromString: 'X-S-s') send: #handleSaveStyle: to: self ;
		yourself.

	cssEditor := CpCodeEditor in: (self replaceAllChildrenWith: container atSlotNamed: #style) onCss: aString.
	self controlsEnable: ((self shadowedElementWithId: #style) allDescendantsMatching: '.controls sl-icon-button').
	styleType := aSymbol.

	styleType = #style
		ifTrue: [
			(self shadowedElementWithId: #'local-style-button')
				bePrimary ;
				beEnabled.
			(self shadowedElementWithId: #'global-style-button')
				beDefault ;
				beEnabled ]
		ifFalse: [
			(self shadowedElementWithId: #'local-style-button')
				beDefault ;
				beEnabled.
			(self shadowedElementWithId: #'global-style-button')
				bePrimary ;
				beEnabled ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> showTemplate: aString [

	| container |

	aString ifNil: [ ^ self ].

	container := #div asHtmlTag
		when: (CpKeyDownEvent fromString: 'X-s') send: #handleApplyTemplate: to: self ;
		when: (CpKeyDownEvent fromString: 'X-S-s') send: #handleSaveTemplate: to: self ;
		yourself.

	htmlEditor := CpCodeEditor in: (self replaceAllChildrenWith: container atSlotNamed: #template) onHtml: aString.
	self controlsEnable: ((self shadowedElementWithId: #template) allDescendantsMatching: '.controls sl-icon-button')
]

{ #category : #accessing }
CpViewCodeInspectorView >> styleContent [

	cssEditor ifNil: [ ^ '' ].

	^ cssEditor content
]

{ #category : #accessing }
CpViewCodeInspectorView >> templateContent [

	^ htmlEditor content
]
