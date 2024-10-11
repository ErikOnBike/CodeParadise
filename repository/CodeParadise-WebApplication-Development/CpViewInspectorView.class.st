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

	SlCard beLoaded.
	SlDivider beLoaded.
	SlInput beLoaded.
	SlMenu beLoaded.
	SlMenuItem beLoaded.
	SlMenuLabel beLoaded.
	SlPopup beLoaded.
	SlSplitPanel beLoaded
]

{ #category : #'instance creation' }
CpViewInspectorView class >> createInstance [

	self first ifNotNil: [ ^ self ].

	CpHtmlElement documentBody
		appendChild: super new
]

{ #category : #'instance creation' }
CpViewInspectorView class >> new [

	self error: 'New instance should be created using ', #createInstance
]

{ #category : #'class initialization' }
CpViewInspectorView class >> postInstallOnce [

	"Add a single instance of the receiver to the DOM"

	CpClientEnvironment current objectRegistry
		registerObject: self
		withId: self name.

	self createInstance
]

{ #category : #rendering }
CpViewInspectorView class >> showAlert: aString [

	SlAlert new
		beClosable ;
		appendChild: ((SlIcon named: 'info-circle')
			slot: 'icon' ;
			yourself) ;
		textContent: aString ;
		duration: 1500 ;
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
	:host(.active),
	:host(.active-menu) {
		pointer-events: auto;
	}
	#container {
		width: 100%;
		height: 100%;
		overflow: hidden;
		font-family: "Monaco", "Lucida Grande", "Andela Mono", "Courier";
		font-size: 12px;
	}
	#views {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		padding: 6px 6px;
		background-color: #fff;
	}
	:host(:not(.active)) #views {
		display: none;
	}
	:host(.free-top) #views {
		top: auto;
		bottom: 0;
	}
	::slotted(.link.active) {
		/* Trickery here to get button to show differently */
		--sl-color-neutral-0: #00f;
		--sl-color-neutral-700: #fff;
	}
	#menu {
		top: 1em;
		left: 1em;
		max-width: 22em;
	}
	:host(:not(.active-menu)) #menu {
		display: none;
	}
	#input {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		z-index: 9999;
		pointer-events: auto;
	}
	:host(:not(.active-input)) #input {
		display: none;
	}
	#completion {
		max-height: 300px;
		padding: 8px;
		overflow-y: scroll;
		border: 1px solid #666;
		border-radius: 6px;
		background-color: #fff;
	}
	::slotted([slot="completion"]) {
		display: inline-block;
		width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	::slotted([slot="completion"]:not(:last-child)) {
		border-bottom: 1px solid #ccc;
	}
	::slotted([slot="completion"].selected) {
		background-color: #00f;
		color: #fff;
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
		<div id="views"><span>Inspector selection: </span><slot name="views"></slot></div>
		<sl-menu id="menu">
			<sl-menu-label>Select action</sl-menu-label>
			<sl-divider></sl-divider>
			<sl-menu-item id="browse-template-in-pharo">Browse template in Pharo</sl-menu-item>
			<sl-menu-item id="browse-style-in-pharo">Browse style in Pharo</sl-menu-item>
			<sl-menu-item id="browse-style-in-browser">Browse style here</sl-menu-item>
			<sl-menu-item id="browse-presenter-in-pharo">Browse Presenter in Pharo</sl-menu-item>
			<sl-divider></sl-divider>
			<sl-menu-item>Close</sl-menu-item>
		</sl-menu>
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

{ #category : #actions }
CpViewInspectorView >> activate [

	"Activate inspector by adding appropriate event handlers"

	"Make sure the inspector is on top"
	self makeTopView.

	self
		when: CpPointerMoveEvent send: #handlePointerMove: to: self.
	CpHtmlElement documentBody
		when: CpKeyDownEvent arrowRight send: #handleNextLink: to: self ;
		when: CpKeyDownEvent arrowLeft send: #handlePreviousLink: to: self ;
		when: CpKeyDownEvent enter send: #handleSelectLink: to: self.

	self addClass: #active
]

{ #category : #rendering }
CpViewInspectorView >> addViewLinkFor: anElement [

	self appendChild: (self viewLinkFor: anElement) atSlotNamed: #views
]

{ #category : #rendering }
CpViewInspectorView >> closeInput [

	self removeClass: #'active-input'
]

{ #category : #rendering }
CpViewInspectorView >> closeMenu [

	self removeClass: #'active-menu'
]

{ #category : #accessing }
CpViewInspectorView >> codeElement [

	^ self firstChild
]

{ #category : #actions }
CpViewInspectorView >> deactivate [

	"Deactivate inspector by removing installed event handlers"

	self removeClass: #active.

	self unsubscribe: self.
	CpHtmlElement documentBody unsubscribe: self
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowse: aKeyEvent [

	aKeyEvent preventDefault.

	self showInput
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowsePresenterInPharo [

	self serverAnnounce: (CpViewInspectorBrowsePresenterRequest viewTagName: self selectedTagName).

	self closeMenu
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowseStyleInBrowser [

	self showCode.

	self closeMenu
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowseStyleInPharo [

	self serverAnnounce: (CpViewInspectorBrowseStyleRequest viewTagName: self selectedTagName).

	self closeMenu
]

{ #category : #'event handling' }
CpViewInspectorView >> handleBrowseTemplateInPharo [

	self serverAnnounce: (CpViewInspectorBrowseTemplateRequest viewTagName: self selectedTagName).

	self closeMenu
]

{ #category : #'event handling' }
CpViewInspectorView >> handleCloseMenu [

	self closeMenu
]

{ #category : #'event handling' }
CpViewInspectorView >> handleEndInput [

	(self shadowedElementWithId: #'name-complete')
		beNotActive.

	classNameCache := nil
]

{ #category : #'event handling' }
CpViewInspectorView >> handleInput [

	| input selectedClassName |

	input := (self shadowedElementWithId: #'name-input') value.

	selectedClassName := (completionIndex > 0
		ifTrue: [ (self childrenAtSlotNamed: #completion) at: completionIndex ifAbsent: [ nil ] ]
		ifFalse: [ nil ]) ifNotNil: [ :selection | selection textContent ].

	self removeChildrenAtSlotNamed: #completion.
	completionIndex := 0.

	(classNameCache select: [ :each | each includesSubstring: input ]) withIndexDo: [ :each :index |
		| selection |
		selection := self appendChild: each asHtmlElement atSlotNamed: #completion.
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
CpViewInspectorView >> handleNextLink: aKeyPressEvent [

	| selectedLink |

	aKeyPressEvent preventDefault.

	selectedLink := self selectedLink
		ifNil: [ ^ self ].

	selectedLink removeClass: #active.
	selectedLink := selectedLink nextSibling
		ifNil: [ self firstChildAtSlotNamed: #views ].
	selectedLink ifNotNil: [ 
		selectedLink addClass: #active ]
]

{ #category : #'event handling' }
CpViewInspectorView >> handlePointerMove: aPointerMoveEvent [

	"Find Views under the cursor and show them.
	Keep track of views to allow slight pointer movement"

	| point |

	point := aPointerMoveEvent point.

	self classed: #'free-top' if: point y < 40.

	self updateViews: (self viewsUnderPointer: point)
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
CpViewInspectorView >> handlePreviousLink: aKeyPressEvent [

	| selectedLink |

	aKeyPressEvent preventDefault.

	selectedLink := self selectedLink
		ifNil: [ ^ self ].

	selectedLink removeClass: #active.
	selectedLink := selectedLink previousSibling
		ifNil: [ self lastChildAtSlotNamed: #views ].
	selectedLink ifNotNil: [ 
		selectedLink addClass: #active ]
]

{ #category : #'event handling' }
CpViewInspectorView >> handleSelectCompletion [

	| className |

	className := completionIndex > 0
		ifTrue: [ ((self childrenAtSlotNamed: #completion) at: completionIndex) textContent ]
		ifFalse: [ (self shadowedElementWithId: #'name-input') value ].

	className ifEmpty: [
		self closeInput.
		^ self ].

	CpTemplateComponent allSubclassesDo: [ :each |
		each name = className
			ifTrue: [
				self closeInput.
				self showCodeFor: (each first ifNil: [ each new ]).
				^ self ] ].

	self class showErrorAlert: 'Class not found: ', className printString
]

{ #category : #'event handling' }
CpViewInspectorView >> handleSelectLink: aKeyEvent [

	aKeyEvent preventDefault.

	self selectLink
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
CpViewInspectorView >> handleToggle: aKeyDownEvent [

	"Prevent the key from being processed further"
	aKeyDownEvent
		stopPropagation ;
		preventDefault.

	self closeMenu.
	self closeInput.

	(self isClassed: #active)
		ifTrue: [ self deactivate ]
		ifFalse: [ self activate ]
]

{ #category : #rendering }
CpViewInspectorView >> hideCode [

	self removeClass: #'active-code'
]

{ #category : #initialization }
CpViewInspectorView >> initialize [

	super initialize.

	completionIndex := 0.

	self appendChild: CpViewCodeInspectorView new atSlotNamed: #end.

	CpHtmlElement document
		when: (CpKeyDownEvent key: 'i') & CpActionKeyDown send: #handleToggle: to: self ;
		when: (CpKeyDownEvent key: 'b') & CpActionKeyDown send: #handleBrowse: to: self
]

{ #category : #initialization }
CpViewInspectorView >> initializeShadowRoot [

	super initializeShadowRoot.

	self menuElement
		when: CpKeyPressEvent escape send: #handleCloseMenu to: self.

	(self menuItemFor: #'browse-template-in-pharo')
		when: CpClickEvent send: #handleBrowseTemplateInPharo to: self.
	(self menuItemFor: #'browse-style-in-pharo')
		when: CpClickEvent send: #handleBrowseStyleInPharo to: self.
	(self menuItemFor: #'browse-style-in-browser')
		when: CpClickEvent send: #handleBrowseStyleInBrowser to: self.
	(self menuItemFor: #'browse-presenter-in-pharo')
		when: CpClickEvent send: #handleBrowsePresenterInPharo to: self.
	(self shadowedElementWithId: #'name-input')
		when: SlFocusEvent send: #handleStartInput to: self ;
		when: SlInputEvent send: #handleInput to: self ;
		when: SlBlurEvent send: #handleEndInput to: self ;
		when: CpKeyDownEvent arrowUp send: #handlePreviousCompletion to: self ;
		when: CpKeyDownEvent arrowDown send: #handleNextCompletion to: self ;
		when: CpKeyDownEvent enter send: #handleSelectCompletion to: self
]

{ #category : #rendering }
CpViewInspectorView >> insertViewLinkFor: viewElement before: linkElement [

	"Insert a new view link for the specified view element before the link element.
	If link element is nil, append the view link."

	linkElement
		ifNotNil: [ self insertChild: (self viewLinkFor: viewElement) before: linkElement atSlotNamed: #views ]
		ifNil: [ self addViewLinkFor: viewElement ]
]

{ #category : #rendering }
CpViewInspectorView >> makeTopView [

	"Make receiver top View by making it the last child within its parent"

	self nextSibling ifNil: [ ^ self ].

	self parent appendChild: self remove
]

{ #category : #accessing }
CpViewInspectorView >> menuElement [

	^ self shadowedElementWithId: #menu
]

{ #category : #accessing }
CpViewInspectorView >> menuItemFor: aString [

	"Answer the menu item for the specified id"

	^ self shadowedElementWithId: aString
]

{ #category : #rendering }
CpViewInspectorView >> removeViewLink: linkElement [

	linkElement removePropertyAt: #element.

	linkElement destroy
]

{ #category : #actions }
CpViewInspectorView >> selectLink [

	self deactivate.

	self showMenu
]

{ #category : #accessing }
CpViewInspectorView >> selectedElement [

	"Answer the element for the view link which is active"

	^ self selectedLink ifNotNil: [ :element |
		element propertyAt: #element ]
]

{ #category : #accessing }
CpViewInspectorView >> selectedElementIsView [

	"Answer whether the element for the view link which is active is actually a CpView (instead of CpTemplateComponent)"

	^ self selectedElement
		ifNotNil: [ :element | element isKindOf: CpView ]
		ifNil: [ false ]
]

{ #category : #accessing }
CpViewInspectorView >> selectedLink [

	"Answer the view link which is active"

	^ self firstDescendantMatching: '.active.link'
]

{ #category : #accessing }
CpViewInspectorView >> selectedTagName [

	"Answer the tag name for the view link which is active"

	^ self selectedElement ifNotNil: [ :element |
		element tagName ]
]

{ #category : #private }
CpViewInspectorView >> serverAnnounce: anAnnouncement [

	CpClientEnvironment current
		serverAnnounce: anAnnouncement
]

{ #category : #rendering }
CpViewInspectorView >> showCode [

	self selectedElement ifNotNil: [ :element |
		self showCodeFor: element ]
]

{ #category : #rendering }
CpViewInspectorView >> showCodeFor: anElement [

	self codeElement showElement: anElement.

	self addClass: #'active-code'
]

{ #category : #rendering }
CpViewInspectorView >> showInput [

	self deactivate.
	self closeMenu.

	self addClass: #'active-input'.

	(self shadowedElementWithId: #'name-input') focus
]

{ #category : #rendering }
CpViewInspectorView >> showMenu [

	self deactivate.
	self closeInput.

	self addClass: #'active-menu'.

	(self menuElement firstDescendantMatching: SlMenuLabel asCssSelector)
		labelText: 'Select action for: ', self selectedTagName printString.
	(self menuItemFor: #'browse-presenter-in-pharo') enabled: self selectedElementIsView.
	(self menuItemFor: #'browse-style-in-browser') focus
]

{ #category : #rendering }
CpViewInspectorView >> updateViews: aCollection [

	| selectedLink nextViewLink |

	selectedLink := self selectedLink.
	nextViewLink := self firstChildAtSlotNamed: #views.

	aCollection reverseDo: [ :each |
		nextViewLink
			ifNotNil: [
				(self viewLink: nextViewLink isFor: each)
					ifTrue: [ nextViewLink := nextViewLink nextSibling ]
					ifFalse: [
						| newNextViewLink |
						newNextViewLink := nextViewLink nextSibling.
						selectedLink == nextViewLink
							ifTrue: [ selectedLink := nil ].
						self removeViewLink: nextViewLink.
						self insertViewLinkFor: each before: newNextViewLink.
						nextViewLink := newNextViewLink ] ]
			ifNil: [ self addViewLinkFor: each ] ].

	"Remove 'old' view links"
	nextViewLink ifNotNil: [
		"Remove everything after the first known old view link"
		[ nextViewLink nextSibling isNotNil ] whileTrue: [
			(self lastChildAtSlotNamed: #views) destroy ].

		"Remove the old view link itself"
		nextViewLink destroy ].

	selectedLink ifNil: [
		selectedLink := self lastChildAtSlotNamed: #views ].

	selectedLink ifNotNil: [
			selectedLink addClass: #active ]
]

{ #category : #rendering }
CpViewInspectorView >> viewLink: linkElement isFor: viewElement [

	"Answer whether the specified view element matches the element in
	the specified link element"

	^ (linkElement propertyAt: #element) == viewElement
]

{ #category : #rendering }
CpViewInspectorView >> viewLinkFor: anElement [

	"Answer a link for the specified element.
	Add the element as a property to allow recognition later."

	^ SlButton new
		beSmall ;
		labelText: '<', anElement tagName, '>' ;
		addClass: #link ;
		propertyAt: #element put: anElement ;
		yourself
]

{ #category : #accessing }
CpViewInspectorView >> viewsUnderPointer: aPoint [

	| viewsUnderPointer |

	viewsUnderPointer := CpHtmlElement elementsFromPoint: aPoint.

	"Select views with a template only, ignoring ourself (we are also template view)"

	^ viewsUnderPointer
		select: [ :each | each isWebComponent and: [ each hasTemplate and: [ each ~= self ] ] ]
]
