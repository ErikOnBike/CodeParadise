"
I am a PropertyModel View. I am responsible for setting up and tearing down
property bindings between the model and the view. This ensures that my model
and view stay in sync. I will validate the model when the user enters data
into the view. By default validation issues are shown at the appropriate
input field. Before 'committing' these changes I can also validate the model
and show a friendly message to the user about the validation results.
"
Class {
	#name : #CpPropertyModelView,
	#superclass : #CpCanyonModelView,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #binding }
CpPropertyModelView >> addBindings [

	"Add any bindings between the model and the receiver"

	super addBindings.

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

	| labelDict |

	"Create a Dictionary for formatting the label"
	labelDict := Dictionary with: #label -> (model labelAt: aSymbol).

	"Check all constraints"
	model propertyConstraintsAt: aSymbol do: [ :each |

		"Per constraint evaluate all violations. Use the 'long' form with
		the model, since conditional constraints require access to the model.
		Do NOT use #violationsIn:do: here."
		each violationsForProperty: aSymbol in: model do: [ :eachViolation |

			"Add the text representing the violation and format with label"
			aCollection add: (model class text: eachViolation format: labelDict) ] ]
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

{ #category : #actions }
CpPropertyModelView >> showIssue: aString [

	self app
		showAlertTitle: 'FIX ME' message: aString
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
		ifNotEmpty: [
			aCollection size = 1
				ifTrue: [ aCollection first ]
				ifFalse: [
					String streamContents: [ :stream |
						stream nextPutAll: self multipleViolationsIntroText.
						aCollection do: [ :each |
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
