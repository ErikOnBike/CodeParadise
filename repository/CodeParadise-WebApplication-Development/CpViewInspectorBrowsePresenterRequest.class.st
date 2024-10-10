Class {
	#name : #CpViewInspectorBrowsePresenterRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorBrowsePresenterRequest >> perform [

	<serverEnvironment>

	self presenterClass ifNotNil: [ :presenterClass |
		presenterClass browse ]
]

{ #category : #converting }
CpViewInspectorBrowsePresenterRequest >> presenterClass [

	"Answer the Presenter class matching the View class of the receiver"

	<serverEnvironment>

	^ self viewClass ifNotNil: [ :viewClass |
		(Smalltalk classNamed: (viewClass name withoutSuffix: #View), #Presenter) ]
]
