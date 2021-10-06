Class {
	#name : #FuiInput,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiInput class >> allActionVariations [

	^ #(#action #'left action')
]

{ #category : #accessing }
FuiInput class >> allIconVariations [

	^ #(#icon #'left icon')
]

{ #category : #accessing }
FuiInput class >> allLabelVariations [

	^ #(#labeled #'right labeled')
]

{ #category : #accessing }
FuiInput class >> allSizeVariations [

	^ #(#mini #small #large #big #huge #massive)
]

{ #category : #accessing }
FuiInput class >> allStates [

	^ #(#focus #loading #disabled #error)
]

{ #category : #accessing }
FuiInput class >> allVariations [

	^ #(#icon #'left icon' #labeled #'right labeled' #action #'left action' #transparent #inverted #fluid #mini #small #large #big #huge #massive)
]

{ #category : #accessing }
FuiInput class >> baseElementTagName [

	^ #div
]

{ #category : #'instance creation' }
FuiInput class >> new [

	"Answer a new HTML element for the text input field"

	^ super new
		appendChild: ((CpHtmlElement newWithTag: #input)
			propertyAt: #type put: #text ;
			yourself) ;
		yourself
]

{ #category : #'instance creation' }
FuiInput class >> newNamed: aSymbol [

	"Answer a new HTML element for the text input field named (aSymbol)"

	| textInput |

	textInput := self new.
	(textInput firstDescendantMatching: #input)
		ifNotNil: [ :input | input propertyAt: #name put: aSymbol ].

	^ textInput
]

{ #category : #'instance creation' }
FuiInput class >> newTextarea [

	"Answer a new HTML element for the textarea input field"

	^ super new
		appendChild: (CpHtmlElement newWithTag: #textarea) ;
		yourself
]

{ #category : #'instance creation' }
FuiInput class >> newTextareaNamed: aSymbol [

	"Answer a new HTML element for the textarea input field named (aSymbol)"

	| textareaInput |

	textareaInput := self newTextarea.
	(textareaInput firstDescendantMatching: #textarea)
		ifNotNil: [ :textarea | textarea propertyAt: #name put: aSymbol ].

	^ textareaInput
]

{ #category : #'accessing - variation' }
FuiInput >> beFluid [

	self addVariation: #fluid
]

{ #category : #'accessing - state' }
FuiInput >> beInError [

	self addState: #error
]

{ #category : #'accessing - state' }
FuiInput >> beInFocus [

	self addState: #focus
]

{ #category : #'accessing - variation' }
FuiInput >> beInverted [

	self addVariation: #inverted
]

{ #category : #'accessing - state' }
FuiInput >> beLoaded [

	self removeState: #loading
]

{ #category : #'accessing - state' }
FuiInput >> beLoading [

	self addState: #loading
]

{ #category : #'accessing - variation' }
FuiInput >> beNotFluid [

	self removeVariation: #fluid
]

{ #category : #'accessing - state' }
FuiInput >> beNotInError [

	self removeState: #error
]

{ #category : #'accessing - state' }
FuiInput >> beNotInFocus [

	self removeState: #focus
]

{ #category : #'accessing - variation' }
FuiInput >> beNotInverted [

	self removeVariation: #inverted
]

{ #category : #'accessing - variation' }
FuiInput >> beNotTextarea [

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
FuiInput >> beNotTransparent [

	self removeVariation: #transparent
]

{ #category : #'accessing - variation' }
FuiInput >> beReadOnly [ 

	| element |

	element := self firstDescendantMatching: ':scope > input'.
	element ifNil: [ 
		element := self firstDescendantMatching: ':scope > textarea'.
		element ifNil: [ ^ self ] ].

	"Note that I'm setting attribute 'disabled', not 'readonly'. 
	This is a conscious design decision. A disabled input is more intuitive."

	element 
		attributeAt: #disabled put: ''
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeBig [

	self setVariation: #big ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeHuge [

	self setVariation: #huge ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeLarge [

	self setVariation: #large ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeMassive [

	self setVariation: #massive ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeMini [

	self setVariation: #mini ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beSizeSmall [

	self setVariation: #small ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiInput >> beTextarea [

	| inputElement |

	inputElement := self firstDescendantMatching: ':scope > input'.
	inputElement ifNil: [ ^ self ].

	self replaceChild: inputElement with: ((CpHtmlElement newWithTag: #textarea)
		propertyAt: #name put: (inputElement propertyAt: #name) ;
		propertyAt: #value put: (inputElement propertyAt: #value) ;
		yourself)
]

{ #category : #'accessing - variation' }
FuiInput >> beTransparent [

	self addVariation: #transparent
]

{ #category : #'accessing - variation' }
FuiInput >> beWritable [

	| element |

	element := self firstDescendantMatching: ':scope > input'.
	element ifNil: [ 
		element := self firstDescendantMatching: ':scope > textarea'.
		element ifNil: [ ^ self ] ].

	"Note that I'm removing attribute 'disabled', not 'readonly'. 
	This is a conscious design decision. A disabled input is more intuitive.
	See also #beReadOnly"

	element removeAttributeAt: #disabled
]

{ #category : #'accessing - state' }
FuiInput >> disable [

	self addState: #disabled
]

{ #category : #'accessing - state' }
FuiInput >> enable [

	self removeState: #disabled
]

{ #category : #'text input' }
FuiInput >> focus [

	self crTrace: 'Focus on ', (self firstDescendantMatching: #input) printString.
	(self firstDescendantMatching: #input) focus
]

{ #category : #testing }
FuiInput >> isReadOnly [

	| element |

	element := self firstDescendantMatching: ':scope > input'.
	element ifNil: [ 
		element := self firstDescendantMatching: ':scope > textarea'.
		element ifNil: [ ^ self ] ].

	"Note that I'm checking attribute 'disabled', not 'readonly'. 
	This is a conscious design decision. A disabled input is more intuitive."

	^ element hasAttributeAt: #disabled
]

{ #category : #testing }
FuiInput >> isWritable [

	^ self isReadOnly not
]

{ #category : #'accessing - variation' }
FuiInput >> leftAction: newButtonElement [

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
FuiInput >> leftIcon: aSymbol [

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
FuiInput >> leftLabel: newLabelElement [

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
FuiInput >> removeButtons [

	(self allDescendantsMatching: ':scope > .button') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeIcons [

	(self allDescendantsMatching: ':scope > .icon') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeLabels [

	(self allDescendantsMatching: ':scope > .label') do: [ :each | each remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeLeftAction [

	| buttonElement |

	buttonElement := self firstDescendantMatching: ':scope > .button'.

	"Check if left button is found"
	(buttonElement notNil and: [ buttonElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ buttonElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeLeftIcon [

	| iconElement |

	iconElement := self firstDescendantMatching: ':scope > .icon'.

	"Check if left icon is found"
	(iconElement notNil and: [ iconElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ iconElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeLeftLabel [

	| labelElement |

	labelElement := self firstDescendantMatching: ':scope > .label'.

	"Check if left label is found"
	(labelElement notNil and: [ labelElement nextSibling ifNotNil: [ :nextElement | nextElement tag = #input ] ifNil: [ false ] ])
		ifTrue: [ labelElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeRightAction [

	(self firstDescendantMatching: ':scope > input ~ .button')
		ifNotNil: [ :buttonElement | buttonElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeRightIcon [

	(self firstDescendantMatching: ':scope > input ~ .icon')
		ifNotNil: [ :iconElement | iconElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> removeRightLabel [

	(self firstDescendantMatching: ':scope > input ~ .label')
		ifNotNil: [ :labelElement | labelElement remove ]
]

{ #category : #'accessing - variation' }
FuiInput >> rightAction: newButtonElement [

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
FuiInput >> rightIcon: aSymbol [

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
FuiInput >> rightLabel: newRightLabel [

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

{ #category : #accessing }
FuiInput >> value [

	^ (self firstDescendantMatching: #input)
		propertyAt: #value
]

{ #category : #accessing }
FuiInput >> value: aString [

	(self firstDescendantMatching: #input)
		propertyAt: #value put: aString
]

{ #category : #events }
FuiInput >> whenChangedSend: aSelector to: anObject [

	^ (self firstDescendantMatching: #input)
		when: CpChangeEvent send: aSelector to: anObject
]
