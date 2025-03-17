Extension { #name : #IonSelect }

{ #category : #'*CodeParadise-Canyon-App' }
IonSelect >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	^ self value
]

{ #category : #'*CodeParadise-Canyon-App' }
IonSelect >> valueFromModel: anObject [

	"Convenience method used in binding Elements to a Model"

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = anObject
		ifFalse: [ self value: anObject ]
]

{ #category : #'*CodeParadise-Canyon-App' }
IonSelect >> whenChangedDo: aBlock for: anObject [

	"Convenience method used in binding Elements to a Model"

	^ self when: IonChangeEvent do: aBlock for: anObject
]
