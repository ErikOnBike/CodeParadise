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
		ifFalse: [ self textContent: newValue ]
]
