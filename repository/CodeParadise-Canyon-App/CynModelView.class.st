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

	aTab children do: [ :each |
		(self isActiveChildView: each)
			ifTrue: [ aBlock value: each ] ]
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

	childViewDefinitionsBySlotName ifNil: [ self traceCr: 'Callled childViews without child definition from ', self printString. self traceCr: thisContext printString. ^ self ].

	childViewDefinitionsBySlotName keysDo: [ :slotName |
		(self childrenAtSlotNamed: slotName) do: [ :each |
			(self isEmptyChildSlot: each)
				ifFalse: [ aBlock value: each ] ] ]
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
CynModelView >> doDeleteWhileShowing: aString [

	"Delete the receiver's model while showing a message.
	Answer the result of the delete request."

	^ self do: [ self modelDelete ] whileShowing: aString
]

{ #category : #operations }
CynModelView >> doReadWhileShowing: aString [

	"Read the receiver's model while showing a message.
	Answer the result of the read request."

	^ self do: [ self modelRead ] whileShowing: aString
]

{ #category : #operations }
CynModelView >> doWriteWhileShowing: aString [

	"Write the receiver's model while showing a message.
	Answer the result of the write request."

	^ self do: [ self modelWrite ] whileShowing: aString
]

{ #category : #'event handling' }
CynModelView >> handleNavigateBack: aClickEvent [

	"Handle the 'back' button click"

	"Prevent default handling"
	aClickEvent
		stopPropagation ;
		preventDefault.

	self page navigateBack
]

{ #category : #'event handling' }
CynModelView >> handleTabsDidChange: anEvent [

	"A tab in the receiver is changed, update the tabs content"

	(self tabFromTabChangeEvent: anEvent) ifNotNil: [ :tab |

		"Store the selected tab"
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

{ #category : #initialization }
CynModelView >> initializeInPage [

	"Perform any page specific initialization.

	Typically event handlers for tools in the toolbar can be installed here using
	#whenClickedOnTool:forkedSend:to: or #whenClickedOnTool:forkedDo:for:

	Notice how both are forked event handlers. Ionic is using a lot of Promises and
	only the forked variant will work here (otherwise you might end up with events
	which will signal an error because the event handler can't (a)wait."
]

{ #category : #initialization }
CynModelView >> initializeShadowRoot [

	super initializeShadowRoot.

	"Make any back button in the receiver work"
	(self shadowedAllDescendantsMatching: IonBackButton asCssSelector) do: [ :each |
		each when: CpClickEvent forkedSend: #handleNavigateBack: to: self ].

	"In case the receiver has tabs, set event handler on tab changes"
	(self shadowedAllDescendantsMatching: IonTabs asCssSelector) do: [ :each |

		"Only tabs with an id can be referenced and therefore used here.
		Also check this IonTabs instance is marked to be ignored."
		(each id isNotNil and: [ (each isClassed: #ignoreTabChanges) not ]) ifTrue: [
			each
				when: IonTabsWillChangeEvent forkedSend: #handleTabsWillChange: to: self ;
				when: IonTabsDidChangeEvent forkedSend: #handleTabsDidChange: to: self ] ].

	"Restore any previously selected tabs"
	self selectKeptTabs.

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

	slotName := anElement slot.	"Might be nil for the default (unnamed) slot"

	slot := (self shadowedAllDescendantsMatching: #slot)
		detect: [ :each | (each attributeAt: #name) = slotName ]
		ifNone: [
			self warnCr: 'ChildView in unknown slot ', slotName printString.
			^ false ].

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

{ #category : #private }
CynModelView >> keepSelectedTab: aTab [

	| tabs |

	tabs := (aTab firstAncestorMatching: IonTabs asCssSelector)
		ifNil: [ ^ self ].

	selectedTabNames ifNil: [ selectedTabNames := Dictionary new ].

	selectedTabNames at: tabs id put: aTab tab
]

{ #category : #accessing }
CynModelView >> loadingTimeout [

	"Answer the time (in milliseconds) the receiver waits before showing a loading
	message on the #do:whileShowing: operation. Setting this value too low will
	result in a quick succession of a loading message appearing and disappearing."

	^ 750
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
CynModelView >> navigateTo: aClass withModel: aModel [

	"Navigate to the specified Page Class with the specified Model"

	self page
		navigateTo: aClass withModel: aModel
]

{ #category : #private }
CynModelView >> newEmptyChildSlot [

	"Answer a new instance of an empty slot"

	^ (CpHtmlElement newWithTag: #div)
		addClass: #empty ;
		yourself
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
	(self shadowedAllDescendantsMatching: IonTabs asCssSelector) do: [ :each |
		each id ifNotNil: [ :tabsId |
			selectedTabNames
				at: tabsId
				ifPresent: [ :tabName |
					"Keep the Promise from the selection"
					selections add: (each select: tabName) ] ] ].

	selections ifEmpty: [ ^ self ].

	"Wait for the selection to complete (to prevent using a tab which is not ready yet)"
	(CpJavaScriptPromise all: selections asArray) await
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
	Answering nil means no custom title is present/to be used."

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
CynModelView >> updateChildViews [

	"Update all the child views based on the receiver's definitions"

	"Cache the child view definitions"
	childViewDefinitionsBySlotName ifNil: [
		childViewDefinitionsBySlotName := Dictionary new.
		self childViewDefinitions do: [ :each |
			childViewDefinitionsBySlotName
				at: each slotName
				ifPresent: [ :definitions | definitions add: each ]
				ifAbsentPut: [ OrderedCollection with: each ] ] ].

	childViewDefinitionsBySlotName keysAndValuesDo: [ :slotName :definitions |
		self updateChildViews: definitions atSlotNamed: slotName ]
]

{ #category : #private }
CynModelView >> updateChildViews: definitions atSlotNamed: aString [

	"Update the child view in the specified slot.

	Implementation:
	This method is a bit more complex than usual, but not too hard if you take
	the time to read it. The reason for this bigger method is to prevent having
	to retrieve child elements repeatedly from DOM."

	| existingViews |

	existingViews := self childrenAtSlotNamed: aString.

	definitions withIndexDo: [ :each :index |

		"Check if a View is required"
		(each viewClassForModel: model)
			ifNotNil: [ :viewClass |

				"Check if the required View is the same as the existing, otherwise replace"
				(existingViews at: index ifAbsent: [ nil ])
					ifNotNil: [ :view |

						"A View exists check if it matches the required View Class"						
						view class = viewClass
							ifTrue: [
								"A correct View already present, only update the model"
								view model: (each modelFromModel: model) ]
							ifFalse: [
								"Replace existing View, because it is incompatible"
								self replaceChild: view with: (viewClass on: (each modelFromModel: model)) atSlotNamed: aString.

								"Remove any dependencies in the old view"
								view destroy ] ]
					ifNil: [

						"No View exists, append a new one (opened on the required Model)"
						self appendChild: (viewClass on: (each modelFromModel: model)) atSlotNamed: aString ] ]
			ifNil: [

				"The required View is empty, ensure an empty slot element is present at the current position"
				(existingViews at: index ifAbsent: [ nil ])
					ifNotNil: [ :view |

						"A View exists, check if it is an empty slot, otherwise replace it"
						(self isEmptyChildSlot: view)
							ifFalse: [
								self replaceChild: view with: self newEmptyChildSlot atSlotNamed: aString.

								"Remove any dependencies in the old view"
								view destroy ] ]
					ifNil: [

						"No View exists, append an empty slot"
						self appendChild: self newEmptyChildSlot atSlotNamed: aString ] ] ].

	"As a sanity action remove superfluous elements"
	definitions size + 1 to: existingViews size do: [ :index |
		(existingViews at: index) destroy ]
]
