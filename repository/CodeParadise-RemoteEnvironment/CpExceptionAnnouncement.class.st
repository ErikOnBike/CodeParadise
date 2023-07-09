Class {
	#name : #CpExceptionAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'exception'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core-Announcements'
}

{ #category : #'instance creation' }
CpExceptionAnnouncement class >> exception: anException [

	^ self basicNew
		initializeWithException: anException ;
		yourself
]

{ #category : #initialization }
CpExceptionAnnouncement >> exception [

	^ exception
]

{ #category : #initialization }
CpExceptionAnnouncement >> initializeWithException: anException [

	self initialize.

	exception := anException
]
