Class {
	#name : #CynPhonePropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CynPhonePropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace."

	aString ifNil: [ ^ nil ].

	^ aString trim
]

{ #category : #validating }
CynPhonePropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as phone number"

	| indexOpen indexClose |

	"If empty a single violation is given"
	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	"Validate only single plus allowed at start (followed by a digit)"
	(aString indexOf: $+ startingAt: 2 ifAbsent: [ -1 ]) > 0
		ifTrue: [ ^ aBlock value: #'constraint.phone.format.plus' ].
	(aString first = $+ and: [ aString size = 1 or: [ aString second isDigit not ] ])
		ifTrue: [ ^ aBlock value: #'constraint.phone.format.digits' ].

	"Only parenthesis allowed surrounding numbers"
	indexOpen := indexClose := 0.
	[ indexOpen >= 0 and: [ indexClose >= 0 ] ] whileTrue: [

		"Validate open is after previous close"
		indexOpen := aString indexOf: $( startingAt: indexOpen + 1 ifAbsent: [ -1 ].
		(indexOpen > 0 and: [ indexOpen < indexClose ])
			ifTrue: [ ^ aBlock value: #'constraint.phone.format.parenthesis' ].

		"Validate if at least one parenthesis is found"
		indexClose := aString indexOf: $) startingAt: indexClose + 1 ifAbsent: [ -1 ].
		(indexOpen > 0 or: [ indexClose > 0 ])
			ifTrue: [
				"Parenthesis should come in pairs"
				(indexOpen == -1 or: [ indexClose == -1 ])
					ifTrue: [ ^ aBlock value: #'constraint.phone.format.parenthesis' ].

				"Open should come before the new close (and have space for at least 1 digit)"
				indexOpen + 1 >= indexClose
					ifTrue: [ ^ aBlock value: #'constraint.phone.format.parenthesis' ].
				
				"Between parenthesis only digits"
				indexOpen + 1 to: indexClose - 1 do: [ :index |
					(aString at: index) isDigit
						ifFalse: [ ^ aBlock value: #'constraint.phone.format.parenthesis' ] ] ] ].

	"Separators only between digits (reuse temp indexOpen)"
	'-.' do: [ :each |
		indexOpen := 0.
		[ indexOpen >= 0 ] whileTrue: [
			indexOpen := aString indexOf: each startingAt: indexOpen + 1 ifAbsent: [ -1 ].
			indexOpen > 0
				ifTrue: [
					(indexOpen = 1 or: [ indexOpen = aString size or: [ ((aString at: indexOpen - 1) isDigit and: [ (aString at: indexOpen + 1) isDigit ]) not ] ])
						ifTrue: [ ^ aBlock value: #'constraint.phone.format.separators' ] ] ] ].

	"At least one digit"
	(aString findFirst: [ :each | each isDigit ]) = 0
		ifTrue: [ ^ aBlock value: #'constraint.phone.format.digits' ]
]
