Extension { #name : #Announcement }

{ #category : #'*RemoteEnvironment' }
Announcement >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeAnnouncement: self
]
