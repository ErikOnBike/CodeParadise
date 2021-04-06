Class {
	#name : #SlButtonGroup,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlButtonGroup >> label [

	^ self attributeAt: #label
]

{ #category : #accessing }
SlButtonGroup >> label: aString [

	self attributeAt: #label put: aString
]
