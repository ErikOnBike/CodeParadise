Class {
	#name : #CpWindowTitlePresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpWindowTitlePresenter class >> defaultViewClass [

	^ CpWindowTitle
]

{ #category : #view }
CpWindowTitlePresenter >> renderView [

	self view renderTitle: self model title
]
