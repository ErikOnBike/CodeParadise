Class {
	#name : #FuiPopup,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiPopup class >> baseElementTagName [

	^ #div
]

{ #category : #'instance creation' }
FuiPopup class >> newWithOptions: aDictionary [ 

	^ self new 
		performOnElement: aDictionary ;
		yourself
]

{ #category : #'as yet unclassified' }
FuiPopup >> activateOnElement: anElement withOptions: aDictionary [ 

	self flag: #FIXME. "Make options simpler to set, like #beInline, #beHoverable, etc.
	Popup object can 'cache' these options until its asked to activate on element.
	
	Update afterwards: CpFomanticExamplesClientBehavior>>#examplePopup."

	anElement performOnElement: aDictionary as: self class elementName
]
