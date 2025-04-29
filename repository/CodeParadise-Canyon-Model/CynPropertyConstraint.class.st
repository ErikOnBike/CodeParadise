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
CynPropertyConstraint >> isPropertyConstraint [

	^ true
]

{ #category : #testing }
CynPropertyConstraint >> isSelection [

	^ false
]

{ #category : #testing }
CynPropertyConstraint >> isValid: anObject [

	"Answer whether the specified value is valid in the receiver.
	The specified value is normalized before validation.

	DO NOT use this method on conditional property constraints,
	since it requires access to the whole model instead of only
	a specific property value. Calling it will raise an error."

	self violationsIn: (self normalize: anObject) do: [ :each |
		"Ignore the actual violation, we know the property is not valid here"
		^ false ].

	^ true
]

{ #category : #testing }
CynPropertyConstraint >> isValidProperty: aSymbol in: aModel [

	"Answer whether the specified value is valid in the receiver"

	self violationsForProperty: aSymbol in: aModel do: [ :each |
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

	aModel propertyAt: aSymbol put: (self normalize: (aModel propertyAt: aSymbol))
]

{ #category : #accessing }
CynPropertyConstraint >> violationsForProperty: aSymbol in: aModel do: aBlock [

	"Evaluate the specified Block for each violation in the specified value.
	The Block will receive a Symbol or CpParamText representing the violation."

	self
		violationsIn: (self normalize: (aModel propertyAt: aSymbol))
		do: [ :violation |
			aBlock value: violation.
			
			"Use self as the result of evaluating this block.
			This allows subclasses to implement #violationsIn:do:
			with code like `^ aBlock value: #error` and still
			answer the receiver."
			self ]
]

{ #category : #validating }
CynPropertyConstraint >> violationsIn: anObject do: aBlock [

	"Evaluate the specified Block for each violation in the specified value.
	The specified value is assumed to be normalized.
	The Block will receive a Symbol or CpParamText representing the violation.

	Normally subclasses need to implement this method instead of #violationsForProperty:in:do:
	The conditional property constraints are an exception."

	self subclassResponsibility
]
