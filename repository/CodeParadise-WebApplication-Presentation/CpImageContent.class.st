"
I represent Image content in a Slide.
I have a URL and optional width and height (in CSS values).
"
Class {
	#name : #CpImageContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'url',
		'width',
		'height'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #accessing }
CpImageContent >> height [

	^ height
]

{ #category : #accessing }
CpImageContent >> height: aString [

	"Set the height as a CSS length value"

	height := aString.

	self valueChanged
]

{ #category : #accessing }
CpImageContent >> url [

	^ url
]

{ #category : #accessing }
CpImageContent >> url: aString [

	url := aString.

	self valueChanged
]

{ #category : #accessing }
CpImageContent >> width [

	^ width
]

{ #category : #accessing }
CpImageContent >> width: aString [

	"Set the width as a CSS length value"

	width := aString.

	self valueChanged
]
