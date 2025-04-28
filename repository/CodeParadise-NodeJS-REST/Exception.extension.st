Extension { #name : #Exception }

{ #category : #'*CodeParadise-NodeJS-REST' }
Exception >> restResponseCode [

	"Answer the REST response code (aka HTTP status code).
	Since in general an error is our 'fault' answer a
	response code for an Internal Server Error (501)."

	<restApplicationExtension>

	^ CpNodeJSRestError responseCode
]

{ #category : #'*CodeParadise-NodeJS-REST' }
Exception >> restResponseString [

	"Answer a REST response string from the receiver"

	<restApplicationExtension>

	| error indent |

	error := self.
	indent := ''.

	^ String streamContents: [ :stream |
		[
			"Write error description"
			stream
				nextPutAll: error description ;
				nextPutAll: String lf.

			indent := indent, '    '.

			"Go deeper into the cause until nothing left"
			(error cause
				ifNotNil: [ :cause |
					cause isErrorObject
						ifTrue: [ error := cause ] ]) isNotNil
		] whileTrue ]
]
