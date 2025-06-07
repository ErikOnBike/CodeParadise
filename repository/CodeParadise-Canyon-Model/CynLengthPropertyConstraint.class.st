Class {
	#name : #CynLengthPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'min',
		'max'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynLengthPropertyConstraint class >> max: anInteger [

	^ self min: nil max: anInteger
]

{ #category : #'instance creation' }
CynLengthPropertyConstraint class >> min: anInteger [

	^ self min: anInteger max: nil
]

{ #category : #'instance creation' }
CynLengthPropertyConstraint class >> min: minInteger max: maxInteger [

	(minInteger isNil and: [ maxInteger isNil ])
		ifTrue: [ self error: 'Length constraint without actual length' ].
	(minInteger isNotNil and: [ minInteger < 0 ])
		ifTrue: [ self error: 'Length constraint with negative min' ].
	(maxInteger isNotNil and: [ maxInteger < 0 ])
		ifTrue: [ self error: 'Length constraint with negative max' ].
	(minInteger isNotNil and: [ maxInteger isNotNil and: [ minInteger > maxInteger ] ])
		ifTrue: [ self error: 'Length constraint where min is bigger than max' ].

	^ self basicNew
		initializeWithMin: minInteger max: maxInteger ;
		yourself
]

{ #category : #'instance creation' }
CynLengthPropertyConstraint class >> new [

	self errorNewReplacedBy: #min:max:
]

{ #category : #initialization }
CynLengthPropertyConstraint >> initializeWithMin: minInteger max: maxInteger [

	self initialize.

	min := minInteger.
	max := maxInteger
]

{ #category : #testing }
CynLengthPropertyConstraint >> isLength [

	^ true
]

{ #category : #accessing }
CynLengthPropertyConstraint >> max [

	^ max
]

{ #category : #accessing }
CynLengthPropertyConstraint >> min [

	^ min
]

{ #category : #accessing }
CynLengthPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace."

	aString ifNil: [ ^ nil ].

	"Trim and remove control characters (except for linefeed and tab)"
	^ aString trim select: [ :each | each asciiValue >= 32 or: [ each asciiValue between: 9 and: 10 ] ]
]

{ #category : #validating }
CynLengthPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String is within the receiver's length boundaries"

	| size |

	size := aString
		ifNotNil: [ aString size ]
		ifNil: [ 0 ].

	min ifNotNil: [
		size < min
			ifTrue: [
				^ aBlock value: (min = 1
					ifTrue: [ #'constraint.empty' ]
					ifFalse: [
						size = 0
							ifTrue: [ CynTextReference key: #'constraint.length.min.zero' with: min ]
							ifFalse: [ CynTextReference key: #'constraint.length.min' with: min with: size ] ]) ] ].

	 max ifNotNil: [
		size > max
			ifTrue: [ ^ aBlock value: (CynTextReference key: #'constraint.length.max' with: max with: size) ] ]
]
