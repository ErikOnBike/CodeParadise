Class {
	#name : #SlAbstractPrompter,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlAbstractPrompter >> beHeader [

	self removeAttributeAt: #'no-header'
]

{ #category : #accessing }
SlAbstractPrompter >> beNoHeader [

	self attributeAt: #'no-header' put: 'on'
]

{ #category : #accessing }
SlAbstractPrompter >> hide [ 
	"Show the element"

	self apply: #hide withArguments: #() 
]

{ #category : #accessing }
SlAbstractPrompter >> isOpen [

	^self attributeAt: #open
]

{ #category : #accessing }
SlAbstractPrompter >> label: aString [

	self attributeAt: #label put: aString
]

{ #category : #accessing }
SlAbstractPrompter >> open: aBoolean [
	"Show the element"

	self attributeAt: #open put: aBoolean 
	

]

{ #category : #accessing }
SlAbstractPrompter >> show [ 
	"Show the element"

	self apply: #show withArguments: #()

]
