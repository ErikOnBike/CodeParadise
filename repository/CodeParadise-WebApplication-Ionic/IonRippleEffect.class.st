Class {
	#name : #IonRippleEffect,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRippleEffect >> addRipple: x y: y [

	"Adds the ripple effect to the parent element.
	@param x The horizontal coordinate of where the ripple should start.
	@param y The vertical coordinate of where the ripple should start.
	
	Type: (x: number, y: number) => Promise<() => void>"

	^ self apply: #addRipple withArguments: { x . y } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRippleEffect >> type [

	"Sets the type of ripple-effect:  - 'bounded': the ripple effect expands from the user's click position - 'unbounded': the ripple effect expands from the center of the button and overflows the container.  NOTE: Surfaces for bounded ripples should have the overflow property set to hidden, while surfaces for unbounded ripples should have it set to visible.
	
	Type: 'bounded' | 'unbounded'"

	^ self propertyAt: #type
]

{ #category : #api }
IonRippleEffect >> type: aString [

	"Sets the type of ripple-effect:  - 'bounded': the ripple effect expands from the user's click position - 'unbounded': the ripple effect expands from the center of the button and overflows the container.  NOTE: Surfaces for bounded ripples should have the overflow property set to hidden, while surfaces for unbounded ripples should have it set to visible.
	
	Type: 'bounded' | 'unbounded'"

	self propertyAt: #type put: aString
]
