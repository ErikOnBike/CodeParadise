Class {
	#name : #SlCard,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlCard >> borderColor [

	^ self customProperty: #'border-color'
]

{ #category : #'accessing style' }
SlCard >> borderColor: aString [

	self customProperty: #'border-color' put: aString
]

{ #category : #'accessing style' }
SlCard >> borderRadius [

	^ self customProperty: #'border-radius'
]

{ #category : #'accessing style' }
SlCard >> borderRadius: aString [

	self customProperty: #'border-radius' put: aString
]

{ #category : #'accessing style' }
SlCard >> borderWidth [

	^ self customProperty: #'border-width'
]

{ #category : #'accessing style' }
SlCard >> borderWidth: aString [

	self customProperty: #'border-width' put: aString
]

{ #category : #'accessing style' }
SlCard >> padding [

	^ self customProperty: #padding
]

{ #category : #'accessing style' }
SlCard >> padding: aString [

	self customProperty: #padding put: aString
]
