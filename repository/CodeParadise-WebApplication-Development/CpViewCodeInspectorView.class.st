Class {
	#name : #CpViewCodeInspectorView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'element',
		'originalStyle',
		'selectedDomElement',
		'selectedCssPropIndex'
	],
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #'class initialization' }
CpViewCodeInspectorView class >> beLoaded [

	SlIconButton beLoaded.
	SlInput beLoaded.
	SlIcon beLoaded.
	CpBrowserCSSStyleDeclaration beLoaded
]

{ #category : #'web resources' }
CpViewCodeInspectorView class >> globalStyle [

	<webResource: #css>

	^ '[slot="dom"] sl-tree-item::part(expand-button) {
		padding: 0;
	}
	[slot="dom"] sl-tree-item {
		--sl-font-sans: "Monaco", "Lucida Grande", "Andela Mono", "Courier";
		--sl-font-size-medium: 12px;
	}
	[slot="dom"] sl-tree-item span {
		display: block;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	[slot="css-rules"] {
		width: 100%;
		height: 100%;
		resize: none;
		white-space: pre;
	}
	[slot="css-props"] span {
		display: block;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		cursor: pointer;
	}
	[slot="css-props"] span.hide {
		display: none;
	}
	.dev-highlight:before {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 255, .5);
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
	#code {
		height: 100%;
		overflow: hidden;
	}
	#dom,
	#css-rules,
	#css-props {
		position: relative;
		width: 100%;
		height: 100%;
		overflow-x: hidden;
		overflow-y: scroll;
	}
	#css {
		width: 100%;
		height: 100%;
		overflow: hidden;
	}
	#refresh-dom,
	#refresh-css-rules,
	#refresh-css-props {
		position: absolute;
		top: 0;
		right: 0;
		font-size: 1.5em;
		z-index: 20;
	}
	#refresh-css-props {
		right: 4.2em;
	}
	#props-filter {
		display: block;
		width: calc(100% - 9em);
		margin-bottom: 4px;
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
		<sl-split-panel id="code" position="33" slot="end">
			<div id="dom" slot="start"><sl-icon-button id="refresh-dom" name="arrow-clockwise"></sl-icon-button><slot name="dom"></slot></div>
			<sl-split-panel id="css" slot="end">
				<div id="css-rules" slot="start"><sl-icon-button id="refresh-css-rules" name="arrow-clockwise"></sl-icon-button><slot name="css-rules"></slot></div>
				<div id="css-props" slot="end"><sl-input id="props-filter" placeholder="font" size="small"><sl-icon name="filter-circle" slot="suffix"></sl-icon></sl-input><sl-icon-button id="refresh-css-props" name="arrow-clockwise"></sl-icon-button><slot name="css-props"></slot></div>
			</sl-split-panel>
		</sl-split-panel>
	</div>'
]

