Extension { #name : #CpNodeJSHttpServerResponse }

{ #category : #'*CodeParadise-NodeJS-REST' }
CpNodeJSHttpServerResponse >> writeError: anError [

	"Write the specified Error to the receiver"

	self
		statusCode: anError restResponseCode ;
		writeChunk: anError restResponseString ;
		writeChunk: String lf ;
		end
]
