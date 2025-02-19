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

{ #category : #accessing }
CpTextContent class >> text: aString [

	"Answer an instance of the receiver with the specified text"

	^ self new
		text: aString ;
		yourself
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
