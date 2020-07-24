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

{ #category : #'event handling' }
CpViewEventHandler >> handleBeforeInputEvent: aBeforeInputEvent [

	self flag: #todo. "Add focus handler which knows where to send input events"
	"Do allow for multiple active cursors at the same time. Both for updating the
	same text/selection (you selected all occurences of a specific word and start
	changing all occurrences at once) and for allowing remote users with their
	own cursors (mentors joining in on sessions or cooperation between kids)."

	(CpHtmlElement documentBody allDescendantsMatching: #'cp-cursor') do: [ :each |
		aBeforeInputEvent sendTo: each ]
]

{ #category : #'event handling' }
CpViewEventHandler >> handleEvent: anEvent [

	self flag: #todo. "Needs to be refactored in Pointer event handler and Input event handler"

	anEvent isPointerEvent
		ifTrue: [ self handlePointerEvent: anEvent ].

	anEvent isInputEvent
		ifTrue: [ self handleInputEvent: anEvent ]
]

{ #category : #'event handling' }
CpViewEventHandler >> handleInputEvent: anInputEvent [

	self flag: #todo. "Add focus handler which knows where to send input events"
	"Do allow for multiple active cursors at the same time. Both for updating the
	same text/selection (you selected all occurences of a specific word and start
	changing all occurrences at once) and for allowing remote users with their
	own cursors (mentors joining in on sessions or cooperation between kids)."

	(CpHtmlElement documentBody allDescendantsMatching: #'cp-cursor') do: [ :each |
		anInputEvent sendTo: each ]
]

{ #category : #'event handling' }
CpViewEventHandler >> handlePointerEvent: aPointerEvent [

	| view |

	view := aPointerEvent target.
	view canHandleEvents
		ifFalse: [ ^ self ].

	aPointerEvent sendTo: view
]
