Class {
	#name : #CpDomElementAnnouncer,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'element'
	],
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'instance creation' }
CpDomElementAnnouncer class >> new [

	self shouldNotImplement
]

{ #category : #'instance creation' }
CpDomElementAnnouncer class >> newForElement: anElement [

	^ self basicNew
		initializeWithElement: anElement ;
		yourself
]

{ #category : #accessing }
CpDomElementAnnouncer >> announce: anAnnouncement [

	announcer announce: anAnnouncement
]

{ #category : #accessing }
CpDomElementAnnouncer >> element [

	^ element
]

{ #category : #initialization }
CpDomElementAnnouncer >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #initialization }
CpDomElementAnnouncer >> initializeWithElement: anElement [

	self initialize.

	element := anElement
]

{ #category : #subscription }
CpDomElementAnnouncer >> removeInterestIn: anAnnouncementClass for: anObject [

	announcer removeInterestIn: anAnnouncementClass for: anObject
]

{ #category : #subscription }
CpDomElementAnnouncer >> removeSubscription: aSubscription [

	"Remove the specified subscription from the receiver"

	aSubscription announcementClass removeListenerFrom: self element.

	^ announcer removeSubscription: aSubscription
]

{ #category : #subscription }
CpDomElementAnnouncer >> reset [

	"Reset the subscriptions.

	Implementation:
	The current Announcer's #subscriptions method actually answers the
	registry, therefore sending #subscriptions and then #reset."

	^ announcer reset
]

{ #category : #subscription }
CpDomElementAnnouncer >> subscriptions [

	"Answer the receiver's subscriptions.

	Implementation:
	The current Announcer's #subscriptions method actually answers the
	registry, therefore sending #subscriptions twice."

	^ announcer subscriptions subscriptions
]

{ #category : #subscription }
CpDomElementAnnouncer >> subscriptionsOf: anObject do: aBlock [

	announcer subscriptionsOf: anObject do: aBlock
]

{ #category : #subscription }
CpDomElementAnnouncer >> unsubscribe: anObject [

	"Unsubscribe all subscriptions of anObject from the receiver"
	
	self subscriptionsOf: anObject do: [ :each |
		each announcementClass removeListenerFrom: each subscriber ].

	announcer unsubscribe: anObject
]

{ #category : #subscription }
CpDomElementAnnouncer >> when: anAnnouncementClass deferDo: aBlock for: anObject [

	"Subscribe the specified Announcement Class.
	This particular variant forkes the message send in a separate Process.
	This is useful in combination with using CpJavaScriptPromise >> #await
	which temporarily suspends execution. Normally execution can't stop in
	an event handler. Having a handler which forks of a separate Process
	allows execution to continu.
	Be aware that the event handling should not rely on some ordering or
	timing. These become unpredictable because of awaiting results."

	^ self
		when: anAnnouncementClass
		do: aBlock deferred
		for: anObject
]

{ #category : #subscription }
CpDomElementAnnouncer >> when: anAnnouncementClass deferSend: aSymbol to: anObject [

	"Subscribe the specified Announcement Class.
	In this particular variant the message send is deferred.
	This is useful in combination with using CpJavaScriptPromise >> #await
	which temporarily suspends execution. Normally execution can't stop in
	an event handler. Having a handler which defers execution allows the
	'normal' execution to continu and will not stop the event handler.
	Be aware that the event handling should not rely on some ordering or
	timing. These become unpredictable because of awaiting results."

	^ self
		when: anAnnouncementClass
		do: (CpDeferredMessageSend receiver: anObject selector: aSymbol)
		for: anObject
]

{ #category : #deprecated }
CpDomElementAnnouncer >> when: anAnnouncementClass do: aBlock [

	self flag: #deprecatedMethod.
	self warnCr: 'Use of any Announcer''s #when:do: is deprecated, please use #when:do:for:'.

	^ self when: anAnnouncementClass do: aBlock for: aBlock receiver
]

{ #category : #subscription }
CpDomElementAnnouncer >> when: anAnnouncementClass do: aBlock for: anObject [

	"Subscribe anObject to announcements of anAnnouncementClass class. 
	 When announced, aBlock is evaluated."

	anAnnouncementClass addListenerTo: self element.

	^ announcer when: anAnnouncementClass do: aBlock for: anObject
]

{ #category : #subscription }
CpDomElementAnnouncer >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.

	Implementation:
	Simply perform the same behavior as the superclass. Do NOT add a listener here as in the
	method #when:do:for: because then it will be added twice."

	^ self
		when: anAnnouncementClass
		do: (MessageSend receiver: anObject selector: aSymbol)
		for: anObject
]
