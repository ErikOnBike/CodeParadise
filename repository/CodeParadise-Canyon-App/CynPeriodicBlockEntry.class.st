Class {
	#name : #CynPeriodicBlockEntry,
	#superclass : #Object,
	#instVars : [
		'periodicSend',
		'needsToRun'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CynPeriodicBlockEntry class >> interval: anInteger do: aMessageSend [

	^ self periodicBlock: (CynPeriodicBlock interval: anInteger do: aMessageSend)
]

{ #category : #'instance creation' }
CynPeriodicBlockEntry class >> periodicBlock: aPeriodicSend [

	^ self basicNew
		initializeWithPeriodicSend: aPeriodicSend ;
		yourself
]

{ #category : #actions }
CynPeriodicBlockEntry >> doAndRepeat [

	"Send the receiver's period send and answer whether it needs to repeat"

	^ periodicSend doAndRepeat
]

{ #category : #initialization }
CynPeriodicBlockEntry >> initializeWithPeriodicSend: aPeriodicSend [

	self initialize.

	periodicSend := aPeriodicSend.
	needsToRun := false
]

{ #category : #accessing }
CynPeriodicBlockEntry >> interval [

	^ periodicSend interval
]

{ #category : #testing }
CynPeriodicBlockEntry >> needsToRun [

	^ needsToRun
]

{ #category : #accessing }
CynPeriodicBlockEntry >> setNeedsToRun [

	"Mark the receiver as needing to be run"

	needsToRun := true
]
