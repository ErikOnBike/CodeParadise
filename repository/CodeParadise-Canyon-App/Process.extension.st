Extension { #name : #Process }

{ #category : #'*CodeParadise-Canyon-App' }
Process >> specialHandleError: anError [

	<canyonApplicationExtension>

	CynApp current
		handleUnhandledError: anError.

	"This is CodeParadis specific and required"
	self allowAwaitPromise
		ifTrue: [
			self traceCr: 'Terminating Process'.
			self terminate ]
]
