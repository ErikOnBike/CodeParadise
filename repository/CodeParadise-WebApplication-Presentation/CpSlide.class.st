"
I represent a slide in a SlideDeck.
I have a title and content.

"
Class {
	#name : 'CpSlide',
	#superclass : 'CpModel',
	#instVars : [
		'content'
	],
	#category : 'CodeParadise-WebApplication-Presentation-Model',
	#package : 'CodeParadise-WebApplication-Presentation',
	#tag : 'Model'
}

{ #category : 'accessing' }
CpSlide >> content [

	^ content
]

{ #category : 'accessing' }
CpSlide >> content: aSlideContent [

	content := aSlideContent.

	self valueChanged
]
