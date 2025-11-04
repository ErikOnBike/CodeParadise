Class {
	#name : #CynDateStringPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #validating }
CynDateStringPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as date"

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	(CpJavaScriptDate fromString: aString)
		ifNotNil: [ :date |
			date dateString = aString
				ifFalse: [ ^ aBlock value: #'constraint.date.content' ] ]
		ifNil: [ ^ aBlock value: #'constraint.date.format' ]
]
