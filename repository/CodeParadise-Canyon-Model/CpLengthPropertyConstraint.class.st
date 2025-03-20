Class {
	#name : #CpLengthPropertyConstraint,
	#superclass : #CpPropertyConstraint,
	#instVars : [
		'min',
		'max'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #'instance creation' }
CpLengthPropertyConstraint class >> max: anInteger [

	^ self min: nil max: anInteger
]

{ #category : #'instance creation' }
CpLengthPropertyConstraint class >> min: anInteger [

	^ self min: anInteger max: nil
]

{ #category : #'instance creation' }
CpLengthPropertyConstraint class >> min: minInteger max: maxInteger [

	minInteger ifNil: [
		maxInteger ifNil: [
			self error: 'Length constraint without actual length' ] ].

	^ self basicNew
		initializeWithMin: minInteger max: maxInteger ;
		yourself
]

{ #category : #'instance creation' }
CpLengthPropertyConstraint class >> new [

	self errorNewReplacedBy: (' or ' join: { #min: . #max: . #min:max: })
]

{ #category : #accessing }
CpLengthPropertyConstraint >> collectViolationsIn: aString [

	"Validate the provided String as email.
	Answer a Collection of Symbols containing the violations
	or a single Symbol representing the overall violation."

	| size |

	size := (aString ifNil: [ '' ]) size.

	min ifNotNil: [
		size < min
			ifTrue: [
				^ min = 1
					ifTrue: [ #'constraint.empty' ]
					ifFalse: [
						size = 0
							ifTrue: [ CpParamText key: #'constraint.length.min.zero' with: min ]
							ifFalse: [ CpParamText key: #'constraint.length.min' with: min with: size ] ] ] ].

	 max ifNotNil: [
		size > max
			ifTrue: [ ^ CpParamText key: #'constraint.length.max' with: max with: size ] ].

	^ #()
]

{ #category : #initialization }
CpLengthPropertyConstraint >> initializeWithMin: minInteger max: maxInteger [

	self initialize.

	min := minInteger.
	max := maxInteger
]

{ #category : #accessing }
CpLengthPropertyConstraint >> max [

	^ max
]

{ #category : #accessing }
CpLengthPropertyConstraint >> min [

	^ min
]

{ #category : #accessing }
CpLengthPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace."

	aString ifNil: [ ^ nil ].

	"Trim and remove control characters"
	^ aString trim select: [ :each | each asciiValue >= 32 ]
]
