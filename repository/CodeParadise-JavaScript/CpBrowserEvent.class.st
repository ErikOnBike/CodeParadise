"
I represent the generic base Event class for Browsers and NodeJS.
Do not confuse me with the CpEvent class which is Browser specific and offers
additional functionality related to DOM event handling and custom (DOM) events.
My subclasses are typically used for non-DOM related events like the
CpBrowserMessageEvent.
"
Class {
	#name : #CpBrowserEvent,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #accessing }
CpBrowserEvent >> bubbles [

	"A boolean value indicating whether or not the event bubbles up through the DOM. (Browser only)"

	^ self propertyAt: #bubbles
]

{ #category : #accessing }
CpBrowserEvent >> cancelable [

	"A boolean value indicating whether the event is cancelable."

	^ self propertyAt: #cancelable
]

{ #category : #accessing }
CpBrowserEvent >> currentTarget [

	"A reference to the currently registered target for the event. This is the object to which the event is currently slated to be sent. It's possible this has been changed along the way through retargeting."

	^ self propertyAt: #currentTarget
]

{ #category : #accessing }
CpBrowserEvent >> defaultPrevented [

	"Indicates whether or not the call to event.preventDefault() canceled the event."

	^ self propertyAt: #defaultPrevented
]

{ #category : #operations }
CpBrowserEvent >> preventDefault [

	"Cancels the event (if it is cancelable)."

	self apply: #preventDefault
]

{ #category : #operations }
CpBrowserEvent >> stopImmediatePropagation [

	"For this particular event, prevent all other listeners from being called. This includes listeners attached to the same element as well as those attached to elements that will be traversed later (during the capture phase, for instance)."

	self apply: #stopImmediatePropagation
]

{ #category : #operations }
CpBrowserEvent >> stopPropagation [

	"Stops the propagation of events further along in the DOM. (Browser only)"

	self apply: #stopPropagation
]

{ #category : #accessing }
CpBrowserEvent >> target [

	"A reference to the object to which the event was originally dispatched."

	^ self propertyAt: #target
]

{ #category : #accessing }
CpBrowserEvent >> timeStamp [

	"The time at which the event was created (in milliseconds). By specification, this value is time since epoch—but in reality, browsers' definitions vary. In addition, work is underway to change this to be a DOMHighResTimeStamp instead."

	^ self propertyAt: #timeStamp
]

{ #category : #accessing }
CpBrowserEvent >> type [

	"The name identifying the type of the event."

	^ self propertyAt: #type
]
