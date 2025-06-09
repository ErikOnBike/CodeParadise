Extension { #name : #IonNote }

{ #category : #'*CodeParadise-Canyon-App' }
IonNote >> isReadonly [

	^ true
]

{ #category : #'*CodeParadise-Canyon-App' }
IonNote >> label: aString [

	"The receiver does not have a label, ignore it"
]

{ #category : #'*CodeParadise-Canyon-App' }
IonNote >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	^ self textContent
]

{ #category : #'*CodeParadise-Canyon-App' }
IonNote >> valueFromModel: anObject [

	"Convenience method used in binding Elements to a Model"

	| newValue |

	newValue := anObject ifNotNil: [ anObject asString ].

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = newValue
		ifFalse: [ self textContent: newValue ]
]
