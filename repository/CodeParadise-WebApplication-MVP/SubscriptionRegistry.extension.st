Extension { #name : #SubscriptionRegistry }

{ #category : #'*CodeParadise-WebApplication-MVP' }
SubscriptionRegistry >> cpSubscriptions: aCollection [

	"Replace the subscriptions collections with a custom collection.
	This is and should only be used directly after creation of the
	registry. It is used in CodeParadise for putting an order on the
	delivery of Announcements."

	subscriptions := aCollection
]
