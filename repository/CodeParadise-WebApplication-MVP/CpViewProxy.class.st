"
I am a Proxy for a View in a Model-View-Presenter pattern.
I only live in a ServerEnvironment.
"
Class {
	#name : #CpViewProxy,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'viewClass',
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpViewProxy class >> allInstancesForViewClass: aClass [

	<serverEnvironment>

	"Answer a collection of instances of the receiver which refer to the
	specified view class"

	^ self allInstances
		select: [ :each | each viewClass == aClass ]
]

{ #category : #accessing }
CpViewProxy class >> allInstancesForViewClass: aClass do: aBlock [

	<serverEnvironment>

	"Perform the specified block for all instances of the receiver
	which refer to the specified view class"

	self allInstancesDo: [ :each |
		each viewClass == aClass
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #'instance creation' }
CpViewProxy class >> new [

	self errorNewReplacedBy: #newForPresenter:
]

{ #category : #'instance creation' }
CpViewProxy class >> newForPresenter: aPresenter [

	^ self basicNew
		initializeWithPresenter: aPresenter ;
		yourself
]

{ #category : #announcing }
CpViewProxy >> announce: anAnnouncement [

	"Sanity check"
	announcer ifNil: [ ^ self ].

	announcer announce: anAnnouncement
]

{ #category : #accessing }
CpViewProxy >> announcer [

	"Answer the Announcer of the receiver"

	^ announcer
]

{ #category : #removing }
CpViewProxy >> destroy [

	"Destroy the view.

	Implementation: The receiver's presenter is removed to indicate the view no longer
	exists. Any messages send to the view will be silently ignored."

	presenter ifNil: [ ^ self ].

	self doesNotUnderstand: (Message selector: #destroy).

	presenter := nil
]

{ #category : #'reflective operations' }
CpViewProxy >> doesNotUnderstand: aMessage [

	"Let the presenter send the message to the actual view"

	presenter ifNotNil: [ :actualPresenter | actualPresenter sendMessageToView: aMessage ]
]

{ #category : #accessing }
CpViewProxy >> id [

	^ presenter ifNotNil: [ :actualPresenter | actualPresenter id ]
]

{ #category : #initialization }
CpViewProxy >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #initialization }
CpViewProxy >> initializeWithPresenter: aPresenter [

	self initialize.

	presenter := aPresenter
]

{ #category : #initialization }
CpViewProxy >> release [

	announcer ifNotNil: [ 
		announcer release.
		announcer := nil ].
	presenter := nil.
	viewClass := nil.

	super release
]

{ #category : #removing }
CpViewProxy >> remove [ 

	"Remove the receiver from its parent.

	Implementation: This method is defined on CpDomElement. Because it could also be an extension
	method for Object (when using Voyage for example), explicitly pass the method to the actual
	view. Otherwise the extension method #remove will be called."

	self doesNotUnderstand: (Message selector: #remove)
]

{ #category : #accessing }
CpViewProxy >> viewClass [

	"Answer the Class of the View the receiver is proxying"

	^ viewClass
]

{ #category : #accessing }
CpViewProxy >> viewClass: aViewClass [

	viewClass := aViewClass
]

{ #category : #announcing }
CpViewProxy >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
