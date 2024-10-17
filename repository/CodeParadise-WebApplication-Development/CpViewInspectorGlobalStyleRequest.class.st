Class {
	#name : #CpViewInspectorGlobalStyleRequest,
	#superclass : #CpViewInspectorRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #actions }
CpViewInspectorGlobalStyleRequest >> performIn: anEnvironment [

	<serverEnvironment>

	self viewClass ifNotNil: [ :viewClass |
		| sourceCodeInfo |

		[ sourceCodeInfo := self extractSourceCode: viewClass class >> #globalStyle ] on: Error do: [ :err |
			self showErrorAlert: err messageText in: anEnvironment.
			self halt ].

		anEnvironment sendMessage: (MessageSend
			receiver: CpViewInspectorView name
			selector: #showGlobalStyle:
			arguments: { sourceCodeInfo at: #sourceCode }) ]
]
