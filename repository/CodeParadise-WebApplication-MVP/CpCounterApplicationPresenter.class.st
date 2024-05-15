Class {
	#name : 'CpCounterApplicationPresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-WebApplication-MVP-Examples',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Examples'
}

{ #category : 'view' }
CpCounterApplicationPresenter >> renderView [

	self
		renderChildViewForModel: self model localCounter atSlotNamed: #local ;
		renderChildViewForModel: self model globalCounter atSlotNamed: #global
]
