Extension { #name : #Exception }

{ #category : #'*CodeParadise-NodeJS-REST' }
Exception >> restResponseCode [

	"Answer the REST response code (aka HTTP status code).
	Since in general an error is our 'fault' answer a
	response code for an Internal Server Error (501)."

	<applicationExtension>

	^ CpNodeJSRestError responseCode
]
