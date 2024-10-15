Class {
	#name : #CpViewInspectorTemplateAndStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorTemplateAndStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showTemplate:style:
			arguments: { viewClass template . viewClass style }) ]
]
