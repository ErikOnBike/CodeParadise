Class {
	#name : #CpClientError,
	#superclass : #Announcement,
	#instVars : [
		'description'
	],
	#category : #'RemoteEnvironment-Core-Announcements'
}

{ #category : #accessing }
CpClientError class >> description: aString [

	^ self new
		description: aString ;
		yourself
]

{ #category : #accessing }
CpClientError >> description [

	^ description
]

{ #category : #accessing }
CpClientError >> description: aString [

	description := aString
]

{ #category : #'as yet unclassified' }
CpClientError >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ': ' ;
		nextPutAll: self description printString
]
