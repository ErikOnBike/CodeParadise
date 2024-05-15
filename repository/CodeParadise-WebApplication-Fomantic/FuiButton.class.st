Class {
	#name : 'FuiButton',
	#superclass : 'FuiElement',
	#category : 'CodeParadise-WebApplication-Fomantic-Elements',
	#package : 'CodeParadise-WebApplication-Fomantic',
	#tag : 'Elements'
}

{ #category : 'accessing - colors' }
FuiButton class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : 'accessing' }
FuiButton class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #(#loading #disabled)
]

{ #category : 'accessing' }
FuiButton class >> allVariations [

	^ #(#primary #secundary #tertiary #mini #compact)
]

{ #category : 'accessing' }
FuiButton class >> baseElementTagName [

	^ #button
]

{ #category : 'instance creation' }
FuiButton class >> newLabeled: aString [

	^ self new
		textContent: aString ;
		yourself
]

{ #category : 'accessing - variation' }
FuiButton >> beColor: colorSymbol [

	self setVariation: colorSymbol ofVariations: self class allColors
]

{ #category : 'accessing - state' }
FuiButton >> beLoaded [

	self removeState: #loading
]

{ #category : 'accessing - state' }
FuiButton >> beLoading [

	self addState: #loading
]

{ #category : 'accessing - state' }
FuiButton >> disable [

	self addState: #disabled
]

{ #category : 'accessing - state' }
FuiButton >> enable [

	self removeState: #disabled
]

{ #category : 'testing - variation' }
FuiButton >> hasColor: colorSymbol [

	^ self hasVariation: colorSymbol
]

{ #category : 'testing - state' }
FuiButton >> isDisabled [

	^ self isInState: #disabled
]

{ #category : 'testing - state' }
FuiButton >> isEnabled [

	^ self isDisabled not
]

{ #category : 'testing - state' }
FuiButton >> isLoaded [

	^ self isLoading not
]

{ #category : 'testing - state' }
FuiButton >> isLoading [

	^ self isInState: #loading
]

{ #category : 'testing - variation' }
FuiButton >> isPrimary [

	^ self hasColor: #primary
]

{ #category : 'testing - variation' }
FuiButton >> isRegular [

	^ (self isPrimary or: [ self isSecondary or: [ self isTertiary ] ]) not
]

{ #category : 'testing - variation' }
FuiButton >> isSecondary [

	^ self hasColor: #secondary
]

{ #category : 'testing - variation' }
FuiButton >> isTertiary [

	^ self hasColor: #tertiary
]

{ #category : 'accessing' }
FuiButton >> label [

	^ self textContent
]

{ #category : 'accessing' }
FuiButton >> label: aString [

	self textContent: aString
]

{ #category : 'accessing - variation' }
FuiButton >> primary [

	self beColor: #primary
]

{ #category : 'accessing - variation' }
FuiButton >> regular [

	self beColor: nil
]

{ #category : 'accessing - variation' }
FuiButton >> secondary [

	self beColor: #secondary
]

{ #category : 'accessing - variation' }
FuiButton >> tertiary [

	self beColor: #tertiary
]

{ #category : 'events' }
FuiButton >> whenClickedSend: aSelector to: anObject [

	^ self when: CpPrimaryClickEvent send: aSelector to: anObject
]
