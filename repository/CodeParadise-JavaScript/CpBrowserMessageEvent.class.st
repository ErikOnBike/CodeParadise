Class {
	#name : #CpBrowserMessageEvent,
	#superclass : #CpBrowserEvent,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #accessing }
CpBrowserMessageEvent >> data [

	"The data sent by the message emitter."

	^ self propertyAt: #data
]

{ #category : #accessing }
CpBrowserMessageEvent >> lastEventId [

	"A string representing a unique ID for the event."

	^ self propertyAt: #lastEventId
]

{ #category : #accessing }
CpBrowserMessageEvent >> origin [

	"A string representing the origin of the message emitter."

	^ self propertyAt: #origin
]

{ #category : #accessing }
CpBrowserMessageEvent >> ports [

	"An array of MessagePort objects containing all MessagePort objects sent with the message, in order."

	^ self propertyAt: #ports
]

{ #category : #accessing }
CpBrowserMessageEvent >> source [

	"A MessageEventSource (which can be a WindowProxy, MessagePort, or ServiceWorker object) representing the message emitter."

	^ self propertyAt: #source
]
