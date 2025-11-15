Extension { #name : #Model }

{ #category : #'*CodeParadise-WebApplication-MVP' }
Model >> unsubscribe: anObject [

	"Unsubscribe all subscriptions from the specified object on the receiver"

	self announcer unsubscribe: anObject
]
