Class {
	#name : #Fui2Button,
	#superclass : #Fui2Element,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'accessing - colors' }
Fui2Button class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : #accessing }
Fui2Button class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #(#loading #disabled)
]

{ #category : #'instance creation' }
Fui2Button class >> new [

	^ (self newWithTag: #button)
		attributeAt: #class put: 'ui button' ;
		yourself
]

{ #category : #'instance creation' }
Fui2Button class >> newLabeled: aString [

	^ self new
		textContent: aString ;
		yourself
]

{ #category : #accessing }
Fui2Button class >> type [

	^ #button
]

{ #category : #'accessing - variation' }
Fui2Button >> beColor: colorSymbol [

	self setVariation: colorSymbol ofVariations: self class allColors
]

{ #category : #'accessing - state' }
Fui2Button >> beLoaded [

	self removeState: #loading
]

{ #category : #'accessing - state' }
Fui2Button >> beLoading [

	self addState: #loading
]

{ #category : #'accessing - state' }
Fui2Button >> disable [

	self addState: #disabled
]

{ #category : #'accessing - state' }
Fui2Button >> enable [

	self removeState: #disabled
]

{ #category : #'accessing - variation' }
Fui2Button >> primary [

	self beColor: #primary
]

{ #category : #'accessing - variation' }
Fui2Button >> regular [

	self beColor: nil
]

{ #category : #'accessing - variation' }
Fui2Button >> secondary [

	self beColor: #secondary
]

{ #category : #'accessing - variation' }
Fui2Button >> tertiary [

	self beColor: #tertiary
]
