"
I am a synthetic event. My instances can be created without an actual browser event
taking place. My instances will NOT be announced (triggered) by the browser either.
To allow the browser to announce events, use the CpCustomEvent class.

"
Class {
	#name : 'CpSyntheticEvent',
	#superclass : 'CpBaseEvent',
	#instVars : [
		'currentTarget',
		'timeStamp',
		'modifiers',
		'stopPropagation',
		'stopAfter'
	],
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'announcing' }
CpSyntheticEvent class >> addListenerTo: anElement [

	"Add a listener for the receiver to the specified DOM element.
	Since no actual browser event exists, ignore this.

	Subclasses might override this and add other (typically non-
	synthetic) events to the specified element. See for example
	CpAnyClickEvent or CpDragEvent subclasses."

]

{ #category : 'announcing' }
CpSyntheticEvent class >> handlesAnnouncement: anAnnouncement [

	"Answer whether the specified Announcement can be handled by the receiver.
	If the Announcement is already stopped, prevent further handling."

	^ (super handlesAnnouncement: anAnnouncement)
		and: [ anAnnouncement isStopped not ]
]

{ #category : 'announcing' }
CpSyntheticEvent class >> removeListenerFrom: anElement [

	"Remove a listener for the receiver from the specified DOM element.
	Since no actual browser event exists, ignore this.

	Subclasses might override this and add other (typically non-
	synthetic) events to the specified element. See for example
	CpAnyClickEvent or CpDragEvent subclasses."

]

{ #category : 'accessing' }
CpSyntheticEvent >> currentTarget [

	^ currentTarget
]

{ #category : 'dispatching' }
CpSyntheticEvent >> dispatch [

	"Dispatch the receiver (if not stopped)"

	self isStopped
		ifTrue: [ ^ self ].

	super dispatch
]

{ #category : 'initialization' }
CpSyntheticEvent >> initialize [

	super initialize.

	"By default, no modifiers"
	modifiers := 0.

	"By default events propagate (bubble) up"
	stopPropagation := false
]

{ #category : 'testing' }
CpSyntheticEvent >> isStopped [

	"Answer whether the receiver is stopped (ie should not be dispatched anymore).

	Implementation:
	Validate for stopPropagation vs stopImmediatePropagation based on value of
	#stopAfter. See #stopPropagation and #stopImmediatePropagation methods."

	stopPropagation
		ifTrue: [
			stopAfter ifNil: [ ^ true ].

			"Continue if stopPropagation is used on the currentTarget
			instead of stopImmediatePropagation"
			stopAfter == currentTarget
				ifFalse: [
					stopAfter := nil.
					currentTarget := nil.
					^ true ] ].

	^ false
]

{ #category : 'accessing' }
CpSyntheticEvent >> modifiers [

	"Answer an Integer specifying the different modifiers pressed.
	See superclass' implementation for details."

	^ modifiers
]

{ #category : 'printing' }
CpSyntheticEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ' timeStamp: ' ;
		print: timeStamp ;
		nextPutAll: ', modifiers: ' ;
		print: modifiers ;
		nextPutAll: ', currentTarget: ' ;
		print: currentTarget ;
		nextPutAll: ', propagate: ' ;
		nextPutAll: (stopPropagation ifTrue: [ stopAfter ifNotNil: [ 'stop' ] ifNil: [ 'stopImmediate' ] ] ifFalse: [ 'normal' ])
]

{ #category : 'initialization' }
CpSyntheticEvent >> release [

	currentTarget := nil.
	timeStamp := nil.
	stopPropagation := nil.
	stopAfter := nil.

	super release
]

{ #category : 'dispatching' }
CpSyntheticEvent >> resetPropagation [

	"Allow propagation (bubbling) of the receiver"

	stopPropagation := false.
	stopAfter := nil
]

{ #category : 'dispatching' }
CpSyntheticEvent >> stopImmediatePropagation [

	"Stop propagation (bubbling) of the receiver. Not even listeners on the
	current target will receive this event. Use #stopPropagation instead
	to allow other listeners on the current target to receive this event."

	stopPropagation := true.
	stopAfter := nil
]

{ #category : 'dispatching' }
CpSyntheticEvent >> stopPropagation [

	"Stop propagation (bubbling) of the receiver. Other listeners on the
	current target will receive this event. Use #stopImmediatePropagation
	instead to prevent any listener from receiving this event."

	stopPropagation := true.
	stopAfter := currentTarget
]

{ #category : 'accessing' }
CpSyntheticEvent >> target [

	"Answer the target of the receiver.

	Implementation:
	For synthetic events this is (by default) the current target.
	Subclasses might override this."

	^ self currentTarget
]

{ #category : 'accessing' }
CpSyntheticEvent >> timeStamp [

	^ timeStamp
]
