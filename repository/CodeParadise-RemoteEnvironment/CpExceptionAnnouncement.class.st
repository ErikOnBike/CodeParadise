Class {
	#name : #CpExceptionAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'exception',
		'announcerContext'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core-Announcements'
}

{ #category : #'instance creation' }
CpExceptionAnnouncement class >> exception: anException [

	^ self exception: anException context: nil
]

{ #category : #'instance creation' }
CpExceptionAnnouncement class >> exception: anException context: aContext [

	^ self basicNew
		initializeWithException: anException announcerContext: aContext ;
		yourself
]

{ #category : #accessing }
CpExceptionAnnouncement >> announcerContext [

	^ announcerContext
]

{ #category : #initialization }
CpExceptionAnnouncement >> exception [

	^ exception
]

{ #category : #initialization }
CpExceptionAnnouncement >> initializeWithException: anException announcerContext: aContext [

	self initialize.

	exception := anException.
	announcerContext := aContext
]
