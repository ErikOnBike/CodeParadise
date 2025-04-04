"
I represent both the Browser EventTarget and the Node.js EventTarget.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserEventTarget,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #operations }
CpBrowserEventTarget >> addEventListener: aSymbol handler: aBlock [

	"Add the specified Block as an event handler for the specified event
	for the receiver's proxied JavaScript object (i.e. an EventTarget).
	Answer the added handler (wrapped as Function) which is needed as
	the handler to remove the event listener."

	| function |

	"Create function from the Block and specify the event name (to allow later removal)"
	function := CpJavaScriptFunction wrap: aBlock.
	function propertyAt: #eventName put: aSymbol.

	"Add event listener"
	self apply: #addEventListener withArguments: { aSymbol . function }.

	^ function
]

{ #category : #operations }
CpBrowserEventTarget >> removeEventListener: aFunction [

	"Remove the specified funcion (a wrapped Block, answered by #addEventListener:handler:)
	from the receiver's proxied JavaScript object (i.e. an EventTarget)."

	self apply: #removeEventListener withArguments: { aFunction propertyAt: #eventName . aFunction }
]

{ #category : #announcing }
CpBrowserEventTarget >> removeSubscription: aFunction [

	"Remove the specified handler Function as event listener from the receiver.
	This convenience method is present to mimic the Announcement behavior.
	Since the receiver does not have an Announcer, there are no Subscriptions.
	The #when:send:to and #when:do:for methods answer handler Functions which
	can be used to remove the handler here."

	self removeEventListener: aFunction
]

{ #category : #announcing }
CpBrowserEventTarget >> when: anAnnouncementClass do: aBlock for: anObject [

	"Let the sender listen to the specified announcement of the receiver.
	Since CpEvents share the same protocol as Announcements this method
	become a convenience method to use these events.
	In contrast with CpDomElement >> when:send:to: the receiver does not
	have an actual Announcer. So a handler will be answered, instead of
	a Subscription. See #addEventListener:handler:"

	^ self addEventListener: anAnnouncementClass type handler: [ :event |
		(anAnnouncementClass handlesAnnouncement: event)
			ifTrue: [ aBlock cull: event ] ]
]

{ #category : #announcing }
CpBrowserEventTarget >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender listen to the specified announcement of the receiver.
	Since CpEvents share the same protocol as Announcements this method
	become a convenience method to use these events.
	In contrast with CpDomElement >> when:send:to: the receiver does not
	have an actual Announcer. So a handler will be answered, instead of
	a Subscription. See #addEventListener:handler:"

	^ self
		when: anAnnouncementClass
		do: (MessageSend receiver: anObject selector: aSymbol)
		for: anObject
]
