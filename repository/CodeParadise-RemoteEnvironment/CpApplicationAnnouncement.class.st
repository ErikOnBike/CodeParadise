Class {
	#name : 'CpApplicationAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'application'
	],
	#category : 'CodeParadise-RemoteEnvironment-Core-Announcements',
	#package : 'CodeParadise-RemoteEnvironment',
	#tag : 'Core-Announcements'
}

{ #category : 'accessing' }
CpApplicationAnnouncement class >> application: anApplication [

	^ self basicNew
		initializeWithApplication: anApplication ;
		yourself
]

{ #category : 'accessing' }
CpApplicationAnnouncement >> application [

	^ application
]

{ #category : 'initialization' }
CpApplicationAnnouncement >> initializeWithApplication: anApplication [

	self initialize.

	application := anApplication
]
