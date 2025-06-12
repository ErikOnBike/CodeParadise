"
I represent a Page in the Canyon app.
I am responsible for navigation (to another page or back) and deciding if navigation is possible.
My instances can be bound to a Model to allow a user to interact with it. Typically this is
done in collaboration with a CpPropertyModelView.
When bound, the Model in my instances might need to show non-public information. Therefore my
instances need to be defined explicitly for public use. By default they assume an authenticated
user is required. Making a Page public is done by adding a placeholder method/tag #isPublicTag
(see also method #isPublic).
My instances can have a header and/or footer. It is also possible to use tabs within a page.
When tabs are present, be sure to handle the navigation between tabs within the page itself.
It does not become part of the navigation mechanism between pages.
It is also possible to show a page modal. This can be useful when for example during execution
the user session timed out and the user needs to login first. Showing the login modal allows
the existing page to remain available while the user logs in.

Implementation:
Since Pages are opened using a reference to their class (allowing a centralized mechanism to
create Page instances and connect them to their Model), opening a Page in a Modal view requires
some specific handling. Therefore a few methods (#navigateTo:withModel: and #close) have an
implementation which needs to check which situation is appropriate. Not the cleanest solution,
but works for now.
Also the behavior for supporting tabs could have been put in either a subclass or a trait.
Subclassing would make it more work for users of Canyon to add (application) page specific
behaviour, because then both CynPage and CynTabbedPage would need to be subclassed to add the
(application) specific behavior. Traits would work better, but currently Canyon is Trait-less.
This might change in a future version though.
"
Class {
	#name : #CynPage,
	#superclass : #CynModelView,
	#instVars : [
		'selectedTabNames'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #tags }
CynPage class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CynPage class >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user).
	A page is non-public by default."

	^ false
]

{ #category : #'web resources' }
CynPage class >> style [

	<webResource: #css>

	"This method fully overrides the superclass' implementation.
	Subclasses however should probably call this style and append additional styling."

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	height: 100%;
}'
]

{ #category : #view }
CynPage >> activeChildViewsInTab: aTab do: aBlock [

	"Evaluate the specified Block for all active child views in the specified tab"

	(aTab allDescendantsMatching: #slot) do: [ :eachSlot |
		(self childrenAtSlotNamed: (eachSlot attributeAt: #name)) do: [ :each |
			(self isActiveChildView: each)
				ifTrue: [ aBlock value: each ] ] ]
]

{ #category : #private }
CynPage >> allTabs [

	^ self shadowedAllDescendantsMatching: IonTabs asCssSelector
]

{ #category : #'view - customization' }
CynPage >> canNavigate [

	"Answer whether the receiver allows navigating elsewhere.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	self childViewsDo: [ :each |
		each canNavigate
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'view - customization' }
CynPage >> canNavigateBack [

	"Answer whether the receiver allows navigating back.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	self childViewsDo: [ :each |
		each canNavigateBack
			ifFalse: [ ^ false ] ].

	"We cannot navigate before the root element in a regular page (but always in a Modal)"
	^ self isShownInModal or: [ self hasPreviousPage ]
]

{ #category : #accessing }
CynPage >> canyonPage [

	^ self
]

{ #category : #view }
CynPage >> close [

	"Close the receiver"

	self isShownInModal
		ifTrue: [ self closeModalPage ]
		ifFalse: [ self app closePage: self ]
]

{ #category : #view }
CynPage >> closeAndNavigateTo: aPageClass withModel: aModel [

	"Close the receiver and navigate to the specified Page Class with the specified Model"

	self canNavigate
		ifFalse: [ ^ self ].

	self modal
		ifNotNil: [ :modal |
			self
				close ;
				showPage: aPageClass withModel: aModel inModal: modal ]
		ifNil: [ self app showPage: aPageClass withModel: aModel ]
]

{ #category : #view }
CynPage >> closeModalPage [

	"Close the receiver.
	Assume it is shown in a Modal view and is the active view."

	| modal nav previousPage |

	modal := self modal.
	nav := modal firstChild.
	nav class = IonNav
		ifFalse: [ ^ self ].

	"Can only close the last page"
	nav lastChild = self
		ifFalse: [ ^ self ].

	"Close the page if more pages available, otherwise close the Modal"
	(previousPage := self previousPage)
		ifNotNil: [ previousPage updateBeforeNavigate ].
	nav children size > 1
		ifTrue: [ nav pop await ]
		ifFalse: [
			self modalResult
				ifNotNil: [ :result | (modal dismiss: result role: #confirm) await ]
				ifNil: [ modal dismiss await ] ].
	previousPage ifNotNil: [
		previousPage updateAfterNavigate ]
]

{ #category : #'view - customization' }
CynPage >> documentTitleFrom: aString [

	"Answer the document title (the title shown in the Browser on desktops) based
	on the specified page title. Since mobile apps have limited space, this method
	might add some pre- or postfix for a more meaningful name."

	^ aString
]

{ #category : #'event handling' }
CynPage >> handleTabsDidChange: anEvent [

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
CynPage >> handleTabsWillChange: anEvent [

	"A tab in the receiver is going to change, update the tabs content"

	(self tabFromTabChangeEvent: anEvent) ifNotNil: [ :tab |

		"Only update if not already updating because of navigation"
		(self isClassed: #navigating)
			ifFalse: [
				self activeChildViewsInTab: tab do: [ :each |
					each updateBeforeNavigate ] ] ]
]

{ #category : #testing }
CynPage >> hasPreviousPage [

	^ self previousPage isNotNil
]

{ #category : #testing }
CynPage >> hasTabs [

	"Answer whether the receiver is a tabbed page"

	^ self isClassed: #tabs
]

{ #category : #initialization }
CynPage >> initialize [

	super initialize.

	self classed: #public if: self isPublic
]

{ #category : #initialization }
CynPage >> initializeShadowRoot [

	| hasTabs |

	super initializeShadowRoot.

	"Set event handler on tab changes"
	hasTabs := false.
	self allTabs do: [ :each |

		"Only tabs with an id can be referenced and therefore used here.
		Also check this IonTabs instance is not marked to be ignored."
		(each id isNotNil and: [ (each isClassed: #ignoreTabChanges) not ]) ifTrue: [
			hasTabs := true.
			each
				when: IonTabsWillChangeEvent deferSend: #handleTabsWillChange: to: self ;
				when: IonTabsDidChangeEvent deferSend: #handleTabsDidChange: to: self ] ].

	self classed: #tabs if: hasTabs.

	hasTabs ifFalse: [ ^ self ].

	"Restore any previously selected tabs"
	self selectKeptTabs
]

{ #category : #testing }
CynPage >> isActive [

	"Answer whether the receiver is the current (aka top) page"

	^ self nextSibling isNil
]

{ #category : #private }
CynPage >> isActiveChildView: anElement [

	| slot tab |

	slot := (self slotOfChildView: anElement)
		ifNil: [ ^ false ].

	"If no tabs, then it is (always) active"
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

{ #category : #testing }
CynPage >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user)"

	^ self class isPublic
]

{ #category : #testing }
CynPage >> isWidePreferred [

	"Answer whether the receiver is preferrably shown on a wide screen.
	By default all pages are shown wide in the receiver.
	This is only relevant on wide displays (i.e. laptops or desktops)."

	^ true
]

{ #category : #private }
CynPage >> keepSelectedTab: aTab [

	| tabs |

	tabs := (aTab firstAncestorMatching: IonTabs asCssSelector)
		ifNil: [ ^ self ].

	selectedTabNames ifNil: [ selectedTabNames := Dictionary new ].

	selectedTabNames at: tabs id put: aTab tab
]

{ #category : #accessing }
CynPage >> modalResult [

	"Answer the result of a Modal operation (or nil if no result is set yet).
	This is used to provide a result when the receiver is closed from a Modal."

	^ self propertyAt: #modalResult
]

{ #category : #accessing }
CynPage >> modalResult: anObject [

	"Store the result of a Modal operation.
	This is used to provide a result when the receiver is closed from a Modal."

	self propertyAt: #modalResult put: anObject
]

{ #category : #view }
CynPage >> navigateBack [

	"Navigate to the previous page"

	"Only navigate back from the active page (otherwise #close should have been used)"
	self isActive
		ifFalse: [ ^ self ].

	self canNavigateBack
		ifFalse: [ ^ self ].

	self close
]

{ #category : #view }
CynPage >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page"

	self canNavigate
		ifFalse: [ ^ self ].

	self modal
		ifNotNil: [ :modal | self showPage: aPageClass withModel: aModel inModal: modal ]
		ifNil: [ self app showPage: aPageClass withModel: aModel ]
]

{ #category : #accessing }
CynPage >> previousPage [

	"Answer the page before the receiver (if any)"

	^ self previousSibling
]

{ #category : #accessing }
CynPage >> screenWidth [

	"Answer the screen width setting (as stored in a persistent variable)
	or use default #auto (alternatives are #min and #max)"

	^ (CpClientEnvironment current
			persistentVariableAt: #SCREEN_WIDTH)
				ifNotNil: [ :value | value asSymbol ]
				ifNil: [ #auto ]
]

{ #category : #private }
CynPage >> selectKeptTabs [

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

{ #category : #view }
CynPage >> showPage: aPageClass withModel: aModel inModal: aModal [

	"Show the Model modal in the page Class specified"

	| nav page |

	nav := aModal firstChild.
	nav class = IonNav
		ifFalse: [ ^ self ].

	page := aPageClass on: aModel.

	page updateBeforeNavigate.
	(nav push: page) await.
	page updateAfterNavigate
]

{ #category : #private }
CynPage >> tabFromTabChangeEvent: aTabChangeEvent [

	"Answer the tab from the specified event"

	| tabName tabs |

	tabName := aTabChangeEvent tab
		ifNil: [ ^ nil ].
	tabs := aTabChangeEvent currentTarget
		ifNil: [ ^ nil ].

	^ (tabs allDescendantsMatching: IonTab asCssSelector)
		detect: [ :each | each tab = tabName ]
		ifNone: [ nil ]
]

{ #category : #'view - customization' }
CynPage >> title [

	^ self activeChildView
		ifNotNil: [ :activeChildView | activeChildView title ]
]

{ #category : #'view - customization' }
CynPage >> updateBeforeNavigate [

	"Update the receiver just before being shown (again) because of a navigation.
	Be aware the receiver might not be connected to the document yet. If needed
	it can be checked by sending #isConnected"

	super updateBeforeNavigate.

	self
		updateScreenWidth ;
		updateTitle: self title
]

{ #category : #view }
CynPage >> updateScreenWidth [

	"The receiver can be shown using the full width of the device, always use a minimal (thin)
	display or dynamically decide based on the page's behavior. Three different values are
	possible (and stored in the persistent variable #SCREEN_WIDTH, see method #screenWidth):
		- #min (always show thin display)
		- #max (always show full width)
		- #auto (let page decide based on response from #isWidePreferred)

	It is up to the app to decide how the user can select her preference."

	| screenWidth isWidePreferred |

	screenWidth := self screenWidth.
	isWidePreferred := self isWidePreferred.

	CpHtmlElement documentBody
		classed: #thin if: (screenWidth = #min or: [ screenWidth = #auto and: [ isWidePreferred not ] ])
]

{ #category : #view }
CynPage >> updateTitle: aString [

	"Update the title of the receiver and on desktops the browser title as well.

	Implementation:
	If a nil title is specified or the header title is readonly, use the current
	Page's title as the title to show in the browser title."

	| titleString |

	titleString := aString.

	"Set the title in the header title, if available and not marked 'readonly'"
	self headerTitle ifNotNil: [ :title |

		"Only set the title if it is not marked 'readonly' and an actual title is provided"
		(titleString isNil or: [ title isClassed: #readonly ])
			ifTrue: [ titleString := title textContent ]
			ifFalse: [ title textContent: titleString ] ].

	"Set the title of the page as the browser title (for desktop)"
	CpBrowserDocument current
		title: (self documentTitleFrom: titleString)
]
