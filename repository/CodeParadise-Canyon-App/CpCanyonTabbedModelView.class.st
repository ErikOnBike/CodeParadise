"
I am a Model View with tabs. I am responsible for keeping track of my current tab
and keeping the tabs in sync wrt my model. This means by default that all the
(CanyonModel)Views in my tabs will receive the same model as me. If you require a
tab to show some related model, instead of my model, please implement the method
#modelForTab: in your subclass. The ModelView in the tabs is assumed to be the
first (and only) element in the tab. If this is not the case, please implement
#modelViewForTab: in your subclass.
"
Class {
	#name : #CpCanyonTabbedModelView,
	#superclass : #CpPropertyModelView,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'event handling' }
CpCanyonTabbedModelView >> handleTabsWillChange: anEvent [

	"Tab is going to change, update the tabs content"

	"Store the current tab name"
	self selectedTabName: anEvent tab.

	self updateAfterNavigateTab
]

{ #category : #initialization }
CpCanyonTabbedModelView >> initializeInPage [

	super initializeInPage.

	"Initialize the ModelView child elements as well"
	self tabs do: [ :each |
		(self modelViewForTab: each) ifNotNil: [ :modelView |
			modelView initializeInPage ] ]
]

{ #category : #initialization }
CpCanyonTabbedModelView >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedAllDescendantsMatching: IonTabs asCssSelector) do: [ :each |
		each when: IonTabsWillChangeEvent forkedSend: #handleTabsWillChange: to: self ].

	"Restore the previously selected tab (if any)"
	self selectTabNamed: self selectedTabName
]

{ #category : #accessing }
CpCanyonTabbedModelView >> model: aModel [

	super model: aModel.

	"Set the model on the ModelView child elements as well"
	self tabs do: [ :each |
		(self modelViewForTab: each) ifNotNil: [ :modelView |
			modelView model: (self modelForTab: each) ] ]
]

{ #category : #accessing }
CpCanyonTabbedModelView >> modelForTab: anIonTab [

	"Answer the model to be shown in the specified tab.
	By default the same model is shown as the receiver.
	Feel free to override in a subclass ;-)"

	^ model
]

{ #category : #accessing }
CpCanyonTabbedModelView >> modelViewForTab: anIonTab [

	"Answer the ModelView for the specified tab.
	By default the first child is assumed to be the ModelView.
	Feel free to override in a subclass ;-)"

	^ anIonTab firstChild
		ifNotNil: [ :tabContent |
			(tabContent isWebComponent and: [ tabContent isCanyonModelView ])
				ifTrue: [ tabContent ]
				ifFalse: [ nil ] ]
]

{ #category : #view }
CpCanyonTabbedModelView >> selectTabNamed: aString [

	"Select the specified tab"

	aString ifNil: [ ^ self ].

	(self shadowedFirstDescendantMatching: IonTabs asCssSelector) ifNotNil: [ :tabs |
		(tabs select: aString) await ]
]

{ #category : #accessing }
CpCanyonTabbedModelView >> selectedTab [

	"Answer the selected tab or nil if none exists.

	Implementation:
	The selected tab name is kept and it is used explicitly.
	The IonTabs instance can be asked for the selected tab as well,
	but this answers a Promise, so more convenient to use the stored
	value. We require this stored value to allow updating the shadow
	DOM without losing the info (i.e. during development)."

	| tabs currentTabName |

	currentTabName := self selectedTabName
		ifNil: [ self shadowedFirstDescendantMatching: IonTab asCssSelector ].

	"Technically the currentTabName might not be present (i.e. during development)"
	^ (tabs := self tabs)
		detect: [ :each | each tab = currentTabName ]
		ifNone: [
			tabs
				ifNotEmpty: [ tabs first ]
				ifEmpty: [ nil ] ]
]

{ #category : #accessing }
CpCanyonTabbedModelView >> selectedTabName [

	"Answer the selected stored tab name or nil if none is selected yet"

	^ self propertyAt: #selectedTabName
]

{ #category : #accessing }
CpCanyonTabbedModelView >> selectedTabName: aString [

	"Keep track of the selected tab name (to allow the receiver to update its shadow DOM without losing this info)"

	self propertyAt: #selectedTabName put: aString
]

{ #category : #accessing }
CpCanyonTabbedModelView >> tabs [

	"Answer all tabs of the receiver.
	Assuming the receiver does not have nested tabs."

	^ 	self shadowedAllDescendantsMatching: IonTab asCssSelector
]

{ #category : #view }
CpCanyonTabbedModelView >> updateAfterNavigate [

	super updateAfterNavigate.

	self updateAfterNavigateTab
]

{ #category : #view }
CpCanyonTabbedModelView >> updateAfterNavigateTab [

	"Update the current tab"

	self selectedTab ifNotNil: [ :tab |
		(self modelViewForTab: tab) ifNotNil: [ :modelView |
			modelView updateAfterNavigate ] ]
]
