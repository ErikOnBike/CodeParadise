Class {
	#name : #IonInput,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #evaluating }
IonInput >> value [

	^ self propertyAt: #value
]

{ #category : #evaluating }
IonInput >> value: aString [

	self propertyAt: #value put: aString
]
