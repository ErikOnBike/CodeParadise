Class {
	#name : #CpCounterApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-Examples-MVP'
}

{ #category : #view }
CpCounterApplicationPresenter >> renderView [

	self
		renderChildViewForModel: self model localCounter atSlotNamed: #local ;
		renderChildViewForModel: self model globalCounter atSlotNamed: #global
]
