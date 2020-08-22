"
I am a Proxy for a View in a Model-View-Presenter pattern.
I only live in a ServerEnvironment.
"
Class {
	#name : #CpViewProxy,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #'instance creation' }
CpViewProxy class >> newIn: anEnvironment [

	^ self new
		environment: anEnvironment ;
		yourself
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

	^ environment
]

{ #category : #accessing }
CpViewProxy >> environment: anEnvironment [

	environment := anEnvironment
]

{ #category : #initialization }
CpViewProxy >> release [

	environment := nil.

	super release
]
