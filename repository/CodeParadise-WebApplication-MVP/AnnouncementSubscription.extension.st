Extension { #name : 'AnnouncementSubscription' }

{ #category : '*CodeParadise-WebApplication-MVP' }
AnnouncementSubscription >> unsubscribe [

	"Remove the receiver from its Announcer"

	<webApplicationExtension>

	announcer ifNotNil: [ announcer removeSubscription: self ]
]
