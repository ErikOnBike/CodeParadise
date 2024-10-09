Class {
	#name : #SlTree,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlTree >> selection [

	^ self propertyAt: #selection
]

{ #category : #accessing }
SlTree >> selection: aString [

	"The selection behavior of the tree. Single selection allows only one node to be selected at a time. Multiple displays checkboxes and allows more than one node to be selected. Leaf allows only leaf nodes to be selected."

	self propertyAt: #selection put: aString
]
