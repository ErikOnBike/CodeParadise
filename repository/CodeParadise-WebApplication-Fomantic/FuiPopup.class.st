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

	anElement performOnElement: aDictionary as: self class elementName
]
