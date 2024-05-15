Class {
	#name : 'CpWindowsApplicationPresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-Beach-Presenters',
	#package : 'CodeParadise-Beach',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
CpWindowsApplicationPresenter class >> defaultViewClass [

	^ CpScreen
]

{ #category : 'presenters' }
CpWindowsApplicationPresenter >> presenterClassForModel: aModel atSlotNamed: aString [

	"Answer the Presenter class for the specified Model in the specified slot
	as a child Presenter of the receiver"

	^ CpWindowPresenter
]
