Extension { #name : #IonSelect }

{ #category : #'*CodeParadise-Canyon-App' }
IonSelect >> initializeForModel: aModel property: aSymbol [

	"Initialize the receiver for handling the specified Model and property.
	Assume the receiver has a selection constraint."

	| selection |

	super initializeForModel: aModel property: aSymbol.

	self cancelText: #'app.cancel' langText.

	selection := OrderedDictionary new.

	aModel class possibleValuesFromPropertyConstraintsAt: aSymbol do: [ :each |
		selection at: each put: (aModel labelFor: aSymbol selection: each) ].

	self makeEmpty.

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
