Extension { #name : #IonTextarea }

{ #category : #'*CodeParadise-Canyon-App' }
IonTextarea >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	^ self value
]

{ #category : #'*CodeParadise-Canyon-App' }
IonTextarea >> valueFromModel: anObject [

	"Convenience method used in binding Elements to a Model"

	| newValue |

	newValue := anObject ifNotNil: [ anObject asString ].

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = newValue
		ifFalse: [ self value: newValue ]
]

{ #category : #'*CodeParadise-Canyon-App' }
IonTextarea >> whenChangedDo: aBlock for: anObject [

	"Convenience method used in binding Elements to a Model"

	^ self when: IonInputEvent do: aBlock for: anObject
]
