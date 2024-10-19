Class {
	#name : #IonGrid,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonGrid >> fixed [

	"If 'true', the grid will have a fixed width based on the screen size.
	
	Type: boolean"

	^ self propertyAt: #fixed
]

{ #category : #api }
IonGrid >> fixed: aBoolean [

	"If 'true', the grid will have a fixed width based on the screen size.
	
	Type: boolean"

	self propertyAt: #fixed put: aBoolean
]
