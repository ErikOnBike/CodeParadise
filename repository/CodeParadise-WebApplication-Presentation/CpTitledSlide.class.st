Class {
	#name : #CpTitledSlide,
	#superclass : #CpSlide,
	#instVars : [
		'title'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #api }
CpTitledSlide >> preferredPresenterClass [

	^ CpTitledSlidePresenter
]

{ #category : #accessing }
CpTitledSlide >> title [

	^ title
]

{ #category : #accessing }
CpTitledSlide >> title: aString [

	title := aString.

	self valueChanged
]
