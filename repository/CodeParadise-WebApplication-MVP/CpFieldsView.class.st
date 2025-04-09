"
I am a base class for Views which have input fields. I live in the browser.
I provide some convenience methods to allow updates to fields to be handled
with a minimal effort.

I support updates at key stroke level as well as 'commit' level, in which case
the entry field only changes when losing focus or pressing 'enter' key explicitly.
For updates on key strokes I apply a debouncing strategy. This prevents (too) many
announcements to be generated and send to the Presenter (which lives on the server).
Every subclass can specify how long a debounce period is used. By default (see
#debounceTime) this is 3 seconds. During this debounce period, changes are not send.
When the debounce period ends, the latest change value is announced to the server.
If during the debounce period a 'commit' level update takes place, the change IS
announced directly (without delay) and the debounce is discarded.

A subclass can choose to not use debouncing by either setting the debounceTime
to 0 or using the direct update method #field:changedTo:. To set a debounce time
on a field basis (different debounce times per input field) implement the class
method #debounceTimeForField:.

"
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

{ #category : #tags }
CpFieldsView class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'event handling' }
CpFieldsView >> attachEventHandlersFor: aSymbol to: anInputElement [

	anInputElement propertyAt: self fieldPropertyName put: aSymbol.

	anInputElement
		when: anInputElement inputEventClass send: #handleFieldChanged: to: self ;
		when: anInputElement changeEventClass send: #handleFieldChanged: to: self
]

{ #category : #'event handling' }
CpFieldsView >> field: aSymbol changedTo: anObject [

	"Announce the field with the specified name has changed to the specified value"

	self serverAnnounce: (self fieldChangedEventForId: aSymbol value: anObject)
]

{ #category : #accessing }
CpFieldsView >> fieldChangedEventForId: aSymbol value: anObject [

	"Answer a FieldChange event for the specified id and value"

	^ CpFieldChanged id: aSymbol value: anObject
]

{ #category : #accessing }
CpFieldsView >> fieldDebouncers [

	^ fieldDebouncers ifNil: [ fieldDebouncers := Dictionary new ]
]

{ #category : #accessing }
CpFieldsView >> fieldPropertyName [

	"Answer (an internal) name for storing the field identifier"

	^ #'__cp_fieldIdentifier'
]

{ #category : #'event handling' }
CpFieldsView >> handleChangeEvent: aChangeEvent forField: aSymbol [

	"Handle a change event for the specified field.
	A change event is triggered when an input's value is committed or the input
	lost focus. (See also #handleInputEvent:forField: and
	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/change_event)"

	| debounceTransition |

	debounceTransition := self fieldDebouncers at: aSymbol ifAbsent: [ nil ].

	"If a running debounce transition is available, stop it without running it"
	(debounceTransition isNotNil and: [ debounceTransition isRunning ])
		ifTrue: [ debounceTransition stop ].

	self field: aSymbol changedTo: (self valueFromEvent: aChangeEvent)
]

{ #category : #'event handling' }
CpFieldsView >> handleEvent: anEvent forField: aSymbol [

	"Handle the (Change or Input) Event for the specified field.

	Implementation:
	Use double dispatch to handle the specific event type."

	anEvent handleEventForField: aSymbol inView: self
]

{ #category : #'event handling' }
CpFieldsView >> handleFieldChanged: anEvent [

	"Handle the change (either Input or Change event) of the field.

	Implementation:
	The field identifier should be stored in the input element itself."

	| fieldIdentifier |

	fieldIdentifier := anEvent currentTarget ifNotNil: [ :target | target propertyAt: self fieldPropertyName ].
	fieldIdentifier ifNil: [
		self warnCr: 'Field event handler attached to field without field identifier'.
		^ self ].

	self handleEvent: anEvent forField: fieldIdentifier asSymbol
]

{ #category : #'event handling' }
CpFieldsView >> handleInputEvent: anInputEvent forField: aSymbol [

	"Handle an input event for the specified field.
	An input event is triggered when an input's value is changed.
	(See also #handleChangeEvent:forField: and
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
			debounceTransition := (CpTransition onBlock: [ self field: aSymbol changedTo: (self valueFromEvent: anInputEvent) ])
				duration: 0 "Execute once" ].

	"Set timeout for the debounce"
	debounceTransition startDelayedBy: (self class debounceTimeForField: aSymbol).

	self fieldDebouncers at: aSymbol put: debounceTransition
]

{ #category : #rendering }
CpFieldsView >> render: aString toInputAtSlotNamed: slotNameString [

	self render: aString toInputElement: (self firstChildAtSlotNamed: slotNameString)
]

{ #category : #rendering }
CpFieldsView >> render: aString toInputElement: inputElement [

	"If the input element has focus, do not render new value"
	inputElement hasFocus
		ifTrue: [ ^ self ].

	inputElement value: aString
]

{ #category : #rendering }
CpFieldsView >> render: aString toInputElementWithId: idString [

	self render: aString toInputElement: (self elementWithId: idString)
]

{ #category : #accessing }
CpFieldsView >> valueFromEvent: anEvent [

	"Answer the value (property) of the field that changed as specified by the change event"

	^ anEvent currentTarget propertyAt: #value
]
