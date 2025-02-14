Extension { #name : #CpNodeJSHttpServerResponse }

{ #category : #'*CodeParadise-NodeJS-REST' }
CpNodeJSHttpServerResponse >> writeError: anError [

	"Write the specified Error to the receiver.
	The specified Error can be a CpNodeJSRestError (sub)class or a 'regular' Error instance."

	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [
			self
				traceCr: 'Error: ', anError printString ;
				traceCr: 'Response: ', anError restResponseString ].

	"Prevent error if response already written"
	self writableEnded
		ifTrue: [ ^ self ].

	self
		statusCode: anError restResponseCode ;
		writeChunk: anError restResponseString ;
		end
]
