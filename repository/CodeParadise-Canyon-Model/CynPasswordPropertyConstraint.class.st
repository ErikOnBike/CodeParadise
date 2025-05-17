Class {
	#name : #CynPasswordPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CynPasswordPropertyConstraint >> minimumLength [

	^ self configAt: #minimumLength ifAbsent: [ 8 ]
]

{ #category : #validating }
CynPasswordPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as password"

	| minimumLength |

	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	aString size < (minimumLength := self minimumLength)
		ifTrue: [ ^ aBlock value: (CynTextReference key: #'constraint.password.length' with: minimumLength) ]
]
