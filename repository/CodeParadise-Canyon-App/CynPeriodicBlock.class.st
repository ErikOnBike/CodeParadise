Class {
	#name : #CynPeriodicBlock,
	#superclass : #Object,
	#instVars : [
		'interval',
		'block'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'instance creation' }
CynPeriodicBlock class >> interval: anInteger do: aBlock [

	^ self basicNew
		initializeWithInterval: anInteger block: aBlock ;
		yourself
]

{ #category : #accessing }
CynPeriodicBlock >> block: aBlock [

	"Update the Block allowing to change the behavior of the periodic block"

	block := aBlock
]

{ #category : #actions }
CynPeriodicBlock >> doAndRepeat [

	"Evaluate the Block of the receiver and answer whether it should repeat.
	The Block receives the receiver as (optional) argument, allowing it to
	change the interval period (or execution Block)."

	^ block cull: self
]

{ #category : #initialization }
CynPeriodicBlock >> initializeWithInterval: anInteger block: aBlock [

	self initialize.

	interval := anInteger.
	block := aBlock
]

{ #category : #accessing }
CynPeriodicBlock >> interval [

	^ interval
]

{ #category : #accessing }
CynPeriodicBlock >> interval: anInteger [

	"Update the interval of the receiver (can be changed from within the Block)"

	interval := anInteger
]
