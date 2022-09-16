Class {
	#name : #SlProgressRing,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #evaluating }
SlProgressRing >> value [

	^ self propertyAt: #value
]

{ #category : #evaluating }
SlProgressRing >> value: anInteger [

	self propertyAt: #value put: anInteger
]
