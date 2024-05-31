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

	^ self customProperty: #color
]

{ #category : #'accessing style' }
SlDivider >> color: aString [

	self customProperty: #color put: aString
]

{ #category : #'accessing style' }
SlDivider >> spacing [

	^ self customProperty: #spacing
]

{ #category : #'accessing style' }
SlDivider >> spacing: aString [

	self customProperty: #spacing put: aString
]

{ #category : #'accessing style' }
SlDivider >> vertical: aBoolean [

	self propertyAt: #vertical put: aBoolean
]

{ #category : #'accessing style' }
SlDivider >> width [

	^ self customProperty: #width
]

{ #category : #'accessing style' }
SlDivider >> width: aString [

	self customProperty: #width put: aString
]
