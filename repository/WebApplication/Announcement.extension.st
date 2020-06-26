Extension { #name : #Announcement }

{ #category : #'*WebApplication' }
Announcement >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeAnnouncement: self
]
