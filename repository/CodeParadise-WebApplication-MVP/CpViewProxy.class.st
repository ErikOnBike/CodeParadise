"
I am a Proxy for a View in a Model-View-Presenter pattern.
I only live in a ServerEnvironment.
"
Class {
	#name : #CpViewProxy,
	#superclass : #Object,
	#instVars : [
		'environment',
		'announcer'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'instance creation' }
CpViewProxy class >> newIn: anEnvironment [

	^ self new
		environment: anEnvironment ;
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

	| presenter |

	"Only presenters should send messages to views, the sender should therefore be a Presenter"
	presenter := thisContext sender receiver.

	self environment
		clientPerform: #performMessage:
		withArguments: { aMessage }
		receiver: presenter viewId
]

{ #category : #accessing }
CpViewProxy >> environment [

	"Answer the ServerEnvironment the receiver is running in"

	^ environment
]

{ #category : #accessing }
CpViewProxy >> environment: anEnvironment [

	environment := anEnvironment
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
	environment := nil.

	super release
]

{ #category : #announcing }
CpViewProxy >> when: anAnnouncementClass send: aSymbol to: anObject [

	"Let the sender subscribe to the specified announcement of the receiver.
	See Announcer>>#when:send:to:"

	^ self announcer when: anAnnouncementClass send: aSymbol to: anObject
]
