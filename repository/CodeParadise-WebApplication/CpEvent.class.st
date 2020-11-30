"
I am the base class for Events. I also implement the same protocol as the Announcement class for announcing. 

Implementation:
My class name should match the browser's event type (Event.type, see https://wiki.developer.mozilla.org/en-US/docs/Web/API/Event/type). So event type ""pointermove"" did become CpPointerMoveEvent. The class name prefix #Cp and the class name postfix #Event are discarded for comparison. Please prevent having similar names like #CpPointerMove or #CpPointermoveEvent, because only one will be used (more specific, last being installed in the ClientEnvironment).

"
Class {
	#name : #CpEvent,
	#superclass : #Object,
	#instVars : [
		'timeStamp',
		'type',
		'target'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #announcing }
CpEvent class >> handlesAnnouncement: anAnnouncement [

	"The receiver acts as a filter to determine whether subscribers who used the receiver as signaling tag (event identifier class or symbol)
	should receive incoming announcement. In particular, registering to a superclass will receive the announcements from all subclasses.
	See Announcement >> #handlesAnnouncement:"

	^ anAnnouncement class includesBehavior: self
]

{ #category : #announcing }
CpEvent >> asAnnouncement [

	^ self
]

{ #category : #sending }
CpEvent >> dispatch [

	self hasTarget
		ifFalse: [ ^ self ].
	self target canHandleEvents
		ifTrue: [ self sendTo: self target ].

	self target announce: self
]

{ #category : #testing }
CpEvent >> hasTarget [

	^ target notNil
]

{ #category : #announcing }
CpEvent >> prepareForDelivery [

	"This method will be executed once before subscriptions delivery.
	If nobody subscribed on me this method will not be called.
	It allows to put some heavy initialization logic here. It will be executed only 
	if there is interest on me
	See Announcement >> #prepareForDelivery"
]

{ #category : #printing }
CpEvent >> printOn: aStream [

	self class name printOn: aStream.
	aStream nextPutAll: ', type: '.
	self type printOn: aStream.
	aStream nextPutAll: ', timeStamp: '.
	self timeStamp printOn: aStream.
	aStream nextPutAll: ', target: '.
	self target printOn: aStream
]

{ #category : #visiting }
CpEvent >> sendTo: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
CpEvent >> target [

	^ target
]

{ #category : #accessing }
CpEvent >> target: aDomElement [

	target := aDomElement
]

{ #category : #accessing }
CpEvent >> timeStamp [

	"Answer the relative timestamp (a Number) for when the receiver was triggered"

	^ timeStamp
]

{ #category : #accessing }
CpEvent >> timeStamp: aNumber [

	"Set the relative timestamp for when the receiver was triggered"

	timeStamp := aNumber
]

{ #category : #accessing }
CpEvent >> type [

	^ type
]

{ #category : #accessing }
CpEvent >> type: aString [

	type := aString
]
