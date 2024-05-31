Class {
	#name : #SlDivider,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlDivider >> beNotVertical [

	self vertical: false
]

{ #category : #'accessing style' }
SlDivider >> beVertical [

	self vertical: true
]

{ #category : #'accessing style' }
SlDivider >> color [

	^ self customPropertyAt: #color
]

{ #category : #'accessing style' }
SlDivider >> color: aString [

	self customPropertyAt: #color put: aString
]

{ #category : #'accessing style' }
SlDivider >> spacing [

	^ self customPropertyAt: #spacing
]

{ #category : #'accessing style' }
SlDivider >> spacing: aString [

	self customPropertyAt: #spacing put: aString
]

{ #category : #'accessing style' }
SlDivider >> vertical: aBoolean [

	self propertyAt: #vertical put: aBoolean
]

{ #category : #'accessing style' }
SlDivider >> width [

	^ self customPropertyAt: #width
]

{ #category : #'accessing style' }
SlDivider >> width: aString [

	self customPropertyAt: #width put: aString
]
