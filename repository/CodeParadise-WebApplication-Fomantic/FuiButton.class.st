Class {
	#name : #FuiButton,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'accessing - colors' }
FuiButton class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : #accessing }
FuiButton class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #(#loading #disabled)
]

{ #category : #'instance creation' }
FuiButton class >> new [

	^ (self newWithTag: #button)
		attributeAt: #class put: 'ui button' ;
		yourself
]

{ #category : #'instance creation' }
FuiButton class >> newLabeled: aString [

	^ self new
		textContent: aString ;
		yourself
]

{ #category : #accessing }
FuiButton class >> type [

	^ #button
]

{ #category : #'accessing - variation' }
FuiButton >> beColor: colorSymbol [

	self setVariation: colorSymbol ofVariations: self class allColors
]

{ #category : #'accessing - state' }
FuiButton >> beLoaded [

	self removeState: #loading
]

{ #category : #'accessing - state' }
FuiButton >> beLoading [

	self addState: #loading
]

{ #category : #'accessing - state' }
FuiButton >> disable [

	self addState: #disabled
]

{ #category : #'accessing - state' }
FuiButton >> enable [

	self removeState: #disabled
]

{ #category : #'accessing - variation' }
FuiButton >> primary [

	self beColor: #primary
]

{ #category : #'accessing - variation' }
FuiButton >> regular [

	self beColor: nil
]

{ #category : #'accessing - variation' }
FuiButton >> secondary [

	self beColor: #secondary
]

{ #category : #'accessing - variation' }
FuiButton >> tertiary [

	self beColor: #tertiary
]

{ #category : #events }
FuiButton >> whenClickedSend: aSelector to: anObject [

	^ self when: CpClickEvent send: aSelector to: anObject
]
