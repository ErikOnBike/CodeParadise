Class {
	#name : 'CpWindowTitlePresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-Beach-Presenters',
	#package : 'CodeParadise-Beach',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
CpWindowTitlePresenter class >> defaultViewClass [

	^ CpWindowTitle
]

{ #category : 'view' }
CpWindowTitlePresenter >> renderView [

	self view renderTitle: self model title
]
