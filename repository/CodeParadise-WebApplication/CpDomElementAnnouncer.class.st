Class {
	#name : #CpDomElementAnnouncer,
	#superclass : #Announcer,
	#instVars : [
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
CpDomElementAnnouncer >> element [

	^ element
]

{ #category : #initialization }
CpDomElementAnnouncer >> initializeWithElement: anElement [

	self initialize.

	element := anElement
]

{ #category : #removing }
CpDomElementAnnouncer >> removeInterestIn: anAnnouncementClass for: anObject [

	anAnnouncementClass removeListenerFrom: self element.

	super removeInterestIn: anAnnouncementClass for: anObject
]

{ #category : #'registration api' }
CpDomElementAnnouncer >> when: anAnnouncementClass do: aBlock [

	anAnnouncementClass addListenerTo: self element.

	super when: anAnnouncementClass do: aBlock
]

{ #category : #'registration api' }
CpDomElementAnnouncer >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector.

	Implementation:
	Simply perform the same behavior as the superclass. Do NOT add a listener here as in the
	method #when:do: because then it will be added twice."

	self when: anAnnouncementClass do: (MessageSend receiver: anObject selector: aSymbol)
]
