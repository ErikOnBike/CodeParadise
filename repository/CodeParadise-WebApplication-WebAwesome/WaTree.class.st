Class {
	#name : #WaTree,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTree >> selection [

	"The selection behavior of the tree. Single selection allows only one node to be selected at a time. Multiple
	displays checkboxes and allows more than one node to be selected. Leaf allows only leaf nodes to be selected.
	Leaf-multiple allows multiple leaf nodes to be selected while parent nodes only expand and collapse.
	
	Type: String
	Default: 'single'
	Allowed: 'single' | 'multiple' | 'leaf' | 'leaf-multiple'"

	^ self propertyAt: #selection
]

{ #category : #accessing }
WaTree >> selection: aString [

	"The selection behavior of the tree. Single selection allows only one node to be selected at a time. Multiple
	displays checkboxes and allows more than one node to be selected. Leaf allows only leaf nodes to be selected.
	Leaf-multiple allows multiple leaf nodes to be selected while parent nodes only expand and collapse.
	
	Type: String
	Default: 'single'
	Allowed: 'single' | 'multiple' | 'leaf' | 'leaf-multiple'"

	self propertyAt: #selection put: aString
]
