Class {
	#name : #FuiCheckbox,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiCheckbox class >> allStates [

	^ #(#'read-only' #checked #indeterminate #disabled)
]

{ #category : #accessing }
FuiCheckbox class >> allTypes [

	^ #(#slider #toggle #radio)
]

{ #category : #accessing }
FuiCheckbox class >> allVariations [

	^ #(#fitted #inverted)
]

{ #category : #'instance creation' }
FuiCheckbox class >> new [

	"Answer a new HTML element for the checkbox input field"

	^ (self newWithTag: #div)
		attributeAt: #class put: 'ui checkbox' ;
		appendChild: ((CpHtmlElement newWithTag: #input)
			propertyAt: #type put: #checkbox ;
			yourself) ;
		performOnElement: nil ; "No properties"
		yourself
]

{ #category : #'instance creation' }
FuiCheckbox class >> newLabeled: aString [

	"Answer a new HTML element for the checkbox input field with specified label"

	^ self new
		appendChild: ((CpHtmlElement newWithTag: #label)
			textContent: aString ;
			yourself) ;
		yourself
]

{ #category : #'instance creation' }
FuiCheckbox class >> newNamed: aSymbol andLabeled: aString [

	"Answer a new HTML element for the checkbox input field named (aSymbol) with specified label"

	| checkbox |

	checkbox := self newLabeled: aString.
	(checkbox firstDescendantMatching: #input)
		ifNotNil: [ :input | input propertyAt: #name put: aSymbol ].

	^ checkbox
]

{ #category : #accessing }
FuiCheckbox class >> type [

	^ #checkbox
]

{ #category : #'accessing - state' }
FuiCheckbox >> beDeterminate [

	^ self performOnElement: 'set determinate'
]

{ #category : #'accessing - variation' }
FuiCheckbox >> beFitted [

	self addVariation: #fitted
]

{ #category : #'accessing - state' }
FuiCheckbox >> beIndeterminate [

	^ self performOnElement: 'set indeterminate'
]

{ #category : #'accessing - variation' }
FuiCheckbox >> beInverted [

	self addVariation: #inverted
]

{ #category : #'accessing - variation' }
FuiCheckbox >> beNotFitted [

	self removeVariation: #fitted
]

{ #category : #'accessing - variation' }
FuiCheckbox >> beNotInverted [

	self removeVariation: #inverted
]

{ #category : #'accessing - types' }
FuiCheckbox >> beRadio [

	self setType: #radio ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #radio
]

{ #category : #'accessing - state' }
FuiCheckbox >> beReadOnly [

	^ self addState: #'read-only'
]

{ #category : #'accessing - state' }
FuiCheckbox >> beReadWrite [

	^ self removeState: #'read-only'
]

{ #category : #'accessing - types' }
FuiCheckbox >> beRegular [

	^ self setType: nil ofTypes: self class allTypes
]

{ #category : #'accessing - types' }
FuiCheckbox >> beSlider [

	self setType: #slider ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]

{ #category : #'accessing - types' }
FuiCheckbox >> beToggle [

	self setType: #toggle ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]

{ #category : #'accessing - state' }
FuiCheckbox >> check [

	^ self performOnElement: 'set checked'
]

{ #category : #'accessing - state' }
FuiCheckbox >> disable [

	^ self performOnElement: 'set disabled'
]

{ #category : #'accessing - state' }
FuiCheckbox >> enable [

	^ self performOnElement: 'set enabled'
]

{ #category : #'accessing - state' }
FuiCheckbox >> uncheck [

	^ self performOnElement: 'set unchecked'
]

{ #category : #events }
FuiCheckbox >> whenChangedSend: aSelector to: anObject [

	^ (self firstDescendantMatching: #input)
		when: CpChangeEvent send: aSelector to: anObject
]
