Class {
	#name : #FuiButton,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'accessing - colors' }
FuiButton class >> allColors [

	^ #(#primary #secondary #tertiary #positive #negative #orange #yellow #olive #green #teal #blue #violet #purple #pink #brown #grey)
]

{ #category : #'web resources' }
FuiButton class >> template [

	<webResource: #html>

	^ '<button class="ui button"><slot></slot></button>'
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

{ #category : #'event handling' }
FuiButton >> handleClickEvent: aClickEvent [

	"Announce the fact that receiver has been clicked"

	self announce: aClickEvent asAnnouncement
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
