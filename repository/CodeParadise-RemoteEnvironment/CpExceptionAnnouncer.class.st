Class {
	#name : #CpExceptionAnnouncer,
	#superclass : #Announcer,
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core'
}

{ #category : #announcing }
CpExceptionAnnouncer class >> announce: anAnnouncement [

	"In case no one is listening, simply answer nil and do not create my current instance"
	self hasCurrent
		ifFalse: [ ^ nil ].

	^ self current
		announce: anAnnouncement
]

{ #category : #announcing }
CpExceptionAnnouncer class >> announceException: anException [

	"In case no one is listening, simply answer nil and do not create announcement or my current instance"
	self hasCurrent
		ifFalse: [ ^ nil ].

	^ self announce: (CpExceptionAnnouncement exception: anException)
]

{ #category : #accessing }
CpExceptionAnnouncer class >> current [

	"Answer the current instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #testing }
CpExceptionAnnouncer class >> hasCurrent [

	^ Current isNotNil
]

{ #category : #'instance creation' }
CpExceptionAnnouncer class >> new [

	"Use self >> #current instead to get the singleton instance"

	self errorNewReplacedBy: #current
]

{ #category : #deprecated }
CpExceptionAnnouncer class >> when: anAnnouncementClass do: aBlock [

	self flag: #deprecatedMethod.
	self warnCr: 'Use of any Announcer''s #when:do: is deprecated, please use #when:do:for:'.

	^ self when: anAnnouncementClass do: aBlock for: aBlock receiver
]

{ #category : #announcing }
CpExceptionAnnouncer class >> when: anAnnouncement do: aBlock for: anObject [

	"Subscribe anObject to announcements of anAnnouncementClass class. 
	 When announced, aBlock is evaluated."

	^ self current
		when: anAnnouncement do: aBlock for: anObject
]

{ #category : #announcing }
CpExceptionAnnouncer class >> when: anAnnouncement send: aSymbol to: anObject [

	^ self current
		when: anAnnouncement send: aSymbol to: anObject
]
