"
I am a generic Model View. I am responsible for setting up and tearing down
bindings between the model and the view. I know the page I live in and I can
update the page's title when I see necessary. I will be updated after navigation
has occurred.
"
Class {
	#name : #CpCanyonModelView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'model',
		'bindingSubscriptions'
	],
	#classVars : [
		'Mapping'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #accessing }
CpCanyonModelView class >> classForModel: aModel [

	"Answer the most appropriate/specific class for the specified Model"

	^ Mapping at: aModel class ifAbsent: [ nil ]
]

{ #category : #'instance creation' }
CpCanyonModelView class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CpCanyonModelView class >> on: aModel [

	^ self basicNew
		initialize ;
		model: aModel ;
		yourself
]

{ #category : #'class initialization' }
CpCanyonModelView class >> postInstall [

	super postInstall.

	self registerClassMapping
]

{ #category : #'class initialization' }
CpCanyonModelView class >> postInstallOnce [

	Mapping := Dictionary new
]

{ #category : #'class initialization' }
CpCanyonModelView class >> registerClass: aModelClass for: aViewClass [

	Mapping at: aModelClass ifPresent: [ :viewClass |
		self warnCr: 'View class ', viewClass name, ' already registered for handling ', aModelClass name, ', overriding with ', aViewClass name ].

	Mapping at: aModelClass put: aViewClass
]

{ #category : #'class initialization' }
CpCanyonModelView class >> registerClassMapping [

	"Add class mappings to the receiver.
	Subclasses should override but NOT call the super implementation.
	Otherwise additional mappings will be created."
]

{ #category : #'web resources' }
CpCanyonModelView class >> style [

	<webResource: #css>

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host,
:host > :not(style) {
	height: 100%;
}'
]

{ #category : #binding }
CpCanyonModelView >> addBinding: aSubscription [

	"Add the subscription to the Collection of known bindings"

	bindingSubscriptions ifNil: [ bindingSubscriptions := OrderedCollection new ].

	bindingSubscriptions
		add: aSubscription
]

{ #category : #binding }
CpCanyonModelView >> addBindings [

	"Add any bindings between the model and the receiver"

	model ifNil: [ ^ self ].

	self addBinding: (model whenChangedSend: #modelChanged: to: self)
]

{ #category : #accessing }
CpCanyonModelView >> app [

	"Convenience method to access the app (instance)"

	^ CpCanyonAppMainView current
]

{ #category : #testing }
CpCanyonModelView >> canNavigateBack [

	"Answer whether it is allowed to navigating back (away) from the receiver"

	^ true
]

{ #category : #view }
CpCanyonModelView >> closePage [

	self page
		close
]

{ #category : #view }
CpCanyonModelView >> do: aBlock whileShowing: aString [

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

{ #category : #initialization }
CpCanyonModelView >> initializeInPage [

	"Initialize the receiver now it has been placed in a page"
]

{ #category : #initialization }
CpCanyonModelView >> initializeShadowRoot [

	super initializeShadowRoot.

	"If a model is present, reset the bindings"
	model ifNotNil: [
		self
			removeBindings ;
			addBindings ]
]

{ #category : #accessing }
CpCanyonModelView >> loadingTimeout [

	"Answer the time (in milliseconds) the receiver waits before showing a loading
	message on the #do:whileShowing: operation. Setting this value too low will
	result in a quick succession of a loading message appearing and disappearing."

	^ 750
]

{ #category : #accessing }
CpCanyonModelView >> model [

	^ model
]

{ #category : #accessing }
CpCanyonModelView >> model: aModel [

	model = aModel
		ifTrue: [ ^ self ].

	self removeBindings.

	model := aModel.

	self addBindings
]

{ #category : #'event handling' }
CpCanyonModelView >> modelChanged: aPropertyChange [

	"The model of the receiver changed"
]

{ #category : #accessing }
CpCanyonModelView >> page [

	"Answer the page of the receiver"

	| page |

	page := self parent.
	[ page isNotNil ] whileTrue: [
		page isPage
			ifTrue: [ ^ page ].
		page := page parent ].

	^ nil
]

{ #category : #accessing }
CpCanyonModelView >> pageAllDescendantsMatching: aString [

	"Answer all descendants matching the specified CSS selector from the page's (shadow) content"

	^ self page
		ifNotNil: [ :page | page shadowedAllDescendantsMatching: aString ]
		ifNil: [ #() ]
]

{ #category : #accessing }
CpCanyonModelView >> pageElementWithId: aString [

	"Answer the element with the specified id from the page's (shadow) content"

	^ self page ifNotNil: [ :page |
		page shadowedElementWithId: aString ]
]

{ #category : #accessing }
CpCanyonModelView >> pageFirstDescendantMatching: aString [

	"Answer the first descendant matching the specified CSS selector from the page's (shadow) content"

	^ self page ifNotNil: [ :page |
		page shadowedFirstDescendantMatching: aString ]
]

{ #category : #view }
CpCanyonModelView >> pageHideButton: aString if: aBoolean [

	self page ifNotNil: [ :page |
		page hideButton: aString if: aBoolean ]
]

{ #category : #view }
CpCanyonModelView >> pageSetButton: idString label: labelString [

	self page ifNotNil: [ :page |
		page setButton: idString label: labelString ]
]

{ #category : #initialization }
CpCanyonModelView >> release [

	self removeBindings.

	super release
]

{ #category : #binding }
CpCanyonModelView >> removeBindings [

	"Remove any bindings between the model and the receiver"

	bindingSubscriptions ifNil: [ ^ self ].

	bindingSubscriptions do: [ :each |
		each unsubscribe ].

	bindingSubscriptions := nil
]

{ #category : #accessing }
CpCanyonModelView >> title [

	"Answer the title for the receiver"

	^ nil
]

{ #category : #view }
CpCanyonModelView >> updateAfterNavigate [

	"Update the receiver after a navigation has been performed"
]

{ #category : #view }
CpCanyonModelView >> updateBeforeNavigate [

	"Update the receiver just before presenting itself after a navigation has been performed"
]

{ #category : #view }
CpCanyonModelView >> updateTitle [

	"Update the receiver's title"

	self updateTitle: self title
]

{ #category : #view }
CpCanyonModelView >> updateTitle: aString [

	"Update the receiver's title"

	self page
		updateTitle: aString
]
