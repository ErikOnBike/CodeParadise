"
I am a PropertyConstraint, a special kind of PropertyDefinition.
I can validate whether a value matches (my rules) and I can answer
which violations (Collection of Symbols) a value has.
I also allow value normalization which can be useful to be more
forgiving towards a user providing values for a Property.

By default I do not perform any normalization.

I can normalize the value of a specific Property in a PropertyModel.
This behavior needs to be performed explicitly. Subclasses of the
PropertyModel could make this default behaviour, but be aware that
when a user is entering values as input for a Property there are
moments in which non-normalized/invalid input might be acceptable.
For example trimming whitespace is unhelpful if the user is allowed
to enter spaces 'inside' the value. As soon as the user would add
a single space, it will be removed by the normalization (assuming
every update is directly represented in the Property value, not on
some 'submit' event).

Examples of normalization are:
- trimming whitespace
- upper- or lowercase the input
- remove leading zeros
- replacing date delimiters with standard delimiter

Be careful with removing content, since the user might not be
aware of the change and therefore might not understand or find the
resulting value back again.

"
Class {
	#name : #CynPropertyConstraint,
	#superclass : #CynPropertyDefinition,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #testing }
CynPropertyConstraint >> isConditional [

	^ false
]

{ #category : #testing }
CynPropertyConstraint >> isLength [

	"Answer whether the receiver is a length based constraint"

	^ false
]

{ #category : #testing }
CynPropertyConstraint >> isPropertyConstraint [

	^ true
]

{ #category : #testing }
CynPropertyConstraint >> isSelection [

	^ false
]

{ #category : #testing }
CynPropertyConstraint >> isValidProperty: aSymbol in: aModel [

	"Answer whether the specified value is valid in the receiver"

	self violationsForProperty: aSymbol in: aModel do: [ :each |
		"Ignore the actual violation, we know the property is not valid here"
		^ false ].

	^ true
]

{ #category : #testing }
CynPropertyConstraint >> isValidValue: anObject [

	"Answer whether the specified value is valid in the receiver.
	The specified value is normalized before validation.

	DO NOT use this method on conditional property constraints
	which expect a Model. The condition normally uses the Model
	to decide if the conditional constraints needs to be applied.
	If this condition (a Block) does NOT take a nil model into
	account, calling it will raise an error."

	^ self isValidValue: anObject in: nil
]

{ #category : #testing }
CynPropertyConstraint >> isValidValue: anObject in: aModel [

	"Answer whether the specified value is valid in the model.
	The specified value is normalized before validation."

	self
		violationsForValue: (self normalize: anObject)
		in: aModel
		do: [ :each |
			"Ignore the actual violation, we know the property is not valid here"
			^ false ].

	^ true
]

{ #category : #accessing }
CynPropertyConstraint >> normalize: anObject [

	"Answer a normalized value for the specified value"

	^ anObject
]

{ #category : #accessing }
CynPropertyConstraint >> normalizeProperty: aSymbol in: aModel [

	"Store a normalized value for the specified value in the specified Object.

	Implementation:
	The PropertyModel will do nothing if the same value is stored 'over' the
	old value (therefore no checks here if old and new value are equal)."

	aModel rawAt: aSymbol put: (self normalize: (aModel rawAt: aSymbol))
]

{ #category : #validating }
CynPropertyConstraint >> violationsForProperty: aSymbol in: aModel do: aBlock [

	"Evaluate the specified Block for each violation in the specified value.
	The Block will receive a Symbol or CynTextReference representing the violation."

	self
		violationsForValue: (self normalize: (aModel rawAt: aSymbol))
		in: aModel
		do: [ :violation | aBlock value: violation ]
]

{ #category : #validating }
CynPropertyConstraint >> violationsForValue: anObject in: aModel do: aBlock [

	"Evaluate the specified Block for each violation in the specified value.
	The specified value is assumed to be normalized.
	The Block will receive a Symbol or CynTextReference representing the violation.

	Normally subclasses need to implement this method instead of #violationsForProperty:in:do:
	In many cases the Model can be ignored. For CynConditionalPropertyConstraint it
	is used however to decide if the constraint needs to be applied."

	self subclassResponsibility
]
