Extension { #name : 'Announcer' }

{ #category : '*CodeParadise-WebApplication' }
Announcer >> removeInterestIn: anAnnouncementClass for: anObject [

	"Remove interest in the specified AnnouncementClass for the specified subscriber"

	registry subscriptionsOf: anObject do: [ :each |
		each announcementClass = anAnnouncementClass
			ifTrue: [ self removeSubscription: each ] ]
]
