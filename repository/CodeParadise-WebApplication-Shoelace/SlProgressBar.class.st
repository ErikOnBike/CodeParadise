Class {
	#name : 'SlProgressBar',
	#superclass : 'SlFormControl',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'evaluating' }
SlProgressBar >> indeterminate [

	^ self propertyAt: #indeterminate
]

{ #category : 'evaluating' }
SlProgressBar >> indeterminate: aBoolean [

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : 'accessing' }
SlProgressBar >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : 'accessing' }
SlProgressBar >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : 'evaluating' }
SlProgressBar >> value [

	^ self propertyAt: #value
]

{ #category : 'evaluating' }
SlProgressBar >> value: anInteger [

	self propertyAt: #value put: anInteger
]
