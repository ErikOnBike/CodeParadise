Class {
	#name : #CpDemoCodeContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #accessing }
CpDemoCodeContentPresenter class >> defaultViewClass [

	^ CpDemoCodeContentView
]

{ #category : #'user interaction' }
CpDemoCodeContentPresenter >> copyClipboard [

	Clipboard clipboardText: (self model code copyReplaceAll: String lf with: String cr)
]

{ #category : #view }
CpDemoCodeContentPresenter >> renderView [

	self view textContent: self model code
]

{ #category : #view }
CpDemoCodeContentPresenter >> viewCreated [

	super viewCreated.

	self view when: CpDemoCodeCopyClipboard send: #copyClipboard to: self
]
