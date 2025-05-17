Class {
	#name : #CynListPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#instVars : [
		'elementPropertyConstraint',
		'min',
		'max'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CynListPropertyConstraint class >> new [

	self errorNewReplacedBy: #propertyConstraint:min:max:
]

{ #category : #'instance creation' }
CynListPropertyConstraint class >> propertyConstraint: aPropertyConstraint [

	^ self propertyConstraint: aPropertyConstraint min: nil max: nil
]

{ #category : #'instance creation' }
CynListPropertyConstraint class >> propertyConstraint: aPropertyConstraint max: anInteger [

	^ self propertyConstraint: aPropertyConstraint min: nil max: anInteger
]

{ #category : #'instance creation' }
CynListPropertyConstraint class >> propertyConstraint: aPropertyConstraint min: anInteger [

	^ self propertyConstraint: aPropertyConstraint min: anInteger max: nil
]

{ #category : #'instance creation' }
CynListPropertyConstraint class >> propertyConstraint: aPropertyConstraint min: minInteger max: maxInteger [

	"Answer an instance of the receiver with the specified PropertyConstraint for its children"

	(minInteger isNotNil and: [ minInteger < 0 ])
		ifTrue: [ self error: 'List constraint with negative min' ].
	(maxInteger isNotNil and: [ maxInteger < 0 ])
		ifTrue: [ self error: 'List constraint with negative max' ].
	(minInteger isNotNil and: [ maxInteger isNotNil and: [ minInteger > maxInteger ] ])
		ifTrue: [ self error: 'List constraint where min is bigger than max' ].

	^ self basicNew
		initializeWithPropertyConstraint: aPropertyConstraint min: minInteger max: maxInteger ;
		yourself
]

{ #category : #initialization }
CynListPropertyConstraint >> initializeWithPropertyConstraint: aPropertyConstraint min: minInteger max: maxInteger [

	self initialize.

	elementPropertyConstraint := aPropertyConstraint.
	min := minInteger.
	max := maxInteger
]

{ #category : #validating }
CynListPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String is a list and each element validates against the receiver's elementPropertyConstraint"

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
							ifTrue: [ CynTextReference key: #'constraint.list.min.zero' with: min ]
							ifFalse: [ CynTextReference key: #'constraint.list.min' with: min with: size ] ]) ] ].

	 max ifNotNil: [
		size > max
			ifTrue: [ ^ aBlock value: (CynTextReference key: #'constraint.list.max' with: max with: size) ] ].

	"Done if we checked for size and input is empty"
	aString ifEmptyOrNil: [ ^ self ].

	"Test some special cases"
	(aString beginsWith: ',')
		ifTrue: [ ^ aBlock value: #'constraint.list.separator.begin' ].
	(aString endsWith: ',')
		ifTrue: [ ^ aBlock value: #'constraint.list.separator.end' ].
	(aString includesSubstring: ',,')
		ifTrue: [ ^ aBlock value: #'constraint.list.separator.double' ].

	(aString findTokens: ',') withIndexDo: [ :each :index |
		elementPropertyConstraint violationsForValue: each in: aModel do: [ :violation |
			aBlock value: (CynTextReference key: #'constraint.list.element' format: {
				#index -> index.
				#violation -> violation asTextReference } asDictionary) ] ]
]
