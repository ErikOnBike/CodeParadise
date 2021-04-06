Class {
	#name : #SlFormControl,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing control' }
SlFormControl >> name [

	^ self propertyAt: #name
]

{ #category : #'accessing control' }
SlFormControl >> name: aString [

	self propertyAt: #name put: aString
]

{ #category : #'accessing control' }
SlFormControl >> value [

	^ self propertyAt: #value
]

{ #category : #'accessing control' }
SlFormControl >> value: aString [

	self propertyAt: #value put: aString
]
