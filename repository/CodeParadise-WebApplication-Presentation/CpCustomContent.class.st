"
I am represent custom content in a Slide.
I know my view class which provides the custom content.
This view class should implement the #render method for
rendering this custom content.
"
Class {
	#name : #CpCustomContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'viewClass'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #view }
CpCustomContent >> viewClass [

	^ viewClass
]

{ #category : #view }
CpCustomContent >> viewClass: aViewClass [

	viewClass := aViewClass.

	self valueChanged
]
