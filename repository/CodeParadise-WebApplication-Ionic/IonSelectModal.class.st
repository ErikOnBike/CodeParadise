Class {
	#name : #IonSelectModal,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSelectModal >> header [

	"Type: string"

	^ self propertyAt: #header
]

{ #category : #api }
IonSelectModal >> header: aString [

	"Type: string"

	self propertyAt: #header put: aString
]

{ #category : #api }
IonSelectModal >> multiple [

	"Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonSelectModal >> multiple: aBoolean [

	"Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonSelectModal >> options [

	"Type: SelectModalOption[]"

	^ self propertyAt: #options
]

{ #category : #api }
IonSelectModal >> options: anObject [

	"Type: SelectModalOption[]"

	self propertyAt: #options put: anObject
]
