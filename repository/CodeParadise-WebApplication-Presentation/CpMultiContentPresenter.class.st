Class {
	#name : #CpMultiContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpMultiContentPresenter >> contentModels [

	^ self model contentCollection
]

{ #category : #rendering }
CpMultiContentPresenter >> renderView [

	"Render view of the receiver"

	self renderAllChildViewsForModels: self contentModels
]
