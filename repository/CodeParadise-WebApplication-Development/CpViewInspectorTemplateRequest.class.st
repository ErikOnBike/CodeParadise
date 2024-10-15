Class {
	#name : #CpViewInspectorTemplateRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorTemplateRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showTemplate:
			arguments: { viewClass template }) ]
]
