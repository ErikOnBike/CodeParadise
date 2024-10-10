Class {
	#name : #CpViewInspectorBrowseTemplateRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorBrowseTemplateRequest >> perform [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		(viewClass class >> #template) browse ]
]
