Extension { #name : #IonElement }

{ #category : #'*CodeParadise-Canyon-App' }
IonElement >> initializeForModel: aModel property: aSymbol [

	"Initialize the receiver for handling the specified Model and property"
]

{ #category : #'*CodeParadise-Canyon-App' }
IonElement >> isReadonly [

	^ false
]

{ #category : #'*CodeParadise-Canyon-App' }
IonElement >> isTextBasedInput [

	"Answer whether the receiver is a text based input"

	^ false
]
