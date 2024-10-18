Class {
	#name : #CpViewInspectorTemplateRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorTemplateRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| sourceCodeInfo |

		(viewClass class includesSelector: #template)
			ifFalse: [ ^ self ].

		[ sourceCodeInfo := self extractSourceCode: viewClass class >> #template ] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].

		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showTemplate:
			arguments: { sourceCodeInfo at: #sourceCode }) ]
]
