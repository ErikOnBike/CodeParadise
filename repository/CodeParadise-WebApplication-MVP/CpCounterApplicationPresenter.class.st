Class {
	#name : #CpCounterApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #accessing }
CpCounterApplicationPresenter class >> defaultViewClass [

	^ CpCounterApplicationView
]

{ #category : #view }
CpCounterApplicationPresenter >> renderView [

	self
		renderChildViewForModel: self model local atSlotNamed: #local ;
		renderChildViewForModel: self model global atSlotNamed: #global
]
