Class {
	#name : #CpViewInspectorStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showStyle:
			arguments: { viewClass style }) ]
]
