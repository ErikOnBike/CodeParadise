Class {
	#name : #SlRadioGroup,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #evaluating }
SlRadioGroup >> value [

	"Selected value (a String)"

	^ self propertyAt: #value
]
