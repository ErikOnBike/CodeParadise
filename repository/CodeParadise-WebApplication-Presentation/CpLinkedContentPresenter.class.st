Class {
	#name : #CpLinkedContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #accessing }
CpLinkedContentPresenter class >> defaultViewClass [

	^ CpLinkedContentView
]

{ #category : #model }
CpLinkedContentPresenter >> contentModel [

	^ self model content
]

{ #category : #'user interaction' }
CpLinkedContentPresenter >> linkedSlideSelected [

	self parent slideSelected: self model linkedSlide
]

{ #category : #view }
CpLinkedContentPresenter >> renderView [

	"Render view of the receiver"

	self renderChildViewForModel: self contentModel
]

{ #category : #view }
CpLinkedContentPresenter >> viewCreated [

	super viewCreated.

	self view
		when: CpLinkActivated send: #linkedSlideSelected to: self
]
