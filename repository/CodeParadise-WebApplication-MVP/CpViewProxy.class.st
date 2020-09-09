"
I am a Proxy for a View in a Model-View-Presenter pattern.
I only live in a ServerEnvironment.
"
Class {
	#name : #CpViewProxy,
	#superclass : #Object,
	#instVars : [
		'viewClass',
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

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

	| presenter |

	"Only presenters should send messages to views, the sender should therefore be a Presenter"
	presenter := thisContext sender receiver.
	presenter isPresenter
		ifFalse: [ self error: 'Only presenters are allowed to send messages to the view (through the CpViewProxy)' ].

	presenter sendMessageToView: aMessage
]

{ #category : #initialization }
CpViewProxy >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #initialization }
CpViewProxy >> release [

	announcer ifNotNil: [ 
		announcer subscriptions reset.
		announcer := nil ].

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
