"
I represent a view-releated operation that gets performed periodically based on an interval.
When the (HTML) document my instances live in, is not visible, my instances will be
dormant and not be performed. As soon as the document becomes visible again, the
dormant operations are performed again. So there is no hard guarantee an operation is performed
within a given time frame.

My operation is represented by a Block. This Block is evaluated with the operation instance
as (optional) argument. This allows the Block to decide when to stop the operation. If not
stopped explicitly, the operation will keep performing indefinitely.
During evaluation of the Block, the operation can receive a new interval and/or a new Block.
This allows changing the operation's behavior.

My instances allow getting and setting properties on the operation. One example where this could
be useful is when the operation should only occur a maximum number of times. A property can be
used to keep track of the times it has been performed. This prevents having to add additional
instance variables where operations are already defined.

"
Class {
	#name : #CynPeriodicOperation,
	#superclass : #Object,
	#instVars : [
		'interval',
		'block',
		'timer',
		'needsToRun',
		'visibilityChangeListener',
		'properties'
	],
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #private }
CynPeriodicOperation class >> interval: anInteger do: aBlock [

	^ self basicNew
		initializeWithInterval: anInteger block: aBlock ;
		yourself
]

{ #category : #'instance creation' }
CynPeriodicOperation class >> prepareInterval: anInteger do: aBlock [

	^ (self interval: anInteger do: aBlock)
		prepare ;
		yourself
]

{ #category : #'instance creation' }
CynPeriodicOperation class >> startInterval: anInteger do: aBlock [

	^ (self interval: anInteger do: aBlock)
		perform ;
		yourself
]

{ #category : #accessing }
CynPeriodicOperation >> block: aBlock [

	"Update the Block allowing to change the behavior of the periodic block"

	aBlock ifNil: [ self error: 'PeriodicBlock requires actual Block' ].

	block := aBlock
]

{ #category : #initialization }
CynPeriodicOperation >> initialize [

	| document |

	super initialize.

	needsToRun := false.

	document := CpBrowserDocument current.

	"Add visibility change listener, allowing a postponed periodic send to continu"
	visibilityChangeListener := document addEventListener: #visibilitychange handler: [
		document isVisible
			ifTrue: [
				"Document has become visible again, perform outstanding periodic send"
				needsToRun
					ifTrue: [ self perform ] ] ]
]

{ #category : #initialization }
CynPeriodicOperation >> initializeWithInterval: anInteger block: aBlock [

	self initialize.

	interval := anInteger.
	self block: aBlock
]

{ #category : #accessing }
CynPeriodicOperation >> interval [

	^ interval
]

{ #category : #accessing }
CynPeriodicOperation >> interval: anInteger [

	"Update the interval of the receiver (can be changed from within the Block)"

	interval := anInteger
]

{ #category : #actions }
CynPeriodicOperation >> perform [

	"Perform the receiver's Block and prepare for a next run (if not stopped explicitly)"

	"Safety check the receiver is not already stopped"
	block ifNil: [ ^ self ].

	"Reset the timer"
	timer ifNotNil: [
		CpGlobalThis clearTimeout: timer.
		timer := nil ].

	"Perform the receiver's Block"
	block cull: self.

	"Did the receiver get stopped during performing the last run"
	block ifNil: [ ^ self ].

	"Prepare for next run"
	self prepare
]

{ #category : #private }
CynPeriodicOperation >> prepare [

	"Prepare performing the receiver"

	timer := CpGlobalThis setTimeout: self interval thenDo: [
		CpBrowserDocument current isVisible
			ifTrue: [ self perform ]
			ifFalse: [ needsToRun := true ] ]
]

{ #category : #accessing }
CynPeriodicOperation >> propertyAt: aSymbol [

	^ self propertyAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CynPeriodicOperation >> propertyAt: aSymbol ifAbsent: aBlock [

	properties ifNil: [ ^ aBlock value ].

	^ properties at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CynPeriodicOperation >> propertyAt: aSymbol ifAbsentPut: aBlock [

	^ (properties ifNil: [ properties := Dictionary new ])
		at: aSymbol ifAbsentPut: aBlock
]

{ #category : #accessing }
CynPeriodicOperation >> propertyAt: aSymbol put: anObject [

	^ (properties ifNil: [ properties := Dictionary new ])
		at: aSymbol put: anObject
]

{ #category : #initialization }
CynPeriodicOperation >> release [

	block := nil.

	timer ifNotNil: [
		CpGlobalThis clearTimeout: timer.
		timer := nil ].

	visibilityChangeListener ifNotNil: [
		CpBrowserDocument current
			removeEventListener: visibilityChangeListener.
		visibilityChangeListener := nil ].

	super release
]

{ #category : #actions }
CynPeriodicOperation >> stop [

	self release
]
