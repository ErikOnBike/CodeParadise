Class {
	#name : #CpApplicationAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'application'
	],
	#category : #'CodeParadise-RemoteEnvironment-Core-Announcements'
}

{ #category : #accessing }
CpApplicationAnnouncement class >> application: anApplication [

	^ self basicNew
		initializeWithApplication: anApplication ;
		yourself
]

{ #category : #accessing }
CpApplicationAnnouncement >> application [

	^ application
]

{ #category : #accessing }
CpApplicationAnnouncement >> environment [

	^ self application environment
]

{ #category : #initialization }
CpApplicationAnnouncement >> initializeWithApplication: anApplication [

	self initialize.

	application := anApplication
]
