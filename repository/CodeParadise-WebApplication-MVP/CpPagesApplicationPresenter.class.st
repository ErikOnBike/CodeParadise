Class {
	#name : #CpPagesApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpPagesApplicationPresenter class >> defaultViewClass [

	^ CpScreen
]

{ #category : #rendering }
CpPagesApplicationPresenter >> renderView [

	self
		renderChildViewForModel: self model
		usingPresenter: CpPagePresenter
]
