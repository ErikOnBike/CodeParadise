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

{ #category : #'instance creation' }
CpViewProxy class >> new [

	self shouldNotImplement
]

{ #category : #'instance creation' }
CpViewProxy class >> newFor: aPresenter [

	^ self basicNew
		initializeWith: aPresenter ;
		yourself
]

{ #category : #announcing }
CpViewProxy >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpViewProxy >> announcer [

	"Answer the Announcer of the receiver"

	^ announcer
]

{ #category : #'reflective operations' }
CpViewProxy >> doesNotUnderstand: aMessage [

	"Let the presenter send the message to the actual view"

	self presenter sendMessageToView: aMessage
]

{ #category : #initialization }
CpViewProxy >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #initialization }
CpViewProxy >> initializeWith: aPresenter [

	self initialize.

	presenter := aPresenter
]

{ #category : #accessing }
CpViewProxy >> presenter [

	^ presenter
]

{ #category : #initialization }
CpViewProxy >> release [

	announcer ifNotNil: [ 
		announcer subscriptions reset.
		announcer := nil ].
	presenter := nil.
	viewClass := nil.

	super release
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
