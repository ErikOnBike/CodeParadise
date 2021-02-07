Class {
	#name : #Fui2Checkbox,
	#superclass : #Fui2Element,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
Fui2Checkbox class >> allStates [

	^ #(#'read-only' #checked #indeterminate #disabled)
]

{ #category : #accessing }
Fui2Checkbox class >> allTypes [

	^ #(#slider #toggle #radio)
]

{ #category : #accessing }
Fui2Checkbox class >> allVariations [

	^ #(#fitted #inverted)
]

{ #category : #'instance creation' }
Fui2Checkbox class >> new [

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
Fui2Checkbox class >> newLabeled: aString [

	"Answer a new HTML element for the checkbox input field with specified label"

	^ self new
		appendChild: ((CpHtmlElement newWithTag: #label)
			textContent: aString ;
			yourself) ;
		yourself
]

{ #category : #'instance creation' }
Fui2Checkbox class >> newNamed: aSymbol andLabeled: aString [

	"Answer a new HTML element for the checkbox input field named (aSymbol) with specified label"

	| checkbox |

	checkbox := self newLabeled: aString.
	(checkbox firstDescendantMatching: #input)
		ifNotNil: [ :input | input propertyAt: #name put: aSymbol ].

	^ checkbox
]

{ #category : #accessing }
Fui2Checkbox class >> type [

	^ #checkbox
]

{ #category : #'accessing - state' }
Fui2Checkbox >> beDeterminate [

	^ self performOnElement: 'set determinate'
]

{ #category : #'accessing - variation' }
Fui2Checkbox >> beFitted [

	self addVariation: #fitted
]

{ #category : #'accessing - state' }
Fui2Checkbox >> beIndeterminate [

	^ self performOnElement: 'set indeterminate'
]

{ #category : #'accessing - variation' }
Fui2Checkbox >> beInverted [

	self addVariation: #inverted
]

{ #category : #'accessing - variation' }
Fui2Checkbox >> beNotFitted [

	self removeVariation: #fitted
]

{ #category : #'accessing - variation' }
Fui2Checkbox >> beNotInverted [

	self removeVariation: #inverted
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beRadio [

	self setType: #radio ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #radio
]

{ #category : #'accessing - state' }
Fui2Checkbox >> beReadOnly [

	^ self addState: #'read-only'
]

{ #category : #'accessing - state' }
Fui2Checkbox >> beReadWrite [

	^ self removeState: #'read-only'
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beRegular [

	^ self setType: nil ofTypes: self class allTypes
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beSlider [

	self setType: #slider ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beToggle [

	self setType: #toggle ofTypes: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]

{ #category : #'accessing - state' }
Fui2Checkbox >> check [

	^ self performOnElement: 'set checked'
]

{ #category : #'accessing - state' }
Fui2Checkbox >> disable [

	^ self performOnElement: 'set disabled'
]

{ #category : #'accessing - state' }
Fui2Checkbox >> enable [

	^ self performOnElement: 'set enabled'
]

{ #category : #'accessing - state' }
Fui2Checkbox >> uncheck [

	^ self performOnElement: 'set unchecked'
]
