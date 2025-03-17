Class {
	#name : #CpPropertyModelView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'model',
		'bindingSubscriptions'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'instance creation' }
CpPropertyModelView class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CpPropertyModelView class >> on: aModel [

	^ self basicNew
		initialize ;
		model: aModel ;
		yourself
]

{ #category : #binding }
CpPropertyModelView >> addBinding: aSubscription [

	"Add the subscription to the Collection of known bindings"

	bindingSubscriptions ifNil: [ bindingSubscriptions := OrderedCollection new ].

	bindingSubscriptions
		add: aSubscription
]

{ #category : #binding }
CpPropertyModelView >> addBindings [

	"Add any bindings between the model and the receiver"

	model ifNil: [ ^ self ].

	self addBinding: (model when: CpPropertyChanged send: #modelChanged: to: self).

	self addPropertyBindings
]

{ #category : #binding }
CpPropertyModelView >> addPropertyBindings [

	"Add any property bindings between the model and the receiver"

	self boundProperties do: [ :each |
		self bindProperty: each ]
]

{ #category : #'validating - private' }
CpPropertyModelView >> addViolationsForProperty: aSymbol to: aCollection [

	"Add a collection of Strings representing violation messages for the specified property of
	the receiver's model to the specified Collection.

	Implementation:
	The violation messages have been made specific by adding the respective label of the properties."

	| propertySlot labelDict propertyViolations |

	propertySlot := model propertySlotAt: aSymbol.

	"Create a Dictionary for formatting the label"
	labelDict := Dictionary with: #label -> propertySlot label.

	"Check all constraints"
	propertySlot constraints do: [ :each |

		"Per constraint, retrieve all violations (can be multiple) and format with label"
		propertyViolations := (each violationsForProperty: aSymbol in: self)
			collect: [ :violation | model class text: violation format: labelDict ].

		"Add formatted violations to collection of all violations"
		aCollection addAll: propertyViolations ]
]

{ #category : #accessing }
CpPropertyModelView >> app [

	"Convenience method to access the app (instance)"

	^ CpCanyonAppMainView current
]

{ #category : #binding }
CpPropertyModelView >> bindProperty: aSymbol [

	"Add bindings (2x for two-way) for the specified property.
	Assuming the element which the property is bound to has the
	same identifier as the property name.
	Otherwise use #bindProperty:toElement: directly"

	self bindProperty: aSymbol toElement: (self shadowedElementWithId: aSymbol)
]

{ #category : #binding }
CpPropertyModelView >> bindProperty: aSymbol toElement: anElement [

	"Bind the specified property of the receiver's model to an Element and vice versa (two-way binding).
	Also add binding to normalize the property after an input element has lost focus.
	Keep track of the bindings created, so clean-up can be performed afterwards."

	"Set initial value based on receiver's model"
	anElement valueFromModel: (model propertyAt: aSymbol).

	self addBinding: (model
		when: (CpPropertyChanged name: aSymbol) do: [ :event | anElement valueFromModel: event newValue ] for: self).
	self addBinding: (anElement
		whenChangedDo: [ model propertyAt: aSymbol put: anElement valueForModel ] for: self).

	"When an input element loses focus, perform normalization and validation"
	self addBinding: (anElement
		when: IonBlurEvent
		forkedDo: [
			model normalizePropertyAt: aSymbol.
			self validateProperty: aSymbol ]
		for: self)
]

{ #category : #binding }
CpPropertyModelView >> boundProperties [

	"Answer a collection of property names (Symbols) for the receiver's model,
	which should be bound to the receiver's UI components"

	^ #()
]

{ #category : #operations }
CpPropertyModelView >> do: aBlock whileShowing: aString [

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
CpPropertyModelView >> doDeleteWhileShowing: aString [

	"Delete the receiver's model while showing a message.
	Answer the result of the delete request."

	^ self do: [ model restDelete ] whileShowing: aString
]

{ #category : #operations }
CpPropertyModelView >> doReadWhileShowing: aString [

	"Read the receiver's model while showing a message.
	Answer the result of the read request."

	^ self do: [ model restRead ] whileShowing: aString
]

{ #category : #operations }
CpPropertyModelView >> doWriteWhileShowing: aString [

	"Write the receiver's model while showing a message.
	Answer the result of the write request."

	^ self do: [ model restWrite ] whileShowing: aString
]

{ #category : #initialization }
CpPropertyModelView >> initializeShadowRoot [

	super initializeShadowRoot.

	"If a model is present, reset the bindings"
	model ifNotNil: [
		self
			removeBindings ;
			addBindings ]
]

{ #category : #accessing }
CpPropertyModelView >> loadingTimeout [

	"Answer the time (in milliseconds) the receiver waits before showing a loading
	message on the #do:whileShowing: operation. Setting this value too low will
	result in a quick succession of a loading message appearing and disappearing."

	^ 750
]

{ #category : #accessing }
CpPropertyModelView >> model [

	^ model
]

{ #category : #accessing }
CpPropertyModelView >> model: aModel [

	model = aModel
		ifTrue: [ ^ self ].

	self removeBindings.

	model := aModel.

	self addBindings
]

{ #category : #'event handling' }
CpPropertyModelView >> modelChanged: aPropertyChange [

	"The model of the receiver changed"
]

{ #category : #'validating - private' }
CpPropertyModelView >> modelViolations [

	"Answer a Collection of Strings representing the constraint violations in the properties of the model"

	| violations |

	violations := OrderedCollection new.

	self propertiesForValidation do: [ :each |
		self addViolationsForProperty: each to: violations ].

	^ violations
]

{ #category : #validating }
CpPropertyModelView >> multipleViolationsIntroText [

	"Answer a short introduction text describing the fact that input contains multiple violations"

	^ CpPropertyEntity text: #'constraint.multi.violations'
]

{ #category : #validating }
CpPropertyModelView >> propertiesForValidation [

	"Answer the collection of properties which should be considered during validation of the receiver's model"

	^ self boundProperties
]

{ #category : #initialization }
CpPropertyModelView >> release [

	self removeBindings.

	super release
]

{ #category : #binding }
CpPropertyModelView >> removeBindings [

	"Remove any bindings between the model and the receiver"

	bindingSubscriptions ifNil: [ ^ self ].

	bindingSubscriptions do: [ :each |
		each unsubscribe ].

	bindingSubscriptions := nil
]

{ #category : #actions }
CpPropertyModelView >> showIssue: aString [

	self app
		showAlertTitle: 'FIX ME' message: aString
]

{ #category : #accessing }
CpPropertyModelView >> title [

	"Answer the title for the receiver"

	^ nil
]

{ #category : #actions }
CpPropertyModelView >> updateAfterNavigate [

	"Update the receiver after a navigation has been performed"
]

{ #category : #validating }
CpPropertyModelView >> validateModel [

	"Validate the receiver's Model"

	self validateModelIfValid: [ "Do nothing" ]
]

{ #category : #validating }
CpPropertyModelView >> validateModelIfValid: aBlock [

	"Validate the receiver's Model.
	If there are issues, show them.
	Otherwise (if valid) evaluate the specified block."

	self validationMessage
		ifNotNil: [ :message | self showIssue: message ]
		ifNil: [ aBlock value ]
]

{ #category : #validating }
CpPropertyModelView >> validateProperty: aSymbol [

	"Validate the specified Property of the receiver's Model"

	self validateProperty: aSymbol ifValid: [ "Do nothing" ]
]

{ #category : #validating }
CpPropertyModelView >> validateProperty: aSymbol ifValid: aBlock [

	"Validate the specified Property of the receiver's Model.
	If there are issues, show them.
	Otherwise (if valid) evaluate the specified block."

	(self validationMessageForProperty: aSymbol)
		ifNotNil: [ :message | self app showToast: message ]
		ifNil: [ aBlock value ]
]

{ #category : #validating }
CpPropertyModelView >> validationMessage [

	"Answer a single String representing the validation issue(s) found for the receiver's model
	or nil if the model is valid.
	By default only the model's constraint violations are considered."

	^ self validationMessageFrom: self modelViolations
]

{ #category : #validating }
CpPropertyModelView >> validationMessageForProperty: aSymbol [

	"Answer a single String representing the validation issue(s) found for the specified property
	of the receiver's model or nil if the property's value is valid.
	By default only the property's constraint violations are considered."

	^ self validationMessageFrom: (self violationsForProperty: aSymbol)
]

{ #category : #'validating - private' }
CpPropertyModelView >> validationMessageFrom: aCollection [

	"Answer a single String representing the validation issue(s) specified in the Collection
	or nil if no issues are present"

	^ aCollection
		ifNotEmpty: [ :violations |
			violations size = 1
				ifTrue: [ violations first ]
				ifFalse: [
					String streamContents: [ :stream |
						stream nextPutAll: self multipleViolationsIntroText.
						violations do: [ :each |
							stream
								space ;
								nextPutAll: each ] ] ] ]
		ifEmpty: [ nil ]
]

{ #category : #'validating - private' }
CpPropertyModelView >> violationsForProperty: aSymbol [

	"Answer a Collection of Strings representing the constraint violations in the specified property of the model"

	| violations |

	violations := OrderedCollection new.
	self addViolationsForProperty: aSymbol to: violations.

	^ violations
]
