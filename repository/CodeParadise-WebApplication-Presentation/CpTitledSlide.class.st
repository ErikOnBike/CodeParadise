Class {
	#name : #CpTitledSlide,
	#superclass : #CpSlide,
	#instVars : [
		'title'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #accessing }
CpTitledSlide >> title [

	^ title
]

{ #category : #accessing }
CpTitledSlide >> title: aString [

	title := aString.

	self valueChanged
]
