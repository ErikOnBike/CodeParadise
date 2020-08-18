Class {
	#name : #Fui2Input,
	#superclass : #Fui2Element,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
Fui2Input class >> allActionVariations [

	^ #(#action #'left action')
]

{ #category : #accessing }
Fui2Input class >> allIconVariations [

	^ #(#icon #'left icon')
]

{ #category : #accessing }
Fui2Input class >> allLabelVariations [

	^ #(#labeled #'right labeled')
]

{ #category : #accessing }
Fui2Input class >> allSizeVariations [

	^ #(#mini #small #large #big #huge #massive)
]

{ #category : #accessing }
Fui2Input class >> allStates [

	^ #(#focus #loading #disabled #error)
]

{ #category : #accessing }
Fui2Input class >> allVariations [

	^ #(#icon #'left icon' #labeled #'right labeled' #action #'left action' #transparent #inverted #fluid #mini #small #large #big #huge #massive)
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

{ #category : #'instance creation' }
Fui2Input class >> newTextareaNamed: aSymbol [

	"Answer a new HTML element for the textarea named (aSymbol) with specified label"

	^ (self newWithTag: #div)
		attributeAt: #class put: 'ui input' ;
		appendChild: ((CpHtmlElement newWithTag: #textarea)
			propertyAt: #name put: aSymbol ;
			yourself) ;
		yourself
]

{ #category : #accessing }
Fui2Input class >> type [

	^ #input
]

{ #category : #'accessing - variation' }
Fui2Input >> beFluid [

	self addVariation: #fluid
]

{ #category : #'accessing - state' }
Fui2Input >> beInError [

	self addState: #error
]

{ #category : #'accessing - state' }
Fui2Input >> beInFocus [

	self addState: #focus
]

{ #category : #'accessing - variation' }
Fui2Input >> beInverted [

	self addVariation: #inverted
]

{ #category : #'accessing - state' }
Fui2Input >> beLoaded [

	self removeState: #loading
]

{ #category : #'accessing - state' }
Fui2Input >> beLoading [

	self addState: #loading
]

{ #category : #'accessing - variation' }
Fui2Input >> beNotFluid [

	self removeVariation: #fluid
]

{ #category : #'accessing - state' }
Fui2Input >> beNotInError [

	self removeState: #error
]

{ #category : #'accessing - state' }
Fui2Input >> beNotInFocus [

	self removeState: #focus
]

{ #category : #'accessing - variation' }
Fui2Input >> beNotInverted [

	self removeVariation: #inverted
]

{ #category : #'accessing - variation' }
Fui2Input >> beNotTextarea [

	| textareaElement |

	textareaElement := self firstDescendantMatching: ':scope > textarea'.
	textareaElement ifNil: [ ^ self ].

	self replaceChild: textareaElement with: ((CpHtmlElement newWithTag: #input)
		propertyAt: #type put: #text ;
		propertyAt: #name put: (textareaElement propertyAt: #name) ;
		propertyAt: #value put: (textareaElement propertyAt: #value) ;
		yourself)
]

{ #category : #'accessing - variation' }
Fui2Input >> beNotTransparent [

	self removeVariation: #transparent
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeBig [

	self setVariation: #big ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeHuge [

	self setVariation: #huge ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeLarge [

	self setVariation: #large ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeMassive [

	self setVariation: #massive ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeMini [

	self setVariation: #mini ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beSizeSmall [

	self setVariation: #small ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
Fui2Input >> beTextarea [

	| inputElement |

	inputElement := self firstDescendantMatching: ':scope > input'.
	inputElement ifNil: [ ^ self ].

	self replaceChild: inputElement with: ((CpHtmlElement newWithTag: #textarea)
		propertyAt: #name put: (inputElement propertyAt: #name) ;
		propertyAt: #value put: (inputElement propertyAt: #value) ;
		yourself)
]

{ #category : #'accessing - variation' }
Fui2Input >> beTransparent [

	self addVariation: #transparent
]

{ #category : #'accessing - state' }
Fui2Input >> disable [

	self addState: #disabled
]

{ #category : #'accessing - state' }
Fui2Input >> enable [

	self removeState: #disabled
]

{ #category : #'accessing - variation' }
Fui2Input >> leftAction: newButtonElement [

	| buttonElement |

	newButtonElement
		ifNotNil: [
			buttonElement := self firstDescendantMatching: ':scope > .button'.

			"Only keep descendant as left button element if it has a sibling and that sibling is an input element"
			(buttonElement notNil and: [ buttonElement nextSibling ifNotNil: [ :nextElement | nextElement tag ~= #input ] ifNil: [ true ] ])
				ifTrue: [ buttonElement := nil ].

			"Replace button or create new one"
			buttonElement
				ifNotNil: [ self replaceChild: buttonElement with: newButtonElement ]
				ifNil: [ self insertChild: newButtonElement before: (self firstDescendantMatching: ':scope > input') ].

			"Remove the right button (can't have both)"
			self removeRightAction.
			self setVariation: #'left button' ofVariations: self class allActionVariations ]
		ifNil: [ self removeLeftAction ]
]

{ #category : #'accessing - variation' }
Fui2Input >> leftIcon: aSymbol [

	| iconElement |

	aSymbol
		ifNotNil: [
			iconElement := self firstDescendantMatching: ':scope > .icon'.

			"Only keep descendant as left icon element if it has a sibling and that sibling is an input element"
			(iconElement notNil and: [ iconElement nextSibling ifNotNil: [ :nextElement | nextElement tag ~= #input ] ifNil: [ true ] ])
				ifTrue: [ iconElement := nil ].

			"Change icon value or create new one"
			iconElement
				ifNotNil: [ iconElement attributeAt: #class put: aSymbol, ' icon' ]
				ifNil: [ self insertChild: aSymbol asFomanticIcon before: (self firstDescendantMatching: ':scope > input') ].

			"Remove the right icon (can't have both)"
			self removeRightIcon.
			self setVariation: #'left icon' ofVariations: self class allIconVariations ]
		ifNil: [ self removeLeftIcon ]
]

{ #category : #'accessing - variation' }
Fui2Input >> leftLabel: newLabelElement [

	| labelElement |

	newLabelElement
		ifNotNil: [
			labelElement := self firstDescendantMatching: ':scope > .label'.

			"Only keep descendant as left label element if it has a sibling and that sibling is an input element"
			(labelElement notNil and: [ labelElement nextSibling ifNotNil: [ :nextElement | nextElement tag ~= #input ] ifNil: [ true ] ])
				ifTrue: [ labelElement := nil ].

			"Replace label or create new one"
			labelElement
				ifNotNil: [ self replaceChild: labelElement with: newLabelElement ]
				ifNil: [ self insertChild: newLabelElement before: (self firstDescendantMatching: ':scope > input') ].

			"Remove the right label (can't have both)"
			self removeRightLabel.
			self setVariation: #labeled ofVariations: self class allLabelVariations ]
		ifNil: [ self removeLeftLabel ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeButtons [

	(self allDescendantsMatching: ':scope > .button') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeIcons [

	(self allDescendantsMatching: ':scope > .icon') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeLabels [

	(self allDescendantsMatching: ':scope > .label') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeLeftAction [

	| buttonElement |

	buttonElement := self firstDescendantMatching: ':scope > .button'.

	"Check if left button is found"
	(buttonElement notNil and: [ buttonElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ buttonElement remove ]
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
Fui2Input >> removeLeftLabel [

	| labelElement |

	labelElement := self firstDescendantMatching: ':scope > .label'.

	"Check if left label is found"
	(labelElement notNil and: [ labelElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ labelElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeRightAction [

	(self firstDescendantMatching: ':scope > input ~ .button')
		ifNotNil: [ :buttonElement | buttonElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeRightIcon [

	(self firstDescendantMatching: ':scope > input ~ .icon')
		ifNotNil: [ :iconElement | iconElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> removeRightLabel [

	(self firstDescendantMatching: ':scope > input ~ .label')
		ifNotNil: [ :labelElement | labelElement remove ]
]

{ #category : #'accessing - variation' }
Fui2Input >> rightAction: newButtonElement [

	| buttonElement |

	newButtonElement
		ifNotNil: [
			buttonElement := self firstDescendantMatching: 'input ~ .button'.

			"Replace button or create new one"
			buttonElement
				ifNotNil: [ self replaceChild: buttonElement with: newButtonElement ]
				ifNil: [ self appendChild: newButtonElement ].

			"Remove left button (can't have both)"
			self removeLeftAction.
			self setVariation: #button ofVariations: self class allActionVariations ]
		ifNil: [ self removeRightAction ]
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

			"Remove left icon (can't have both)"
			self removeLeftIcon.
			self setVariation: #icon ofVariations: self class allIconVariations ]
		ifNil: [ self removeRightIcon ]
]

{ #category : #'accessing - variation' }
Fui2Input >> rightLabel: newRightLabel [

	| labelElement |

	newRightLabel
		ifNotNil: [
			labelElement := self firstDescendantMatching: 'input ~ .label'.

			"Replace label or create new one"
			labelElement
				ifNotNil: [ self replaceChild: labelElement with: newRightLabel ]
				ifNil: [ self appendChild: newRightLabel ].

			"Remove left label (can't have both)"
			self removeLeftLabel.
			self setVariation: #'right labeled' ofVariations: self class allLabelVariations ]
		ifNil: [ self removeRightLabel ]
]
