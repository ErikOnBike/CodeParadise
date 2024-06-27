Extension { #name : #CpServerEnvironment }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpServerEnvironment >> handleError: anError [

	"Handle the specified Error"

	super handleError: anError.

	loaded
		ifTrue: [
			self ifDevelopment: [
				self sendMessageDirectly: (MessageSend
					receiver: nil
					selector: #alert:
					arguments: { 'An error occurred (see Pharo image): ', anError description }) ] ].

	"Debug the error in the development environment.
	DO NOT FORGET TO USE 'Proceed' IN THE DEBUGGER WHEN DONE.
	THE ServerEnvironment USES A SINGLE THREADED MODEL FOR
	HANDLING ANNOUNCEMENTS AND WILL OTHERWISE BECOME UNRESPONSIVE."
	self ifDevelopment: [ self halt ]
]
