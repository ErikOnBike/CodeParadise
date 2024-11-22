"
I am a PropertyConstraint, a special kind of PropertyDefinition.
I can validate whether a value matches (my rules) and I can answer
which violations (Collection of Strings) a value has.
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
	#name : #CpPropertyConstraint,
	#superclass : #CpPropertyDefinition,
	#category : #'CodeParadise-Model-Property'
}

{ #category : #accessing }
CpPropertyConstraint >> collectViolationsIn: anObject [

	"Answer a Collection of Strings or a single String representing violations in the specified value.
	If answering a single String it is assumed a single violation is encountered."

	^ #()
]

{ #category : #testing }
CpPropertyConstraint >> isPropertyConstraint [

	^ true
]

{ #category : #accessing }
CpPropertyConstraint >> isValid: anObject [

	"Answer whether the specified value is valid in the receiver.
	The specified value is normalized before validation."

	^ (self violationsIn: anObject) isEmpty
]

{ #category : #accessing }
CpPropertyConstraint >> isValidProperty: aSymbol in: aModel [

	"Answer whether the specified value is valid in the receiver"

	^ self isValid: (aModel propertyAt: aSymbol)
]

{ #category : #accessing }
CpPropertyConstraint >> normalize: anObject [

	"Answer a normalized value for the specified value"

	^ anObject
]

{ #category : #accessing }
CpPropertyConstraint >> normalizeProperty: aSymbol in: aModel [

	"Store a normalized value for the specified value in the specified Object.

	Implementation:
	The PropertyModel will do nothing if the same value is stored 'over' the
	old value (therefore no checks here if old and new value are equal)."

	aModel propertyAt: aSymbol put: (self normalize: (aModel propertyAt: aSymbol))
]

{ #category : #accessing }
CpPropertyConstraint >> violationsForProperty: aSymbol in: aModel [

	"Answer a Collection of Strings representing violations in the specified value"

	^ self violationsIn: (aModel propertyAt: aSymbol)
]

{ #category : #accessing }
CpPropertyConstraint >> violationsIn: anObject [

	"Answer a Collection of Strings representing violations in the specified value.

	Implementation:
	Normalize the value before collecting violations."

	| violations |

	violations := self collectViolationsIn: (self normalize: anObject).
	violations isString
		ifTrue: [ violations := Array with: violations ].

	^ violations
]
