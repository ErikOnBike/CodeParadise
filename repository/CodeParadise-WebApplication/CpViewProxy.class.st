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
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #'reflective operations' }
CpViewProxy class >> doesNotUnderstand: aMessage [

	| presenter |

	presenter := thisContext sender receiver.

	presenter webApplication
		remotePerform: #viewClassPerform:
		withArguments: {
			presenter id.
			aMessage selector.
			aMessage arguments }
]

{ #category : #'instance creation' }
CpViewProxy class >> newIn: anEnvironment [

	^ self new
		environment: anEnvironment ;
		yourself
]

{ #category : #'reflective operations' }
CpViewProxy >> doesNotUnderstand: aMessage [

	| presenter |

	presenter := thisContext sender receiver.

	self environment
		clientPerform: #viewPerform:
		withArguments: { { aMessage selector . aMessage arguments } }
		receiver: presenter id
]

{ #category : #accessing }
CpViewProxy >> environment [

	^ environment
]

{ #category : #accessing }
CpViewProxy >> environment: anEnvironment [

	environment := anEnvironment
]

{ #category : #dependencies }
CpViewProxy >> release [

	environment := nil.

	super release
]
