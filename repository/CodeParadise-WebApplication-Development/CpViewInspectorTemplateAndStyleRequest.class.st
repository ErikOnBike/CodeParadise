Class {
	#name : #CpViewInspectorTemplateAndStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorTemplateAndStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| templateSourceCodeInfo styleSourceCodeInfo |

		[ templateSourceCodeInfo := self extractSourceCode: viewClass class >> #template ] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].
		[ styleSourceCodeInfo := self extractSourceCode: viewClass class >> #style ] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].

		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showTemplate:style:
			arguments: { templateSourceCodeInfo at: #sourceCode. styleSourceCodeInfo at: #sourceCode }) ]
]
