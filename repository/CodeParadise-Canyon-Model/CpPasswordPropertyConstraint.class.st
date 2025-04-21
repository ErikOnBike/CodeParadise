Class {
	#name : #CpPasswordPropertyConstraint,
	#superclass : #CpDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpPasswordPropertyConstraint >> minimumLength [

	^ self configAt: #minimumLength ifAbsent: [ 8 ]
]

{ #category : #accessing }
CpPasswordPropertyConstraint >> violationsIn: aString do: aBlock [

	"Validate the provided String as password"

	| minimumLength |

	aString isEmptyOrNil
		ifTrue: [ ^ aBlock value: #'constraint.empty' ].

	aString size < (minimumLength := self minimumLength)
		ifTrue: [ ^ aBlock value: (CpParamText key: #'constraint.password.length' with: minimumLength) ]
]
