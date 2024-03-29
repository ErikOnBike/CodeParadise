Extension { #name : #CpServerEnvironment }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpServerEnvironment >> handleError: aString [

	"Handle an error with the specified description"

	super handleError: aString.

	loaded
		ifTrue: [
			self ifDevelopment: [
				self sendMessageDirectly: (MessageSend
					receiver: nil
					selector: #alert:
					arguments: { 'An error occurred (see Pharo image): ', aString }) ] ].

	self halt
]
