Extension { #name : 'Announcement' }

{ #category : '*CodeParadise-RemoteEnvironment' }
Announcement >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeAnnouncement: self
]
