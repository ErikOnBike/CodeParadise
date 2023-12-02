Class {
	#name : #CpHtmlContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'html'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #accessing }
CpHtmlContent class >> html: aString [

	"Answer an instance of the receiver with the specified HTML"

	^ self new
		html: aString ;
		yourself
]

{ #category : #accessing }
CpHtmlContent >> html [

	^ html
]

{ #category : #accessing }
CpHtmlContent >> html: aString [

	html := aString.

	self valueChanged
]
