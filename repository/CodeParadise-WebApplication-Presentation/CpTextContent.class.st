"
I represent text content in a Slide.
I have a single text value.

"
Class {
	#name : #CpTextContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'text'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #api }
CpTextContent >> preferredPresenterClass [

	^ CpTextContentPresenter
]

{ #category : #accessing }
CpTextContent >> text [

	^ text
]

{ #category : #accessing }
CpTextContent >> text: aString [

	text := aString.

	self valueChanged
]
