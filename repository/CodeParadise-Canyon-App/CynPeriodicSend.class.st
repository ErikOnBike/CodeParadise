Class {
	#name : #CynPeriodicSend,
	#superclass : #Object,
	#instVars : [
		'interval',
		'messageSend'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CynPeriodicSend class >> interval: anInteger messageSend: aMessageSend [

	^ self basicNew
		initializeWithInterval: anInteger messageSend: aMessageSend ;
		yourself
]

{ #category : #'instance creation' }
CynPeriodicSend class >> interval: anInteger send: aSymbol to: anObject [

	^ self interval: anInteger messageSend: (MessageSend receiver: anObject selector: aSymbol)
]

{ #category : #initialization }
CynPeriodicSend >> initializeWithInterval: anInteger messageSend: aMessageSend [

	self initialize.

	interval := anInteger.
	messageSend := aMessageSend
]

{ #category : #accessing }
CynPeriodicSend >> interval [

	^ interval
]

{ #category : #actions }
CynPeriodicSend >> sendAndRepeat [

	"Send the message of the receiver and answer whether it should repeat"

	^ messageSend value
]
