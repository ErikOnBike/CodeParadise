Extension { #name : 'CpServerEnvironment' }

{ #category : '*CodeParadise-WebApplication' }
CpServerEnvironment >> fakeStop [

	"Fake the receiver is requested to stop
	(to be used when the client is no longer able to do so).

	Implementation:
	Instead of calling #stop directly, announce stop request
	since other objects like the CpApplicationServer are also
	listening for this event."

	self announcer announce: CpClientStopped
]
