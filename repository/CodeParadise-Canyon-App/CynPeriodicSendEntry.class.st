Class {
	#name : #CynPeriodicSendEntry,
	#superclass : #Object,
	#instVars : [
		'periodicSend',
		'needsToRun'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CynPeriodicSendEntry class >> interval: anInteger messageSend: aMessageSend [

	^ self periodicSend: (CynPeriodicSend interval: anInteger messageSend: aMessageSend)
]

{ #category : #'instance creation' }
CynPeriodicSendEntry class >> interval: anInteger send: aSymbol to: anObject [

	^ self periodicSend: (CynPeriodicSend interval: anInteger send: aSymbol to: anObject)
]

{ #category : #'instance creation' }
CynPeriodicSendEntry class >> periodicSend: aPeriodicSend [

	^ self basicNew
		initializeWithPeriodicSend: aPeriodicSend ;
		yourself
]

{ #category : #initialization }
CynPeriodicSendEntry >> initializeWithPeriodicSend: aPeriodicSend [

	self initialize.

	periodicSend := aPeriodicSend.
	needsToRun := false
]

{ #category : #accessing }
CynPeriodicSendEntry >> interval [

	^ periodicSend interval
]

{ #category : #testing }
CynPeriodicSendEntry >> needsToRun [

	^ needsToRun
]

{ #category : #actions }
CynPeriodicSendEntry >> sendAndRepeat [

	"Send the receiver's period send and answer whether it needs to repeat"

	^ periodicSend sendAndRepeat
]

{ #category : #accessing }
CynPeriodicSendEntry >> setNeedsToRun [

	"Mark the receiver as needing to be run"

	needsToRun := true
]
