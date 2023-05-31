Class {
	#name : #CpPagePresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #rendering }
CpPagePresenter >> renderView [

	self renderChildViewForModel: self model
]
