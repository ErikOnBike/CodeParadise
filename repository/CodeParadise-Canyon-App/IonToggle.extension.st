Extension { #name : #IonToggle }

{ #category : #'*CodeParadise-Canyon-App' }
IonToggle >> label [

	"Convenience method for consistent protocol"

	^ self textContent
]

{ #category : #'*CodeParadise-Canyon-App' }
IonToggle >> label: aString [

	"Convenience method for consistent protocol"

	self textContent: aString
]

{ #category : #'*CodeParadise-Canyon-App' }
IonToggle >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	^ self checked
]

{ #category : #'*CodeParadise-Canyon-App' }
IonToggle >> valueFromModel: anObject [

	"Convenience method used in binding Elements to a Model"

	| newValue |

	newValue := anObject ifNil: [ false ].

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = newValue
		ifFalse: [ self checked: newValue ]
]

{ #category : #'*CodeParadise-Canyon-App' }
IonToggle >> whenChangedDo: aBlock for: anObject [

	"Convenience method used in binding Elements to a Model"

	^ self when: IonChangeEvent do: aBlock for: anObject
]
