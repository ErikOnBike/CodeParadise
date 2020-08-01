"
I am a BrowserEventHandler and I am responsible for handling events of Views within a Model-View-Presenter pattern.
"
Class {
	#name : #CpViewEventHandler,
	#superclass : #CpBaseEventHandler,
	#category : #'CodeParadise-WebApplication-MVP-Core'
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

{ #category : #'event handling' }
CpViewEventHandler >> handleEvent: anEvent [

	self flag: #todo. "Needs to be refactored in pointer event handler and text entry event handler"

	anEvent isPointerEvent
		ifTrue: [ ^ self handlePointerEvent: anEvent ].

	anEvent isTextEntryEvent
		ifTrue: [ ^ self handleTextEntryEvent: anEvent ]
]

{ #category : #'event handling' }
CpViewEventHandler >> handlePointerEvent: aPointerEvent [

	| view |

	view := aPointerEvent target.
	view canHandleEvents
		ifFalse: [ ^ self ].

	aPointerEvent sendTo: view
]

{ #category : #'event handling' }
CpViewEventHandler >> handleTextEntryEvent: anEvent [

	self flag: #todo. "Add focus handler which knows where to send text entry events"
	"Do allow for multiple active cursors at the same time. Both for updating the
	same text/selection (you selected all occurences of a specific word and start
	changing all occurrences at once) and for allowing remote users with their
	own cursors (mentors joining in on sessions or cooperation between kids)."

	(CpHtmlElement documentBody allDescendantsMatching: #'cp-cursor') do: [ :each |
		anEvent sendTo: each ]
]
