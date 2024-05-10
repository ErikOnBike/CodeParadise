"
I represent both the Browser Event and the Node.js Event.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpJavaScriptEvent,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #accessing }
CpJavaScriptEvent >> cancelable [

	"A boolean value indicating whether the event is cancelable."

	^ self propertyAt: #cancelable
]

{ #category : #accessing }
CpJavaScriptEvent >> currentTarget [

	"A reference to the currently registered target for the event. This is the object to which the event is currently slated to be sent. It's possible this has been changed along the way through retargeting."

	^ self propertyAt: #currentTarget
]

{ #category : #accessing }
CpJavaScriptEvent >> defaultPrevented [

	"Indicates whether or not the call to event.preventDefault() canceled the event."

	^ self propertyAt: #defaultPrevented
]

{ #category : #accessing }
CpJavaScriptEvent >> isTrusted [

	"Indicates whether or not the event was initiated by the browser (after a user click, for instance) or by a script (using an event creation method, for example)."

	^ self propertyAt: #isTrusted
]

{ #category : #operations }
CpJavaScriptEvent >> preventDefault [

	"Cancels the event (if it is cancelable)."

	self apply: #preventDefault
]

{ #category : #operations }
CpJavaScriptEvent >> stopImmediatePropagation [

	"For this particular event, prevent all other listeners from being called. This includes listeners attached to the same element as well as those attached to elements that will be traversed later (during the capture phase, for instance).
	(Only usable in Browser)"

	self apply: #stopImmediatePropagation
]

{ #category : #operations }
CpJavaScriptEvent >> stopPropagation [

	"Stops the propagation of events further along in the DOM.
	(Only usable in Browser)"

	self apply: #stopPropagation
]

{ #category : #accessing }
CpJavaScriptEvent >> target [

	"A reference to the object to which the event was originally dispatched."

	^ self propertyAt: #target
]

{ #category : #accessing }
CpJavaScriptEvent >> timeStamp [

	"The time at which the event was created (in milliseconds). By specification, this value is time since epoch—but in reality, browsers' definitions vary. In addition, work is underway to change this to be a DOMHighResTimeStamp instead."

	^ self propertyAt: #timeStamp
]

{ #category : #accessing }
CpJavaScriptEvent >> type [

	"The name identifying the type of the event."

	^ self propertyAt: #type
]
