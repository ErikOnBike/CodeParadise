Class {
	#name : #CynIdPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #validating }
CynIdPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as token"

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	aString size = 36
		ifFalse: [ ^ aBlock value: #'constraint.id.length' ].

	aString withIndexDo: [ :each :index |
		(#(9 14 19 24) includes: index)
			ifTrue: [
				each = $-
					ifFalse: [ ^ aBlock value: #'constraint.id.dash' ] ]
			ifFalse: [
				(each isDigit or: [ each asciiValue between: 97 and: 102 ])
					ifFalse: [ ^ aBlock value: #'constraint.id.content' ] ] ]
]
