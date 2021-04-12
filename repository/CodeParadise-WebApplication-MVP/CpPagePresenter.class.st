Class {
	#name : #CpPagePresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpPagePresenter class >> defaultViewClass [

	^ CpPageView
]

{ #category : #rendering }
CpPagePresenter >> renderView [

	self renderChildViewForModel: self model
]
