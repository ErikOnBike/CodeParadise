Extension { #name : #CpNodeJSHttpServerResponse }

{ #category : #'*CodeParadise-NodeJS-REST' }
CpNodeJSHttpServerResponse >> writeError: anError [

	"Write the specified Error to the receiver"

	CpJavaScriptObject isDevelopmentEnvironment
		ifTrue: [
			self
				traceCr: 'Error: ', anError printString ;
				traceCr: 'Response: ', anError restResponseString ].

	self
		statusCode: anError restResponseCode ;
		writeChunk: anError restResponseString ;
		writeChunk: String lf ;
		end
]
