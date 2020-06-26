"
I am Announcement for the failure of a message send in the ClientEnvironment.
I know the MessageSend which failed as well as an additional error message (which helps to identify the actual receiver of the message).
"
Class {
	#name : #CpClientMessageSendFailed,
	#superclass : #CpClientError,
	#instVars : [
		'messageSend'
	],
	#category : #'RemoteEnvironment-Core-Announcements'
}

{ #category : #accessing }
CpClientMessageSendFailed class >> messageSend: aMessageSend [

	^ self new
		messageSend: aMessageSend ;
		yourself
]

{ #category : #accessing }
CpClientMessageSendFailed class >> messageSend: aMessageSend description: aString [

	^ self new
		messageSend: aMessageSend ;
		description: aString ;
		yourself
]

{ #category : #accessing }
CpClientMessageSendFailed >> messageSend [

	^ messageSend
]

{ #category : #accessing }
CpClientMessageSendFailed >> messageSend: aMessageSend [

	messageSend := aMessageSend
]

{ #category : #'as yet unclassified' }
CpClientMessageSendFailed >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', ' ;
		nextPutAll: self messageSend printString
]
