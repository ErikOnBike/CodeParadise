Class {
	#name : #CynAnnouncedException,
	#superclass : #Error,
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'error handling' }
CynAnnouncedException class >> exceptionAnnouncement: anExceptionAnnouncement [

	"Answer an instance of the receiver, wrapping the specified ExceptionAnnouncement"

	^ self basicNew
		initializeWithExceptionAnnouncement: anExceptionAnnouncement ;
		yourself
]

{ #category : #'instance creation' }
CynAnnouncedException class >> new [

	self errorNewReplacedBy: #exceptionAnnouncement:
]

{ #category : #accessing }
CynAnnouncedException >> announcerContext [

	^ tag announcerContext
]

{ #category : #accessing }
CynAnnouncedException >> description [

	^ self exception description
]

{ #category : #accessing }
CynAnnouncedException >> exception [

	^ tag exception
]

{ #category : #initialization }
CynAnnouncedException >> initializeWithExceptionAnnouncement: anExceptionAnnouncement [

	self initialize.

	tag := anExceptionAnnouncement
]

{ #category : #testing }
CynAnnouncedException >> isAnnouncedException [

	^ true
]

{ #category : #printing }
CynAnnouncedException >> printOn: aStream [

	self exception printOn: aStream
]
