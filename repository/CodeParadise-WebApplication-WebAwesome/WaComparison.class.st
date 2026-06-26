Class {
	#name : #WaComparison,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

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
