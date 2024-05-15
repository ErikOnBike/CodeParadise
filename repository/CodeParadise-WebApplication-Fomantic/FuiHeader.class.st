Class {
	#name : 'FuiHeader',
	#superclass : 'FuiElement',
	#category : 'CodeParadise-WebApplication-Fomantic-Elements',
	#package : 'CodeParadise-WebApplication-Fomantic',
	#tag : 'Elements'
}

{ #category : 'accessing' }
FuiHeader class >> allSizeVariations [

	^ #(#tiny #small #medium #large #huge)
]

{ #category : 'accessing' }
FuiHeader class >> allStates [

	"Answer a collection (of Symbols) representing all states of the receiver"

	^ #(#disabled)
]

{ #category : 'accessing' }
FuiHeader class >> baseElementTagName [

	^ #div
]

{ #category : 'accessing' }
FuiHeader class >> newLabeled: aString [

	^ self new
		textContent: aString ;
		yourself
]

{ #category : 'protocol' }
FuiHeader >> beSizeHuge [

	self setVariation: #huge ofVariations: self class allSizeVariations
]

{ #category : 'protocol' }
FuiHeader >> beSizeLarge [

	self setVariation: #large ofVariations: self class allSizeVariations
]

{ #category : 'protocol' }
FuiHeader >> beSizeMedium [

	self setVariation: #medium ofVariations: self class allSizeVariations
]

{ #category : 'protocol' }
FuiHeader >> beSizeSmall [

	self setVariation: #small ofVariations: self class allSizeVariations
]

{ #category : 'protocol' }
FuiHeader >> beSizeTiny [

	self setVariation: #tiny ofVariations: self class allSizeVariations
]

{ #category : 'protocol' }
FuiHeader >> disable [

	self addState: #disabled
]

{ #category : 'protocol' }
FuiHeader >> enable [

	self removeState: #disabled
]
