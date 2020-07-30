"
I am an Announcement to indicate a Message is sent to a Proxy.
"
Class {
	#name : #CpMessageToProxyReceived,
	#superclass : #Announcement,
	#instVars : [
		'messageSend'
	],
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #'instance creation' }
CpMessageToProxyReceived class >> messageSend: aMessageSend [

	^ self new
		messageSend: aMessageSend ;
		yourself
]

{ #category : #accessing }
CpMessageToProxyReceived >> messageSend [

	^ messageSend
]

{ #category : #accessing }
CpMessageToProxyReceived >> messageSend: aMessageSend [

	messageSend := aMessageSend
]
