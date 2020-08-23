"
I represent content for a Slide.
I am an abstract base class.

"
Class {
	#name : #CpSlideContent,
	#superclass : #Model,
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #api }
CpSlideContent >> preferredPresenterClass [

	self subclassResponsibility
]
