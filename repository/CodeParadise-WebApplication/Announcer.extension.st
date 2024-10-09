Extension { #name : #Announcer }

{ #category : #'*CodeParadise-WebApplication' }
Announcer >> removeInterestIn: anAnnouncementClass for: anObject [

	"Remove interest in the specified AnnouncementClass for the specified subscriber"

	<webApplicationExtension>

	self subscriptionsOf: anObject do: [ :each |
		each announcementClass = anAnnouncementClass
			ifTrue: [ self removeSubscription: each ] ]
]

{ #category : #'*CodeParadise-WebApplication' }
Announcer >> reset [

	<webApplicationExtension>

	registry reset
]

{ #category : #'*CodeParadise-WebApplication' }
Announcer >> subscriptionsOf: anObject do: aBlock [

	<webApplicationExtension>

	registry subscriptionsOf: anObject do: aBlock
]
