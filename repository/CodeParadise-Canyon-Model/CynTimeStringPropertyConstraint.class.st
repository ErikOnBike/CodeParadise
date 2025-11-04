Class {
	#name : #CynTimeStringPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #validating }
CynTimeStringPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as time"

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	(CpJavaScriptDate fromString: '2025-01-01T', aString)
		ifNotNil: [ :date |
			(date timeString = aString or: [ date shortTimeString = aString ])
				ifFalse: [ ^ aBlock value: #'constraint.time.content' ] ]
		ifNil: [ ^ aBlock value: #'constraint.time.format' ]
]
