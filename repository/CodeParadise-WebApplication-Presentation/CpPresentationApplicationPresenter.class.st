Class {
	#name : #CpPresentationApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpPresentationApplicationPresenter class >> defaultViewClass [

	^ CpPresentationApplicationView
]

{ #category : #rendering }
CpPresentationApplicationPresenter >> renderView [

	self renderChildViewForModel: self model presentation
]
