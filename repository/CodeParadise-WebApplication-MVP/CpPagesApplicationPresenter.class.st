Class {
	#name : 'CpPagesApplicationPresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'accessing' }
CpPagesApplicationPresenter class >> defaultViewClass [

	^ CpScreen
]

{ #category : 'rendering' }
CpPagesApplicationPresenter >> renderView [

	self
		renderChildViewForModel: self model
		usingPresenter: CpPagePresenter
]
