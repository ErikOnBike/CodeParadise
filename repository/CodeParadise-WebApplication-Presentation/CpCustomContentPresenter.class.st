Class {
	#name : #CpCustomContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #view }
CpCustomContentPresenter >> renderView [

	self view render
		
]

{ #category : #view }
CpCustomContentPresenter >> viewClass [

	^ self model viewClass
]
