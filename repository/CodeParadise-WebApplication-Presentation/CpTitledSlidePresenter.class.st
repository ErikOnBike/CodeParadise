Class {
	#name : #CpTitledSlidePresenter,
	#superclass : #CpSlidePresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpTitledSlidePresenter class >> defaultViewClass [

	^ CpTitledSlideView
]

{ #category : #view }
CpTitledSlidePresenter >> renderView [

	"Render view of the receiver"

	super renderView.

	self view renderTitle: self model title
]
