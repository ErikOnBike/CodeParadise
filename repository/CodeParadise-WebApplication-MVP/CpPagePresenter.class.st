Class {
	#name : 'CpPagePresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'rendering' }
CpPagePresenter >> renderView [

	self renderChildViewForModel: self model
]
