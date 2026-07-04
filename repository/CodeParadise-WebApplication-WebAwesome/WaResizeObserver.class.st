Class {
	#name : #WaResizeObserver,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaResizeObserver >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaResizeObserver >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaResizeObserver >> disabled [

	"Disables the observer.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaResizeObserver >> disabled: aBoolean [

	"Disables the observer.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]