{ #category : #rendering }
CpViewCodeInspectorView >> applyFilter [

	| filter |

	filter := (self shadowedElementWithId: #'props-filter') value.

	self cssPropNamesElement children withIndexDo: [ :each :index |
		| hide |
		hide := (each textContent includesSubstring: filter) not.
		each classed: #hide if: hide.
		(self selectedCssPropValueElementAt: index) classed: #hide if: hide ]
]

{ #category : #accessing }
CpViewCodeInspectorView >> cssPropNamesElement [

	^ (self firstChildAtSlotNamed: #'css-props') firstDescendantMatching: '[slot="start"]'
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTree [

	"Answer a DOM tree"

	^ SlTree new
		appendChild: (self domTreeFor: self element) ;
		yourself
]

{ #category : #rendering }
CpViewCodeInspectorView >> domTreeFor: anElement [

	"Answer a DOM tree for the specified Element"

	| tree |

	tree := SlTreeItem new
		appendChild: (self treeItemContentFor: anElement) ;
		propertyAt: #element put: anElement ;
		when: CpClickEvent send: #handleDomElementSelected: to: self ;
		yourself.

	anElement isWebComponent
		ifTrue: [
			anElement shadowRoot ifNotNil: [ :shadowRoot |
				shadowRoot children ifNotEmpty: [ :children |
					| shadowTree |
					shadowTree := tree appendChild: (SlTreeItem new
						appendChild: '-- shadow DOM --' asHtmlElement ;
						yourself).
					children do: [ :each |
						shadowTree appendChild: (self domTreeFor: each) ] ] ] ].

	anElement children ifNotEmpty: [ :children |
		children do: [ :each |
			tree appendChild: (self domTreeFor: each) ] ].

	^ tree
]

{ #category : #accessing }
CpViewCodeInspectorView >> element [

	^ element
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleClose [

	self parent hideCode
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleCssPropSelected: aClickEvent [

	selectedCssPropIndex >= 1
		ifTrue: [
			self selectedCssPropNameElement ifNotNil: [ :nameElement | nameElement removeStyleAt: #'background-color' ].
			self selectedCssPropValueElement ifNotNil: [ :valueElement | valueElement removeStyleAt: #'background-color' ] ].

	selectedCssPropIndex := aClickEvent target indexInParent.
	selectedCssPropIndex = 0
		ifTrue: [ ^ self ].

	self selectedCssPropNameElement ifNotNil: [ :nameElement | nameElement styleAt: #'background-color' put: 'rgba(0, 0, 255, .5)' ].
	self selectedCssPropValueElement ifNotNil: [ :valueElement | valueElement styleAt: #'background-color' put: 'rgba(0, 0, 255, .5)' ]
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleDomElementSelected: aClickEvent [

	selectedDomElement ifNotNil: [
		selectedDomElement
			removeStyleAt: #'background-color' ;
			removeStyleAt: #border ].

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

	selectedDomElement
		styleAt: #'background-color' put: 'rgba(0, 0, 255, .5)' ;
		styleAt: #border put: '2px solid #00f'
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleFilter [

	self applyFilter
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleInsertTab: aKeyEvent [

	aKeyEvent preventDefault.

	self insertTab
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSaveStyle: aKeyEvent [

	aKeyEvent preventDefault.

	self saveStyle
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSwap [

	| position |

	position := self attributeAt: #slot.
	self attributeAt: #slot put: (
		position = #start
			ifTrue: [ #end ]
			ifFalse: [ #start ])
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> handleSyncStyle: aKeyEvent [

	aKeyEvent preventDefault.

	self syncStyle
]

{ #category : #initialization }
CpViewCodeInspectorView >> initialize [

	super initialize.

	selectedCssPropIndex := 0.

	CpHtmlElement document
		when: (CpKeyDownEvent fromString: 'X-S-s') send: #handleSyncStyle: to: self
]

{ #category : #initialization }
CpViewCodeInspectorView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedElementWithId: #swap)
		when: CpClickEvent send: #handleSwap to: self.
	(self shadowedElementWithId: #close)
		when: CpClickEvent send: #handleClose to: self.
	(self shadowedElementWithId: #'refresh-dom')
		when: CpClickEvent send: #showDom to: self.
	(self shadowedElementWithId: #'refresh-css-rules')
		when: CpClickEvent send: #showCssRules to: self.
	(self shadowedElementWithId: #'refresh-css-props')
		when: CpClickEvent send: #showCssProps to: self.
	(self shadowedElementWithId: #'props-filter')
		when: SlChangeEvent send: #handleFilter to: self
]

{ #category : #rendering }
CpViewCodeInspectorView >> insertTab [

	| editor content selectionStart selectionEnd |

	editor := self firstChildAtSlotNamed: #'css-rules'.
	content := editor propertyAt: #value.
	selectionStart := editor propertyAt: #selectionStart.
	selectionEnd := editor propertyAt: #selectionEnd.
	content := String streamContents: [ :stream |
		| selection |
		selection := content copyFrom: selectionStart + 1 to: selectionEnd.

		"Insert tabs after any linefeeds (except for empty lines and the last line)"
		selection := String streamContents: [ :selectionStream |
			selection withIndexDo: [ :each :index |
				selectionStream nextPut: each.
				(each = Character lf and: [ index < selection size and: [ (selection at: index + 1) ~= Character lf ] ])
					ifTrue: [ selectionStream nextPut: Character tab ] ] ].

		stream
			nextPutAll: (content copyFrom: 1 to: selectionStart) ;
			nextPut: Character tab ;
			nextPutAll: selection ;
			nextPutAll: (content copyFrom: selectionEnd + 1 to: content size) ].

	editor
		propertyAt: #value put: content ;
		propertyAt: #selectionStart put: selectionStart + 1 ;
		propertyAt: #selectionEnd put: selectionStart + 1
]

{ #category : #rendering }
CpViewCodeInspectorView >> saveStyle [

	self style: ((self firstChildAtSlotNamed: #'css-rules') propertyAt: #value)
]

{ #category : #accessing }
CpViewCodeInspectorView >> selectedCssPropNameElement [

	^ self selectedCssPropNameElementAt: selectedCssPropIndex
]

{ #category : #accessing }
CpViewCodeInspectorView >> selectedCssPropNameElementAt: anInteger [

	^ anInteger >= 1
		ifTrue: [ (self firstChildAtSlotNamed: #'css-props') firstDescendantMatching: '[slot="start"] > span:nth-child(', anInteger printString, ')' ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
CpViewCodeInspectorView >> selectedCssPropValueElement [

	^ self selectedCssPropValueElementAt: selectedCssPropIndex
]

{ #category : #accessing }
CpViewCodeInspectorView >> selectedCssPropValueElementAt: anInteger [

	^ anInteger >= 1
		ifTrue: [ (self firstChildAtSlotNamed: #'css-props') firstDescendantMatching: '[slot="end"] > span:nth-child(', anInteger printString, ')' ]
		ifFalse: [ nil ]
]

{ #category : #'event handling' }
CpViewCodeInspectorView >> serverAnnounce: anAnnouncement [

	CpClientEnvironment current
		serverAnnounce: anAnnouncement
]

{ #category : #rendering }
CpViewCodeInspectorView >> show [

	self
		showDom ;
		showCssRules ;
		showCssProps
]

{ #category : #rendering }
CpViewCodeInspectorView >> showCssProps [

	| computedStyles propsElement nameElements valueElements |

	computedStyles := CpBrowserWindow current getComputedStyle: element.

	nameElements := #div asHtmlTag.
	valueElements := #div asHtmlTag.

	1 to: computedStyles length do: [ :index |
		| name |
		nameElements appendChild: ((name := computedStyles nameAt: index) asHtmlElement
			when: CpClickEvent send: #handleCssPropSelected: to: self ;
			yourself).
		valueElements appendChild: ((computedStyles getPropertyValue: name) asHtmlElement
			when: CpClickEvent send: #handleCssPropSelected: to: self ;
			yourself) ].

	propsElement := SlSplitPanel new
		appendChild: nameElements atSlotNamed: #start ;
		appendChild: valueElements atSlotNamed: #end ;
		yourself.

	self replaceAllChildrenWith: propsElement atSlotNamed: #'css-props'
]

{ #category : #rendering }
CpViewCodeInspectorView >> showCssRules [

	| editor |

	editor := (self style inHtmlTag: #textarea)
		when: (CpKeyPressEvent key: 's') & CpActionKeyDown send: #handleSaveStyle: to: self ;
		when: CpKeyDownEvent tab send: #handleInsertTab: to: self ;
		yourself.

	self replaceAllChildrenWith: editor atSlotNamed: #'css-rules'
]

{ #category : #rendering }
CpViewCodeInspectorView >> showDom [

	| domTree |

	domTree := self domTree.

	"Expand 3 levels"
	(domTree allDescendantsMatching: ':scope > sl-tree-item') do: [ :each | each beExpanded ].	
	(domTree allDescendantsMatching: ':scope > sl-tree-item > sl-tree-item') do: [ :each | each beExpanded ].
	(domTree allDescendantsMatching: ':scope > sl-tree-item > sl-tree-item > sl-tree-item') do: [ :each | each beExpanded ].

	self replaceAllChildrenWith: domTree atSlotNamed: #dom
]

{ #category : #rendering }
CpViewCodeInspectorView >> showElement: anElement [

	element := anElement.
	originalStyle := self style.

	self show
]

{ #category : #accessing }
CpViewCodeInspectorView >> style [

	element ifNil: [ ^ nil ].

	^ (element shadowedElementWithId: 'cp-css--', element tagName)
		ifNotNil: [ :styleElement |
			styleElement textContent replaceAll: Character cr with: Character lf ]
]

{ #category : #accessing }
CpViewCodeInspectorView >> style: aString [

	element ifNil: [ ^ nil ].

	^ (element shadowedElementWithId: 'cp-css--', element tagName)
		ifNotNil: [ :styleElement |
			styleElement textContent: (aString replaceAll: Character lf with: Character cr) ]
]

{ #category : #rendering }
CpViewCodeInspectorView >> syncStyle [

	self saveStyle.

	self serverAnnounce: (CpViewInspectorSyncStyleRequest viewTagName: element tagName style: self style)
]

{ #category : #rendering }
CpViewCodeInspectorView >> treeItemContentFor: anElement [

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
