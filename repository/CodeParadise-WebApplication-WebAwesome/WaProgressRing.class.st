Class {
	#name : #WaProgressRing,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaProgressRing >> label [

	"A custom label for assistive devices.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaProgressRing >> label: aString [

	"A custom label for assistive devices.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaProgressRing >> value [

	"The current progress as a percentage, 0 to 100.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaProgressRing >> value: aNumber [

	"The current progress as a percentage, 0 to 100.
	
	Type: Number
	Default: 0"

	self propertyAt: #value put: aNumber
]
