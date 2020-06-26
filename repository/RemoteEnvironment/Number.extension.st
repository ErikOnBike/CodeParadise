Extension { #name : #Number }

{ #category : #'*RemoteEnvironment' }
Number >> digitLength [

	self flag: #todo. "Awful hack to stay compatible between Pharo7 and Pharo9"
	^ self bytesCount
]
