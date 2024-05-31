Class {
	#name : #SlCard,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlCard >> borderColor [

	^ self customPropertyAt: #'border-color'
]

{ #category : #'accessing style' }
SlCard >> borderColor: aString [

	self customPropertyAt: #'border-color' put: aString
]

{ #category : #'accessing style' }
SlCard >> borderRadius [

	^ self customPropertyAt: #'border-radius'
]

{ #category : #'accessing style' }
SlCard >> borderRadius: aString [

	self customPropertyAt: #'border-radius' put: aString
]

{ #category : #'accessing style' }
SlCard >> borderWidth [

	^ self customPropertyAt: #'border-width'
]

{ #category : #'accessing style' }
SlCard >> borderWidth: aString [

	self customPropertyAt: #'border-width' put: aString
]

{ #category : #'accessing style' }
SlCard >> padding [

	^ self customPropertyAt: #padding
]

{ #category : #'accessing style' }
SlCard >> padding: aString [

	self customPropertyAt: #padding put: aString
]
