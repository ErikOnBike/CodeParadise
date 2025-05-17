Class {
	#name : #CynTokenPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CynTokenPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace and lowercase (just in case ;-)."

	aString ifNil: [ ^ nil ].

	^ aString trim asLowercase
]

{ #category : #validating }
CynTokenPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as token"

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	aString size = 32
		ifFalse: [ ^ aBlock value: #'constraint.token.length' ].

	(aString allSatisfy: [ :each | each isDigit or: [ each asciiValue between: 97 and: 102 ] ])
		ifFalse: [ ^ aBlock value: #'constraint.token.content' ]
]
