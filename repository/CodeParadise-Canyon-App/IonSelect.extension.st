Extension { #name : #IonSelect }

{ #category : #'*CodeParadise-Canyon-App' }
IonSelect >> initializeForModel: aModel property: aSymbol [

	"Initialize the receiver for handling the specified Model and property.
	Assume the receiver has a selection constraint."

	| selection |

	super initializeForModel: aModel property: aSymbol.

	selection := OrderedDictionary new.

	aModel class propertySelectionConstraintsAt: aSymbol do: [ :each |
		each selection do: [ :value |
			selection at: value put: (aModel labelFor: aSymbol selection: value) ] ].

	self removeChildren.

	selection keysAndValuesDo: [ :value :label |
		self appendChild: (IonSelectOption new
			value: value ;
			textContent: label ;
			yourself) ]
]

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
