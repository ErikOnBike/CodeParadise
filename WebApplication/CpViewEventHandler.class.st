"
I am a BrowserEventHandler and I am responsible for handling events of Views within a Model-View-Presenter pattern.
"
Class {
	#name : #CpViewEventHandler,
	#superclass : #Object,
	#category : #'WebApplication-Core'
}

{ #category : #accessing }
CpViewEventHandler class >> cpRequiredClasses [

	^ super cpRequiredClasses, { CpBrowserEventHandler }
]

{ #category : #'as yet unclassified' }
CpViewEventHandler class >> presenterWithId: identifier [

	^ CpClientEnvironment current objectRegistry objectWithId: identifier asSymbol
]

{ #category : #'as yet unclassified' }
CpViewEventHandler class >> viewWithId: identifier [

	"Since presenter and view share the same id, retrieve the presenter from the registry"

	^ (self presenterWithId: identifier) view
]

{ #category : #events }
CpViewEventHandler >> handleEvent: anEvent [

	| view |

	view := anEvent target.
	view canHandleEvents
		ifFalse: [ ^ self ].

	anEvent sendTo: view
]
