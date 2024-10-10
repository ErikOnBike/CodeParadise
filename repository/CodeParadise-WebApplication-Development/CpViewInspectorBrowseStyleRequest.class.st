Class {
	#name : #CpViewInspectorBrowseStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorBrowseStyleRequest >> perform [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		(viewClass class >> #style) browse ]
]
