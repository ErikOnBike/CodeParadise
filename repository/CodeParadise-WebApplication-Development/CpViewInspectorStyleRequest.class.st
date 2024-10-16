Class {
	#name : #CpViewInspectorStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>


	self viewClass ifNotNil: [ :viewClass |
		| sourceCodeInfo |

		[ sourceCodeInfo := self extractSourceCode: viewClass class >> #style ] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].

		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showStyle:
			arguments: { sourceCodeInfo at: #sourceCode }) ]
]
