Class {
	#name : #CpFieldsView,
	#superclass : #CpView,
	#instVars : [
		'fieldDebouncers'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #accessing }
CpFieldsView class >> debounceTime [

	"Answer the time (in milliseconds) to delay for input events"

	^ 3000
]

{ #category : #accessing }
CpFieldsView class >> debounceTimeForField: aSymbol [

	"Answer the time (in milliseconds) to delay for input events
	on the specified field.
	Subclasses might change this for specific fields."

	^ self debounceTime
]

{ #category : #testing }
CpFieldsView class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'event handling' }
CpFieldsView >> field: aSymbol changedTo: anObject [

	"Announce the field with the specified name has changed to the specified value"

	self serverAnnounce: (CpFieldChanged field: aSymbol value: anObject)
]

{ #category : #accessing }
CpFieldsView >> fieldDebouncers [

	^ fieldDebouncers ifNil: [ fieldDebouncers := Dictionary new ]
]

{ #category : #'event handling' }
CpFieldsView >> handleChangeEvent: aChangeEvent forField: aSymbol [

	"Handle a change event for the specified field.
	A change event is triggered when an input's value is committed or the input
	lost focus. (See also #onInputEvent:forField: and
	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/change_event)"

	| debounceTransition |

	debounceTransition := self fieldDebouncers at: aSymbol ifAbsent: [ nil ].

	"If a running debounce transition is available, stop it without running it"
	(debounceTransition isNotNil and: [ debounceTransition isRunning ])
		ifTrue: [ debounceTransition stop ].

	self field: aSymbol changedTo: aChangeEvent target value
]

{ #category : #'event handling' }
CpFieldsView >> handleInputEvent: anInputEvent forField: aSymbol [

	"Handle an input event for the specified field.
	An input event is triggered when an input's value is changed.
	(See also #onChangeEvent:forField: and
	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/input_event)"

	| debounceTransition |

	debounceTransition := self fieldDebouncers at: aSymbol ifAbsent: [ nil ].

	"If a running debounce transition is available, we're done"
	(debounceTransition isNotNil and: [ debounceTransition isRunning ])
		ifTrue: [ ^ self ].

	"Create new debounce transition, run it once"
	debounceTransition
		ifNotNil: [ debounceTransition stop ]
		ifNil: [
			debounceTransition := (CpTransition onBlock: [ self field: aSymbol changedTo: anInputEvent target value ])
				duration: 0 "Execute once" ].

	"Set timeout for the debounce"
	debounceTransition startDelayedBy: (self class debounceTimeForField: aSymbol).

	self fieldDebouncers at: aSymbol put: debounceTransition
]
