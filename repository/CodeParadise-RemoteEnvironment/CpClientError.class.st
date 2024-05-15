Class {
	#name : 'CpClientError',
	#superclass : 'Announcement',
	#instVars : [
		'description'
	],
	#category : 'CodeParadise-RemoteEnvironment-Core-Announcements',
	#package : 'CodeParadise-RemoteEnvironment',
	#tag : 'Core-Announcements'
}

{ #category : 'accessing' }
CpClientError class >> description: aString [

	^ self new
		description: aString ;
		yourself
]

{ #category : 'accessing' }
CpClientError >> description [

	^ description
]

{ #category : 'accessing' }
CpClientError >> description: aString [

	description := aString
]

{ #category : 'printing' }
CpClientError >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ': ' ;
		print: self description
]
