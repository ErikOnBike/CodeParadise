Class {
	#name : #CpPrimaryClickEvent,
	#superclass : #CpAnyClickEvent,
	#classVars : [
		'StopPropagationFrom'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #testing }
CpPrimaryClickEvent class >> handlesClickEvent: aClickEvent [

	"Accept only primary click"

	^ aClickEvent isPrimaryButtonPressed
]

{ #category : #testing }
CpPrimaryClickEvent class >> isClickStopped: aClickEvent [

	"Answer whether the specified click event is stopped
	because a PrimaryClickEvent prevented propagation.

	Implementation:
	If the document (root) is reached, reset the propagation mechanism.
	See also #postInstallOnce"

	| currentTarget isStopped |

	currentTarget := aClickEvent currentTarget.

	"Is event propagation stopped?"
	isStopped := StopPropagationFrom
		ifNotNil: [ currentTarget == StopPropagationFrom or: [ StopPropagationFrom isDescendantOf: currentTarget ] ]
		ifNil: [ false ].

	"If bubbling reached the document root, reset propagation mechanism"
	CpHtmlElement document == currentTarget
		ifTrue: [ self resetStopPropagationFrom ].

	^ isStopped
]

{ #category : #'class initialization' }
CpPrimaryClickEvent class >> postInstallOnce [

	"Make sure stop propagation does not prevent future clicks from working.

	Implementation:
	Install a click event handler on the document, but make it a no operation.
	In #isClickStopped: a check will be made for this event and it will reset
	the propagation handling."

	| document |
	
	(document := CpHtmlElement document)
		when: CpClickEvent send: #noop to: document
]

{ #category : #accessing }
CpPrimaryClickEvent class >> resetStopPropagationFrom [

	StopPropagationFrom := nil
]

{ #category : #accessing }
CpPrimaryClickEvent class >> stopPropagationFrom: anElement [

	"Store the DOM element from which point propagation is prevented.
	If anElement receives a Click event, it should ignore it."

	StopPropagationFrom := anElement
]

{ #category : #testing }
CpPrimaryClickEvent >> isPrimaryButtonPressed [

	^ true
]

{ #category : #testing }
CpPrimaryClickEvent >> isSecondaryButtonPressed [

	^ false
]

{ #category : #dispatching }
CpPrimaryClickEvent >> stopImmediatePropagation [

	"Stop immediate propagation of the receiver.

	Implementation:
	Since a 'native' CpClickEvent is similar, it should not propagate
	either. So store the location from which propagation to stop.
	This allows CpClickEvent to check for this situation."

	self class stopPropagationFrom: self currentTarget.

	super stopImmediatePropagation
]

{ #category : #dispatching }
CpPrimaryClickEvent >> stopPropagation [

	"Stop propagation of the receiver.

	Implementation:
	Since a 'native' CpClickEvent is similar, it should not propagate
	either. So store the location from which propagation to stop.
	This allows CpClickEvent to check for this situation."

	self class stopPropagationFrom: self currentTarget parent.

	super stopPropagation
]
