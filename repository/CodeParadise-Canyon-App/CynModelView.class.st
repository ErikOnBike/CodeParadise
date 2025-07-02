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
		'originalModel'
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

	^ '*, *:before, *:after {
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

	self addBinding: (model whenChangedSend: #modelChanged: to: self).

	self addPropertyBindings
]

{ #category : #binding }
CynModelView >> addPropertyBindings [

	"Add any property bindings between the model and the receiver"

	self boundProperties do: [ :each |
		self bindProperty: each ]
]

{ #category : #private }
CynModelView >> allBackButtons [

	^ self shadowedAllDescendantsMatching: IonBackButton asCssSelector
]

{ #category : #accessing }
CynModelView >> app [

	"Convenience method to access the app (instance)"

	^ CynApp current
]

{ #category : #binding }
CynModelView >> bindProperty: aSymbol [

	"Add bindings (2x for two-way) for the specified property.
	Assuming the element which the property is bound to has the
	same identifier as the property name.
	Otherwise use #bindProperty:toElement: directly"

	self bindProperty: aSymbol toElement: (self shadowedElementWithId: aSymbol)
]

{ #category : #binding }
CynModelView >> bindProperty: aSymbol toElement: anElement [

	"Bind the specified property of the receiver's model to an Element and vice versa (two-way binding).
	Also add binding to normalize the property after an input element has lost focus.
	Keep track of the bindings created, so clean-up can be performed afterwards."

	"Initialize the element"
	anElement initializeForModel: model property: aSymbol.

	"Set initial value based on receiver's model"
	anElement valueFromModel: (model propertyAt: aSymbol).

	"Add binding from model to element"
	self addBinding: (model
		when: (CynPropertyChanged name: aSymbol) do: [ :event | anElement valueFromModel: event newValue ] for: self).

	"Done when readonly element"
	anElement isReadonly
		ifTrue: [ ^ self ].

	"Add binding from element to model"
	self addBinding: (anElement
		whenChangedDo: [ model propertyAt: aSymbol put: anElement valueForModel ] for: self).

	"When an input element loses focus, perform normalization and validation"
	self addBinding: (anElement
		when: IonBlurEvent
		deferDo: [
			model normalizePropertyAt: aSymbol.
			self validateProperty: aSymbol ]
		for: self)
]

{ #category : #binding }
CynModelView >> boundProperties [

	"Answer a collection of property names (Symbols) for the receiver's model,
	which should be bound to the receiver's UI components"

	^ #()
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

	These child view definitions are typically used in a TabbedPage where each tab is defined.

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
	
	Be aware: There is no exception handling performed, callers should add any error handling required.

	Implementation:
	The loading message will not be shown until a loading time has passed. This is to
	prevent 'flickering' of a loading message on very short operations.
	The #stopLoading: method is resilient against nil values, so no additional check here.
	Because error handling is being performed before the ensure Block is performed, also
	hide the loading message when an Error is signaled (hiding it twice will do no harm)."

	| timer loading |

	timer := CpGlobalThis
		setTimeout: self loadingTimeout
		thenDo: [ loading := self app showLoading: aString ].

	[
		aBlock ensure: [
			CpGlobalThis clearTimeout: timer.
			self app stopLoading: loading ]

	] on: Error do: [ :error |

		"Hide the loading message"
		CpGlobalThis clearTimeout: timer.
		self app stopLoading: loading.
	
		"Pass the error to the caller"
		error pass
	]
]

{ #category : #operations }
CynModelView >> doDelete [

	(self doDelete: model)
		ifFalse: [ ^ false ].

	self keepResult.

	^ true
]

{ #category : #operations }
CynModelView >> doDelete: aModel [

	"Perform the operation and answer whether the operation performed successfully"

	^ self doDelete: aModel whileShowing: self loadingDeleteText
]

{ #category : #operations }
CynModelView >> doDelete: aModel whileShowing: aString [

	"Delete the specified model while showing a message.
	Answer a Boolean stating the success of the delete operation."

	[
		self do: [ aModel restDelete ] whileShowing: aString
	] on: Error do: [ :error | ^ self handleError: error ].

	^ true
]

{ #category : #operations }
CynModelView >> doOperation: aBlock [

	"Perform the operation and answer whether the operation performed successfully"

	^ self doOperation: aBlock whileShowing: self loadingOperationText
]

{ #category : #operations }
CynModelView >> doOperation: aBlock whileShowing: aString [

	"Perform the operation and answer whether the operation performed successfully"

	[
		self do: aBlock whileShowing: aString.
	] on: Error do: [ :error | ^ self handleError: error ].

	^ true
]

{ #category : #operations }
CynModelView >> doRead [

	^ self doRead: model
]

{ #category : #operations }
CynModelView >> doRead: aModel [

	"Perform the operation and answer whether the operation performed successfully"

	^ self doRead: aModel whileShowing: self loadingReadText
]

{ #category : #operations }
CynModelView >> doRead: aModel whileShowing: aString [

	"Read the specified model while showing a message.
	Answer a Boolean stating the success of the read operation."

	[
		self do: [ aModel restRead ] whileShowing: aString	
	] on: Error do: [ :error | ^ self handleError: error ].

	^ true
]

{ #category : #operations }
CynModelView >> doWrite [

	(self doWrite: model)
		ifFalse: [ ^ false ].

	self keepResult.

	^ true
]

{ #category : #operations }
CynModelView >> doWrite: aModel [

	"Perform the operation and answer whether the operation performed successfully"

	^ self doWrite: aModel whileShowing: self loadingWriteText
]

{ #category : #operations }
CynModelView >> doWrite: aModel whileShowing: aString [

	"Write the specified model while showing a message.
	Answer a Boolean stating the success of the write operation."

	[
		self do: [ aModel restWrite ] whileShowing: aString
	] on: Error do: [ :error | ^ self handleError: error ].

	^ true
]

{ #category : #'event handling' }
CynModelView >> handleError: anError [

	"Handle the specified Error and answer a Boolean stating whether it was handled.

	Subclasses should handle specific errors, all else will be handled by the app."

	^ self app handleUnhandledError: anError
]

{ #category : #'event handling' }
CynModelView >> handleNavigateBack [

	"Handle the 'back' button click"

	self page navigateBack
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
CynModelView >> initialize [

	"Add the Ionic style separately.

	Implementation:
	An issue in Ionic sometimes prevents adding styling correctly.
	See https://github.com/ionic-team/ionic-framework/issues/25100"

	| shadowRoot ionicStyle |

	super initialize.

	ionicStyle := (CpHtmlElement newWithTag: #style)
		textContent: '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");' ;
		yourself.

	(shadowRoot := self shadowRoot) firstChild
		ifNotNil: [ :firstChild | shadowRoot insertChild: ionicStyle before: firstChild ]
		ifNil: [ shadowRoot appendChild: ionicStyle ]
]

{ #category : #initialization }
CynModelView >> initializeShadowRoot [

	super initializeShadowRoot.

	"Make any back button in the receiver work"
	self allBackButtons do: [ :each |
		each
			when: CpClickEvent deferSend: #handleNavigateBack to: self ;
			when: CpClickEvent send: #preventDefault: to: self ].

	"If a model is present, reset the bindings"
	model ifNotNil: [
		self
			removeBindings ;
			addBindings ]
]

{ #category : #private }
CynModelView >> isActiveChildView: anElement [

	"Answer whether the specified element is an active child view"

	^ (self slotOfChildView: anElement) isNotNil
]

{ #category : #testing }
CynModelView >> isDirtyProperty: aSymbol [

	"Answer whether the specified property has changed"

	^ (originalModel propertyAt: aSymbol) ~= (model propertyAt: aSymbol)
]

{ #category : #private }
CynModelView >> isEmptyChildSlot: anElement [

	"Answer whether the specified element is an empty slot.

	See #newEmptyChildSlot for the definition of the empty slot."

	^ anElement tagName = #div and: [ anElement isClassed: #empty ]
]

{ #category : #testing }
CynModelView >> isModelDirty [

	"Answer whether the receiver's model has changed"

	^ originalModel ~= model
]

{ #category : #testing }
CynModelView >> isShownInModal [

	"Answer whether the receiver is shown in a Modal view"

	^ self modal isNotNil
]

{ #category : #operations }
CynModelView >> keepResult [

	"Keep the receiver's result.

	Implementation:
	Merge the copied model into the original (if we worked on a copy) and set it as modal result"

	self workOnCopy
		ifTrue: [ originalModel merge: model ].

	self modalResult: originalModel
]

{ #category : #accessing }
CynModelView >> loadingDeleteText [

	"Answer the text to be shown during (longer) delete operation"

	^ #'app.loading.generic.delete' langText
]

{ #category : #accessing }
CynModelView >> loadingOperationText [

	"Answer the text to be shown during (longer) operation"

	^ #'app.loading.generic.operation' langText
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

	"Keep original model"
	originalModel := aModel.

	"Work with a copy of the specified Model if so requested.
	This allows to recognize changes and prevents updating the 'original' until done."
	self removeBindings.
	model := self workOnCopy
		ifTrue: [ aModel copy ]
		ifFalse: [ aModel ].
	self addBindings.

	"Propagate model to child views"
	self updateChildViews
]

{ #category : #'event handling' }
CynModelView >> modelChanged: aPropertyChange [

	"The model of the receiver changed"
]

{ #category : #'validating - private' }
CynModelView >> modelViolations [

	"Answer a Collection of Strings representing the constraint violations in the properties of the model"

	| violations |

	violations := Dictionary new.

	"Add model violations"
	model modelViolationsDo: [ :violation |
		violations
			at: nil
			ifPresent: [ :collection | collection add: violation ]
			ifAbsentPut: [ OrderedCollection with: violation ] ].

	"Add property violations"
	self propertiesForValidation do: [ :each |
		model propertyViolationsAt: each do: [ :violation |
			violations
				at: each
				ifPresent: [ :collection | collection add: violation ]
				ifAbsentPut: [ OrderedCollection with: violation ] ] ].

	^ violations
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

{ #category : #validating }
CynModelView >> propertiesForValidation [

	"Answer the collection of properties which should be considered during validation of the receiver's model"

	^ self boundProperties
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
CynModelView >> slotOfChildView: anElement [

	"Answer the slot for the specified child view
	(or nil if it is not an actual child view).

	Implementation:
	Find the slot for the element.
	The slotName can be be nil for the default (unnamed) slot, but that is okay/handled."

	| slotName |

	slotName := anElement slot.
	
	^ (self shadowedAllDescendantsMatching: #slot)
		detect: [ :each | (each attributeAt: #name) = slotName ]
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

{ #category : #validating }
CynModelView >> validateModelIfValid: validBlock ifInvalid: invalidBlock [

	"Validate the receiver's Model and evaluate the appropriate Block.
	If the Model is invalid the invalidBlock will be evaluated (culled) with
	a Dictionary. The Dictionary will contain the property name (a Symbol)
	as key and a collection of violation keys (Symbol or CynTextReference)
	specifying the issues encountered for that partical property. If a nil
	key is present, it refers to a collection of violations on the Model which
	is not related to one specific property (like the Model's integrity
	violations).
	If the Model is valid the validBlock is evaluated without parameters.

	Both validBlock and/or invalidBlock can be nil, in which case no evaluation
	is performed for that particular situation. This means that if invalidBlock
	is nil and the receiver's Model is invalid, nothing will happen: there is
	no fallback mechanism in such case to indicate the Model is invalid."

	self modelViolations
		ifNotEmpty: [ :violations |
			invalidBlock ifNil: [ ^ self ].
			invalidBlock cull: violations ]
		ifEmpty: [
			validBlock ifNil: [ ^ self ].
			validBlock value ]
]

{ #category : #validating }
CynModelView >> validateProperty: aSymbol [

	"Validate the specified Property of the receiver's Model and
	update the input element to indicate the validity"

	| errorText |

	errorText := model errorTextForPropertyAt: aSymbol.

	(self shadowedElementWithId: aSymbol)
		errorText: errorText ;
		classed: #'ion-invalid' if: errorText isNotNil ;
		classed: #'ion-valid' if: errorText isNil ;
		classed: #'ion-touched' if: (self isDirtyProperty: aSymbol)
]

{ #category : #testing }
CynModelView >> workOnCopy [

	"Answer whether the receiver should work on a copy of the model.
	Most forms work on a copy, but some views might work on the model directly."

	^ true
]
