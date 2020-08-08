Class {
	#name : #Fui2Input,
	#superclass : #Fui2Element,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
Fui2Input class >> allIconVariations [

	^ #(#icon #'left icon')
]

{ #category : #'instance creation' }
Fui2Input class >> newNamed: aSymbol [

	"Answer a new HTML element for the input field named (aSymbol) with specified label"

	^ (self newWithTag: #div)
		attributeAt: #class put: 'ui input' ;
		appendChild: ((CpHtmlElement newWithTag: #input)
			propertyAt: #type put: #text ;
			propertyAt: #name put: aSymbol ;
			yourself) ;
		yourself
]

{ #category : #accessing }
Fui2Input class >> type [

	^ #input
]

{ #category : #'accessing - state' }
Fui2Input >> disable [

	^ self addState: #disabled
]

{ #category : #'accessing - state' }
Fui2Input >> enable [

	^ self removeState: #disabled
]

{ #category : #'accessing - variation' }
Fui2Input >> leftIcon: aSymbol [

	| iconElement |

	aSymbol
		ifNotNil: [
			iconElement := self firstDescendantMatching: ':scope > .icon'.

			"Check if left icon is found (it should have a sibling and that sibling should be an input tag)"
			(iconElement notNil and: [ iconElement nextSibling ifNotNil: [ :nextElement | nextElement tag ~= #input ] ifNil: [ true ] ])
				ifTrue: [ iconElement := nil ].

			"Change icon value or create new one"
			iconElement
				ifNotNil: [ iconElement attributeAt: #class put: aSymbol, ' icon' ]
				ifNil: [ self insertChild: aSymbol asFomanticIcon before: (self firstDescendantMatching: ':scope > input') ].
			self removeRightIcon.
			self setVariation: #'left icon' ofVariations: self class allIconVariations ]
		ifNil: [ self removeLeftIcon ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeIcons [

	(self allDescendantsMatching: ':scope > .icon') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeLeftIcon [

	| iconElement |

	iconElement := self firstDescendantMatching: ':scope > .icon'.

	"Check if left icon is found"
	(iconElement notNil and: [ iconElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ iconElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeRightIcon [

	(self firstDescendantMatching: ':scope > input ~ .icon')
		ifNotNil: [ :iconElement | iconElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> rightIcon: aSymbol [

	| iconElement |

	aSymbol
		ifNotNil: [
			iconElement := self firstDescendantMatching: 'input ~ .icon'.

			"Change icon value or create new one"
			iconElement
				ifNotNil: [ iconElement attributeAt: #class put: aSymbol, ' icon' ]
				ifNil: [ self appendChild: aSymbol asFomanticIcon ].
			self removeLeftIcon.
			self setVariation: #icon ofVariations: self class allIconVariations ]
		ifNil: [ self removeRightIcon ]
]
