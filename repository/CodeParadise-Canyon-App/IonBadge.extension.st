Extension { #name : #IonBadge }

{ #category : #'*CodeParadise-Canyon-App' }
IonBadge >> isReadonly [

	^ true
]

{ #category : #'*CodeParadise-Canyon-App' }
IonBadge >> label: aString [

	"The receiver does not have a label, ignore it"
]

{ #category : #'*CodeParadise-Canyon-App' }
IonBadge >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	^ self textContent
]

{ #category : #'*CodeParadise-Canyon-App' }
IonBadge >> valueFromModel: anObject [

	"Convenience method used in binding Elements to a Model"

	| newValue |

	newValue := anObject ifNotNil: [ anObject asString ].

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = newValue
		ifTrue: [ ^ self ].

	"Set new badge value"
	self textContent: newValue.

	"Hide if zero or empty"
	(((self isClassed: #'hide-if-zero') and: [ newValue = '0' ]) or: [ (self isClassed: #'hide-if-empty') and: [ newValue = '' ] ])
		ifTrue: [ self styleAt: #display put: #none ]
		ifFalse: [ self removeStyleAt: #display ]
]
