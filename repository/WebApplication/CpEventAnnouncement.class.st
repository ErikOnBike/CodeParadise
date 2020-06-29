Class {
	#name : #CpEventAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'event'
	],
	#category : #'WebApplication-Core'
}

{ #category : #accessing }
CpEventAnnouncement class >> event: anEvent [

	^ self new
		event: anEvent ;
		yourself
]

{ #category : #accessing }
CpEventAnnouncement >> event [

	^ event
]

{ #category : #accessing }
CpEventAnnouncement >> event: anEvent [

	event := anEvent
]
