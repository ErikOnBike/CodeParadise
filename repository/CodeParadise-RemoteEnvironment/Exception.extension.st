Extension { #name : #Exception }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Exception >> announce [

	<applicationExtension>

	CpExceptionAnnouncer announceException: self
]
