Class {
	#name : #Fui2Checkbox,
	#superclass : #Fui2Element,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
Fui2Checkbox class >> allTypes [

	^ #(#slider #toggle #radio)
]

{ #category : #'instance creation' }
Fui2Checkbox class >> newNamed: aSymbol withLabel: aString [

	"Answer a new HTML element for the input field named (aSymbol) with specified label"

	^ (self newWithTag: #div)
		attributeAt: #class put: 'ui checkbox' ;
		appendChild: ((CpHtmlElement newWithTag: #input)
			propertyAt: #type put: #checkbox ;
			propertyAt: #name put: aSymbol ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #label)
			textContent: aString ;
			yourself) ;
		performOnElement: nil ; "No properties"
		yourself
]

{ #category : #accessing }
Fui2Checkbox class >> type [

	^ #checkbox
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beRadio [

	self setState: #radio ofStates: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #radio
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beSlider [

	self setState: #slider ofStates: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]

{ #category : #'accessing - types' }
Fui2Checkbox >> beToggle [

	self setState: #toggle ofStates: self class allTypes.
	(self firstDescendantMatching: #input)
		propertyAt: #type put: #checkbox
]
