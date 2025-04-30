Class {
	#name : #CynRestApiClientFailed,
	#superclass : #Announcement,
	#instVars : [
		'exception'
	],
	#category : #'CodeParadise-Canyon-App-Announcements'
}

{ #category : #'instance creation' }
CynRestApiClientFailed class >> exception: anException [

	^ self basicNew
		initializeWithException: anException ;
		yourself
]

{ #category : #'instance creation' }
CynRestApiClientFailed class >> new [

	self errorNewReplacedBy: #exception:
]

{ #category : #accessing }
CynRestApiClientFailed >> exception [

	^ exception
]

{ #category : #accessing }
CynRestApiClientFailed >> initializeWithException: anException [

	self initialize.

	exception := anException
]
