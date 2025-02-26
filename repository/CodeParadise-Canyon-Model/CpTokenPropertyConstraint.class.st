Class {
	#name : #CpTokenPropertyConstraint,
	#superclass : #CpDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpTokenPropertyConstraint >> collectViolationsIn: aString [

	"Validate the provided String as token.
	Answer a Collection of Symbols containing the violations
	or a single Symbol representing the overall violation."

	aString isEmptyOrNil
		ifTrue: [ ^ #'constraint.empty' ].

	aString size = 32
		ifFalse: [ ^ #'constraint.token.length' ].

	(aString allSatisfy: [ :each | each isDigit or: [ each asciiValue between: 97 and: 102 ] ])
		ifFalse: [ ^ #'constraint.token.content' ].

	^ #()
]

{ #category : #accessing }
CpTokenPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace and lowercase (just in case ;-)."

	aString ifNil: [ ^ nil ].

	^ aString trim asLowercase
]
