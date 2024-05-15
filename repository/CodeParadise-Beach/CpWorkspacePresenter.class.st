Class {
	#name : 'CpWorkspacePresenter',
	#superclass : 'CpPresenter',
	#category : 'CodeParadise-Beach-Presenters',
	#package : 'CodeParadise-Beach',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
CpWorkspacePresenter class >> defaultViewClass [

	^ CpWorkspace
]

{ #category : 'presenters' }
CpWorkspacePresenter >> presenterClassForModel: aModel atSlotNamed: aString [

	"Answer the Presenter class for the specified Model in the specified slot
	as a child Presenter of the receiver"

	^ self model workItemPresenterClass
]
