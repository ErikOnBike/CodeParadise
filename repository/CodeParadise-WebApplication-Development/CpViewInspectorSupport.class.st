Class {
	#name : #CpViewInspectorSupport,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'CodeParadise-WebApplication-Development-Support'
}

{ #category : #'event handling' }
CpViewInspectorSupport class >> clientLoaded: aClientLoaded [

	"A new client is loaded create a new instance of the receiver
	(it will register as listener to the environment and therefore remain 'alive')"

	| applicationClass |

	"Only install instances of the receiver in WebApplications"
	applicationClass := CpServerApplication applicationClassWithId: aClientLoaded app.
	(applicationClass isNil or: [ applicationClass isWebApplication not ])
		ifTrue: [ ^ self ].

	^ self on: aClientLoaded environment
]

{ #category : #'class initialization' }
CpViewInspectorSupport class >> initialize [

	CpServerEnvironment whenClientLoadedSend: #clientLoaded: to: self
]

{ #category : #'instance creation' }
CpViewInspectorSupport class >> on: anEnvironment [

	| instance |

	instance := self basicNew
		initializeWithEnvironment: anEnvironment ;
		yourself.

	self traceCr: 'ViewInspector installed ', instance printString.

	^ instance
]

{ #category : #'class initialization' }
CpViewInspectorSupport class >> release [

	<script>

	CpServerEnvironment unsubscribe: self
]

{ #category : #initialization }
CpViewInspectorSupport >> initializeWithEnvironment: anEnvironment [

	self initialize.

	environment := anEnvironment.

	environment
		addClass: CpViewInspectorView ;
		when: CpViewInspectorRequest send: #viewInspectorRequest: to: self
]

{ #category : #'event handling' }
CpViewInspectorSupport >> viewInspectorRequest: aViewInspectorRequest [

	aViewInspectorRequest performIn: environment
]
