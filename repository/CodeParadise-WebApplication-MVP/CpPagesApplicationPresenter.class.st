Class {
	#name : #CpPagesApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpPagesApplicationPresenter class >> defaultViewClass [

	^ CpScreen
]

{ #category : #presenters }
CpPagesApplicationPresenter >> presenterClassForModel: aModel atSlotNamed: aString [

	"Answer the Presenter class for the specified Model in the specified slot
	as a child Presenter of the receiver"

	^ CpPagePresenter
]

{ #category : #rendering }
CpPagesApplicationPresenter >> renderView [

	self renderChildViewForModel: self model
]
