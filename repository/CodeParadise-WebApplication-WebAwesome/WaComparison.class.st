Class {
	#name : #WaComparison,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - slots' }
WaComparison >> afterElement [

	"The after content, often an `<img>` or `<svg>` element."

	^ self firstChildAtSlotNamed: #after
]

{ #category : #'accessing - slots' }
WaComparison >> afterElement: anElement [

	"The after content, often an `<img>` or `<svg>` element."

	self replaceAllChildrenWith: anElement atSlotNamed: #after
]

{ #category : #'accessing - slots' }
WaComparison >> beforeElement [

	"The before content, often an `<img>` or `<svg>` element."

	^ self firstChildAtSlotNamed: #before
]

{ #category : #'accessing - slots' }
WaComparison >> beforeElement: anElement [

	"The before content, often an `<img>` or `<svg>` element."

	self replaceAllChildrenWith: anElement atSlotNamed: #before
]

{ #category : #'accessing - slots' }
WaComparison >> handleElement [

	"The icon used inside the handle."

	^ self firstChildAtSlotNamed: #handle
]

{ #category : #'accessing - slots' }
WaComparison >> handleElement: anElement [

	"The icon used inside the handle."

	self replaceAllChildrenWith: anElement atSlotNamed: #handle
]

{ #category : #accessing }
WaComparison >> position [

	"The position of the divider as a percentage.
	
	Type: Number
	Default: 50"

	^ self propertyAt: #position
]

{ #category : #accessing }
WaComparison >> position: aNumber [

	"The position of the divider as a percentage.
	
	Type: Number
	Default: 50"

	self propertyAt: #position put: aNumber
]
