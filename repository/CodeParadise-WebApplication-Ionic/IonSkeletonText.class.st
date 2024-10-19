Class {
	#name : #IonSkeletonText,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSkeletonText >> animated [

	"If 'true', the skeleton text will animate.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonSkeletonText >> animated: aBoolean [

	"If 'true', the skeleton text will animate.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]
