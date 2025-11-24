Extension { #name : #CpNodeJSNodemailerMessage }

{ #category : #'*CodeParadise-Canyon-Data' }
CpNodeJSNodemailerMessage >> restApiLogInfo [

	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'message to: "' ;
			nextPutAll: self to asString ;
			nextPutAll: '" subject: "' ;
			nextPutAll: (self subject ifNil: [ '<no subject>' ]) asString ;
			nextPut: $" ]
]
