"
I am a generic Model View. I am responsible for setting up and tearing down
bindings between the model and the view. I know the page I live in. I will be
updated before and after navigation occurs.
"
Class {
	#name : #CynModelView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'model',
		'bindingSubscriptions',
		'childViewDefinitionsBySlotName',
		'selectedTabNames'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'instance creation' }
CynModelView class >> new [

	"Answer a new instance without a Model"

	^ self on: nil
]

{ #category : #'instance creation' }
CynModelView class >> on: aModel [

	^ self basicNew
		initialize ;
		model: aModel ;
		yourself
]

{ #category : #'web resources' }
CynModelView class >> style [

	<webResource: #css>

	"Subclasses however should probably call this style and append additional styling."

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	display: flex;
	flex-direction: column;
	height: 100%;
}
:host > :not(style) {
	flex-grow: 1;
}
div.empty {
	display: none;
}'
]

{ #category : #view }
CynModelView >> activeChildView [

	"Convenience method to access the first (and presumable only) active child view"

	self activeChildViewsDo: [ :each | ^ each ].

	^ nil
]

{ #category : #view }
CynModelView >> activeChildViewsDo: aBlock [

	"Evaluate the specified Block for all child views (created from my childViewsDefinitions)
	of the receiver which are active at the moment. Views inside a IonTab which is not selected,
	are NOT considered active. This method can be used to update only active/visible elements."

	self childViewsDo: [ :each |
		(self isActiveChildView: each)
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #view }
CynModelView >> activeChildViewsInTab: aTab do: aBlock [

	"Evaluate the specified Block for all active child views in the specified tab"

	(aTab allDescendantsMatching: #slot) do: [ :eachSlot |
		(self childrenAtSlotNamed: (eachSlot attributeAt: #name)) do: [ :each |
			(self isActiveChildView: each)
				ifTrue: [ aBlock value: each ] ] ]
]

{ #category : #binding }
CynModelView >> addBinding: aSubscription [

	"Add the subscription to the Collection of known bindings"

	bindingSubscriptions ifNil: [ bindingSubscriptions := OrderedCollection new ].

	bindingSubscriptions
		add: aSubscription
]

{ #category : #binding }
CynModelView >> addBindings [

	"Add any bindings between the model and the receiver"

	model ifNil: [ ^ self ].

	self addBinding: (model whenChangedSend: #modelChanged: to: self)
]

{ #category : #private }
CynModelView >> allBackButtons [

	^ self shadowedAllDescendantsMatching: IonBackButton asCssSelector
]

{ #category : #private }
CynModelView >> allSlots [

	^ self shadowedAllDescendantsMatching: #slot
]

{ #category : #private }
CynModelView >> allTabs [

	^ self shadowedAllDescendantsMatching: IonTabs asCssSelector
]

{ #category : #accessing }
CynModelView >> app [

	"Convenience method to access the app (instance)"

	^ CynApp current
]

{ #category : #'view - customization' }
CynModelView >> canNavigate [

	"Answer whether it is allowed to navigating (away) from the receiver"

	^ true
]

{ #category : #'view - customization' }
CynModelView >> canNavigateBack [

	"Answer whether it is allowed to navigating back (away) from the receiver"

	^ self canNavigate
]

{ #category : #'view - customization' }
CynModelView >> childViewDefinitions [

	"Answer the child view definitions for the receiver (Collection of CynModelViewDefinition instances).
	The order of the definitions is important if multiple child views are present in the same slot.

	These child view definitions are cached locally. So please answer a static structure. To have a child
	view be conditional, make use of the conditional definitions (see the instance creation methods of
	CynModelViewDefinition)."

	^ #()
]

{ #category : #private }
CynModelView >> childViewsDo: aBlock [

	"Evaluate the specified Block for all child views (created from my childViewsDefinitions)"

	childViewDefinitionsBySlotName ifNil: [ self warnCr: 'Callled childViews without child definition from ', self printString. ^ self ].

	childViewDefinitionsBySlotName keysDo: [ :slotName |
		(self childrenAtSlotNamed: slotName) do: [ :each |
			(self isEmptyChildSlot: each)
				ifFalse: [ aBlock value: each ] ] ]
]

{ #category : #view }
CynModelView >> closeAndNavigateTo: aPageClass withModel: aModel [

	"Close the receiver and navigate to the specified Page Class with the specified Model"

	self page
		closeAndNavigateTo: aPageClass withModel: aModel
]

{ #category : #view }
CynModelView >> closePage [

	self page
		close
]

{ #category : #initialization }
CynModelView >> destroy [

	self traceCr: 'Destroying ', self printString.

	super destroy.

]

{ #category : #view }
CynModelView >> do: aBlock whileShowing: aString [

	"Evaluate the specified Block while showing a message.
	Answer the result of the evaluation.

	Implementation:
	The loading message will not be shown until a loading time has passed. This is to
	prevent 'flickering' of a loading message on very short operations.
	Because error handling is being performed before the ensure Block is performed, also
	hide the loading message when an Error is signaled (hiding it twice will do no harm)."

	| timer |

	timer := CpGlobalThis setTimeout: self loadingTimeout thenDo: [ self app showLoading: aString ].
	^ [
		aBlock ensure: [
			CpGlobalThis clearTimeout: timer.
			self app hideLoading ]
	] on: Error do: [ :error |
		"Hide the loading message and pass on the Error"
		CpGlobalThis clearTimeout: timer.
		self app hideLoading.
		error pass ]
]

{ #category : #operations }
CynModelView >> doDelete [

	"Perform the write operation and answer the result.
	In case of an error the receiver's error handler is called
	and its result is answered."

	^ [
		self doDeleteWhileShowing: self loadingDeleteText
	] on: Error do: [ :error | self handleError: error ]
]

{ #category : #operations }
CynModelView >> doDeleteWhileShowing: aString [

	"Delete the receiver's model while showing a message.
	Answer the result of the delete request."

	^ self do: [ self modelDelete ] whileShowing: aString
]

{ #category : #operations }
CynModelView >> doRead [

	"Perform the write operation and answer the result.
	In case of an error the receiver's error handler is called
	and its result is answered."

	^ [
		self doReadWhileShowing: self loadingReadText
	] on: Error do: [ :error | self handleError: error ]
]

{ #category : #operations }
CynModelView >> doReadWhileShowing: aString [

	"Read the receiver's model while showing a message.
	Answer the result of the read request."

	^ self do: [ self modelRead ] whileShowing: aString
]

{ #category : #operations }
CynModelView >> doWrite [

	"Perform the write operation and answer the result.
	In case of an error the receiver's error handler is called
	and its result is answered."

	^ [
		self doWriteWhileShowing: self loadingWriteText
	] on: Error do: [ :error | self handleError: error ]
]

{ #category : #operations }
CynModelView >> doWriteWhileShowing: aString [

	"Write the receiver's model while showing a message.
	Answer the result of the write request."

	^ self do: [ self modelWrite ] whileShowing: aString
]

{ #category : #'event handling' }
CynModelView >> handleError: anError [

	"Handle the specified Error.
	By default the Error is answered, but subclasses might override this behavior
	if a different result of one of the doRead/Write/Delete operations is required.

	Subclasses should handle specific errors, all else will be handled by the app."

	self app handleUnhandledError: anError.

	^ anError
]

{ #category : #'event handling' }
CynModelView >> handleNavigateBack [

	"Handle the 'back' button click"

	self page navigateBack
]

{ #category : #'event handling' }
CynModelView >> handleTabsDidChange: anEvent [

	"A tab in the receiver is changed, update the tabs content"

	(self tabFromTabChangeEvent: anEvent) ifNotNil: [ :tab |

		"Store the selected tab (so it can be restored when the view is updated, only valuable for during development)"
		self keepSelectedTab: tab.

		"Only update if not already updating because of navigation"
		(self isClassed: #navigating)
			ifFalse: [
				self activeChildViewsInTab: tab do: [ :each |
					each updateAfterNavigate ] ] ]
]

{ #category : #'event handling' }
CynModelView >> handleTabsWillChange: anEvent [

	"A tab in the receiver is going to change, update the tabs content"

	(self tabFromTabChangeEvent: anEvent) ifNotNil: [ :tab |

		"Only update if not already updating because of navigation"
		(self isClassed: #navigating)
			ifFalse: [
				self activeChildViewsInTab: tab do: [ :each |
					each updateBeforeNavigate ] ] ]
]

{ #category : #testing }
CynModelView >> hasTabs [

	"Answer whether the receiver has tabs which are page level.
	See #initializeShadowRoot:"

	^ self isClassed: #tabs
]

{ #category : #accessing }
CynModelView >> header [

	"Answer the IonHeader element of the receiver (nil if none is present)"

	^ self shadowedFirstDescendantMatching: IonHeader asCssSelector
]

{ #category : #accessing }
CynModelView >> headerTitle [

	"Answer the IonTitle element of the receiver's header (nil if none is present)"

	^ self header ifNotNil: [ :header |
		header firstDescendantMatching: IonTitle asCssSelector ]
]

{ #category : #accessing }
CynModelView >> headerToolbar [

	"Answer the IonToolbar element of the receiver's header (nil if none is present)"

	^ self header ifNotNil: [ :header |
		header firstDescendantMatching: IonToolbar asCssSelector ]
]

{ #category : #initialization }
CynModelView >> initializeShadowRoot [

	| hasTabs |

	super initializeShadowRoot.

	"Make any back button in the receiver work"
	self allBackButtons do: [ :each |
		each
			when: CpClickEvent deferSend: #handleNavigateBack to: self ;
			when: CpClickEvent send: #preventDefault: to: self ].

	"In case the receiver has tabs, set event handler on tab changes"
	hasTabs := false.
	self allTabs do: [ :each |

		"Only tabs with an id can be referenced and therefore used here.
		Also check this IonTabs instance is marked to be ignored."
		(each id isNotNil and: [ (each isClassed: #ignoreTabChanges) not ]) ifTrue: [
			hasTabs := true.
			each
				when: IonTabsWillChangeEvent deferSend: #handleTabsWillChange: to: self ;
				when: IonTabsDidChangeEvent deferSend: #handleTabsDidChange: to: self ] ].

	"Mark if the receiver has tabs"
	self classed: #tabs if: hasTabs.

	"Restore any previously selected tabs"
	hasTabs
		ifTrue: [ self selectKeptTabs ].

	"If a model is present, reset the bindings"
	model ifNotNil: [
		self
			removeBindings ;
			addBindings ]
]

{ #category : #private }
CynModelView >> isActiveChildView: anElement [

	"Answer whether the specified element is an active child view.
	A child view in an IonTab which is not selected is NOT considered active.

	Implementation:
	The implementation of child views is based on views being present in the
	receiver's slots."

	| slotName slot tab |

	"Find the slot for the element.
	The slotName can be be nil for the default (unnamed) slot, but that is okay/handled."
	slotName := anElement slot.	
	slot := self slotNamed: slotName.
	slot ifNil: [
		self warnCr: 'ChildView in unknown slot ', slotName printString.
		^ false ].

	"No tabs, so all child views are active"
	self hasTabs
		ifFalse: [ ^ true ].

	tab := slot firstAncestorMatching: IonTab asCssSelector.

	"Child view is outside tab and therefore (always) active"
	tab ifNil: [ ^ true ].

	"Check if IonTab is already connected and initialized (Ionic waits
	for the WebComponent to be connected to the document before initialization).
	If the IonTab is not connected yet, the first tab is assumed to be active
	(and all others not). To check for the first tab, see if there are no
	previous siblings (assuming each IonTab is nicely positioned in IonTabs
	without any additional wrappers)."
	^ tab isConnected
		ifTrue: [ tab active ]
		ifFalse: [ tab previousSibling isNil ]
]

{ #category : #private }
CynModelView >> isEmptyChildSlot: anElement [

	"Answer whether the specified element is an empty slot.

	See #newEmptyChildSlot for the definition of the empty slot."

	^ anElement tagName = #div and: [ anElement isClassed: #empty ]
]

{ #category : #testing }
CynModelView >> isShownInModal [

	"Answer whether the receiver is shown in a Modal view"

	^ self modal isNotNil
]

{ #category : #private }
CynModelView >> keepSelectedTab: aTab [

	| tabs |

	tabs := (aTab firstAncestorMatching: IonTabs asCssSelector)
		ifNil: [ ^ self ].

	selectedTabNames ifNil: [ selectedTabNames := Dictionary new ].

	selectedTabNames at: tabs id put: aTab tab
]

{ #category : #accessing }
CynModelView >> loadingDeleteText [

	"Answer the text to be shown during (longer) delete operation"

	^ #'app.loading.generic.delete' langText
]

{ #category : #accessing }
CynModelView >> loadingReadText [

	"Answer the text to be shown during (longer) read operation"

	^ #'app.loading.generic.read' langText
]

{ #category : #accessing }
CynModelView >> loadingTimeout [

	"Answer the time (in milliseconds) the receiver waits before showing a loading
	message on the #do:whileShowing: operation. Setting this value too low will
	result in a quick succession of a loading message appearing and disappearing."

	^ 750
]

{ #category : #accessing }
CynModelView >> loadingWriteText [

	"Answer the text to be shown during (longer) write operation"

	^ (model isNew
		ifTrue: [ #'app.loading.generic.new' ]
		ifFalse: [ #'app.loading.generic.update' ]) langText
]

{ #category : #accessing }
CynModelView >> modal [

	"Answer the modal of the receiver (or nil if not shown in Modal view)"

	^ self canyonModal
]

{ #category : #accessing }
CynModelView >> modalResult: anObject [

	self page
		modalResult: anObject
]

{ #category : #accessing }
CynModelView >> model [

	^ model
]

{ #category : #accessing }
CynModelView >> model: aModel [

	model = aModel
		ifTrue: [

			"Special case when called the first time on a nil Model (i.e. pages without an explicit Model)"
			childViewDefinitionsBySlotName ifNil: [
				self updateChildViews ].

			^ self ].

	self removeBindings.
	model := aModel.
	self addBindings.

	"Propagate model to child views"
	self updateChildViews
]

{ #category : #'event handling' }
CynModelView >> modelChanged: aPropertyChange [

	"The model of the receiver changed"
]

{ #category : #operations }
CynModelView >> modelDelete [

	model restDelete
]

{ #category : #operations }
CynModelView >> modelRead [

	model restRead
]

{ #category : #operations }
CynModelView >> modelWrite [

	model restWrite
]

{ #category : #view }
CynModelView >> navigateTo: aPageClass withModel: aModel [

	"Navigate to the specified Page Class with the specified Model"

	self page
		navigateTo: aPageClass withModel: aModel
]

{ #category : #private }
CynModelView >> newEmptyChildSlot [

	"Answer a new instance of an empty slot"

	^ (CpHtmlElement newWithTag: #div)
		addClass: #empty ;
		yourself
]

{ #category : #'event handling' }
CynModelView >> openedInModal: aModal [

	"The receiver is opened in an IonModal view.
	Attach any handlers to the receiver which close the Modal view."
]

{ #category : #accessing }
CynModelView >> page [

	"Answer the page of the receiver"

	^ self canyonPage
]

{ #category : #initialization }
CynModelView >> release [

	self removeBindings.

	super release
]

{ #category : #binding }
CynModelView >> removeBindings [

	"Remove any bindings between the model and the receiver"

	bindingSubscriptions ifNil: [ ^ self ].

	bindingSubscriptions do: [ :each |
		each unsubscribe ].

	bindingSubscriptions := nil
]

{ #category : #private }
CynModelView >> selectKeptTabs [

	"Select the previous kept selected tabs"

	| selections |

	selectedTabNames ifNil: [ ^ self ].

	selections := OrderedCollection new.

	"Iterate over the tabs, otherwise we have to search for id AND also check if it is an IonTabs"
	self allTabs do: [ :each |
		each id ifNotNil: [ :tabsId |
			selectedTabNames
				at: tabsId
				ifPresent: [ :tabName |
					"Keep the Promise from the selection"
					selections add: (each select: tabName) ] ] ].

	selections ifEmpty: [ ^ self ].

	"Wait for the selection to complete (to prevent using a tab which is not ready yet)"
	(CpJavaScriptPromise allSettled: selections asArray) await
]

{ #category : #private }
CynModelView >> slotNamed: aString [

	^ self allSlots
		detect: [ :each | (each attributeAt: #name) = aString ]
		ifNone: [ nil ]
]

{ #category : #private }
CynModelView >> tabFromTabChangeEvent: aTabChangeEvent [

	"Answer the tab from the specified event"

	| tabName tabs |

	tabName := aTabChangeEvent tab
		ifNil: [ ^ nil ].
	tabs := aTabChangeEvent currentTarget
		ifNil: [ ^ nil ].

	^ self tabNamed: tabName from: tabs
]

{ #category : #private }
CynModelView >> tabNamed: aString from: aTabs [

	"Answer the tab with the specified name from the specified IonTabs"

	^ (aTabs allDescendantsMatching: IonTab asCssSelector)
		detect: [ :each | each tab = aString ]
		ifNone: [ nil ]
]

{ #category : #'view - customization' }
CynModelView >> title [

	"Answer the title for the receiver.
	Answering nil means no custom title is present/to be used.

	This is mainly useful in Pages (one of my subclasses), but
	can be delegated to their active child view.
	See CynPage >> #updateTitle:"

	^ nil
]

{ #category : #'view - customization' }
CynModelView >> updateAfterNavigate [

	"Update the receiver when being shown (again) after a navigation.
	This might also be after a top page is closed and the receiver is
	part of the new current/top page."
self traceCr: 'Update after in ', self printString.

	self activeChildViewsDo: [ :each |
		each updateAfterNavigate ].

	"Remove the mark that we are navigating, navigation is done"
	self removeClass: #navigating
]

{ #category : #'view - customization' }
CynModelView >> updateBeforeNavigate [

	"Update the receiver just before being shown (again) because of a navigation.
	Be aware the receiver might not be connected to the document yet. If needed
	it can be checked by sending #isConnected"
self traceCr: 'Update before in ', self printString.

	"Mark the receiver we're navigating"
	self addClass: #navigating.

	self activeChildViewsDo: [ :each |
		each updateBeforeNavigate ]
]

{ #category : #private }
CynModelView >> updateChildView: aView atSlotNamed: aString usingDefinition: aModelViewDefinition [

	"Update the existing View at the specified slot using the specified View definition"

	"Check if a View is required or an empty child slot is needed"
	(aModelViewDefinition viewClassForModel: model)
		ifNotNil: [ :viewClass |
			self
				updateChildView: aView
				atSlotNamed: aString
				withViewClass: viewClass
				on: (aModelViewDefinition modelFromModel: model) ]
		ifNil: [
			self
				updateToEmptyChildView: aView
				atSlotNamed: aString ]
]

{ #category : #private }
CynModelView >> updateChildView: aView atSlotNamed: aString withViewClass: aClass on: aModel [

	"Update the existing View in the specified slot with the specified View Class and Model"

	"Check if a View is present"
	aView ifNil: [

		"No View exists, append a new one (opened on the required Model).
		Since child Views are handled one-by-one we know appending a child
		will put it in the right location."
		self appendChild: (aClass on: aModel) atSlotNamed: aString.

		^ self ].

	"Check if the existing View matches the required View Class"
	aView class = aClass
		ifTrue: [
			"A correct View already present, only update the model"
			aView model: aModel ]
		ifFalse: [
			"Replace existing View, because it is incompatible"
			self replaceChild: aView with: (aClass on: aModel) atSlotNamed: aString.

			"Remove any dependencies in the old view"
			aView destroy ]
]

{ #category : #private }
CynModelView >> updateChildViews [

	"Update all the child views based on the receiver's definitions.

	This method is invoked when the receiver might not be connected
	to the document's DOM. IF connection to the DOM is required, please
	use CpConnectedEvent to check for this event and update those parts
	in the appropriate event handler."

	"Cache the child view definitions"
	childViewDefinitionsBySlotName ifNil: [
		childViewDefinitionsBySlotName := Dictionary new.
		self childViewDefinitions do: [ :each |
			childViewDefinitionsBySlotName
				at: each slotName
				ifPresent: [ :definitions | definitions add: each ]
				ifAbsentPut: [ OrderedCollection with: each ] ] ].

	childViewDefinitionsBySlotName keysAndValuesDo: [ :slotName :definitions |
		self updateChildViewsAtSlotNamed: slotName usingDefinitions: definitions ]
]

{ #category : #private }
CynModelView >> updateChildViewsAtSlotNamed: aString usingDefinitions: aCollection [

	"Update the child Views in the specified slot using the specified ModelViewDefinitions"

	| existingViews |

	existingViews := self childrenAtSlotNamed: aString.

	aCollection withIndexDo: [ :each :index |
		"We handle the children one-by-one. At some point not enough existing
		Views might be present. These will be added by the methods invoked."
		self
			updateChildView: (existingViews at: index ifAbsent: [ nil ])
			atSlotNamed: aString
			usingDefinition: each ].

	"As a sanity action remove superfluous elements"
	aCollection size + 1 to: existingViews size do: [ :index |
		(existingViews at: index) destroy ]
]

{ #category : #private }
CynModelView >> updateToEmptyChildView: aView atSlotNamed: aString [

	"Update the existing View with an empty child slot"

	"Check if a View is present"
	aView ifNil: [

		"No View exists, append an empty child slot.
		Since child Views are handled one-by-one we know appending a child
		will put it in the right location."
		self appendChild: self newEmptyChildSlot atSlotNamed: aString.

		^ self ].

	"A View exists, check if it is an empty slot (in which case we're done)"
	(self isEmptyChildSlot: aView)
		ifTrue: [ ^ self ].

	"View needs to be replaced with a new empty slot"
	self replaceChild: aView with: self newEmptyChildSlot atSlotNamed: aString.

	"Remove any dependencies in the old view"
	aView destroy
]
