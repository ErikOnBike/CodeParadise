Class {
	#name : #FuiButton,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #'web resources' }
FuiButton class >> style [

	<webResource: #css>

	^ '@import "https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css";'
]

{ #category : #'web resources' }
FuiButton class >> template [

	<webResource: #html>

	^ '<button class="ui button"><slot></slot></button>'
]

{ #category : #initialization }
FuiButton >> beColor: colorSymbol [

	| classAttribute allClassValues allColorSymbols |

	classAttribute := self shadowElement attributeAt: #class.
	allClassValues := classAttribute findTokens: ' 	'.
	allColorSymbols := self class allColors.

	"Select all non colors or the specified color"
	allClassValues := allClassValues select: [ :each | (allColorSymbols includes: each asSymbol) not ].
	allClassValues add: colorSymbol.

	self flag: #todo.	"No flatten or join method in tiny image yet"
	"Flatten class values"
	self shadowElement attributeAt: #class put: (String streamContents: [ :stream |
		allClassValues do: [ :each |
			stream position > 0
				ifTrue: [ stream nextPut: Character space ].
			stream nextPutAll: each ] ])
]

{ #category : #protocol }
FuiButton >> beLoaded [

	^ self shadowElement removeClass: #loading
]

{ #category : #protocol }
FuiButton >> beLoading [

	^ self shadowElement addClass: #loading
]

{ #category : #protocol }
FuiButton >> disable [

	^ self shadowElement addClass: #disabled
]

{ #category : #protocol }
FuiButton >> enable [

	^ self shadowElement removeClass: #disabled
]

{ #category : #'event handling' }
FuiButton >> handleClickEvent: aClickEvent [

	"Announce the fact that receiver has been clicked"

	self announce: aClickEvent asAnnouncement
]

{ #category : #'as yet unclassified' }
FuiButton >> primary [

	self beColor: #primary
]
