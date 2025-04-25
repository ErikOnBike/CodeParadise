Class {
	#name : #CpTokenPropertyConstraint,
	#superclass : #CpDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpTokenPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace and lowercase (just in case ;-)."

	aString ifNil: [ ^ nil ].

	^ aString trim asLowercase
]

{ #category : #validating }
CpTokenPropertyConstraint >> violationsIn: aString do: aBlock [

	"Validate the provided String as token"

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	aString size = 32
		ifFalse: [ ^ aBlock value: #'constraint.token.length' ].

	(aString allSatisfy: [ :each | each isDigit or: [ each asciiValue between: 97 and: 102 ] ])
		ifFalse: [ ^ aBlock value: #'constraint.token.content' ]
]
