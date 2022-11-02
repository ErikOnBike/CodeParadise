Extension { #name : #ProtoObject }

{ #category : #'*CodeParadise-RemoteEnvironment' }
ProtoObject >> crError: aString [

	self crTrace: 'ERROR: ', aString
]
