"
I am a custom event. My instances can be created and triggered by the browser.
Third party Javascript libraries sometimes use custom events and I am compatible
with them. My instances can contain a 'detail' object (either Number, String,
Boolean value or a Dictionary containing these values).

"
Class {
	#name : 'CpCustomEvent',
	#superclass : 'CpEvent',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}

{ #category : 'instance creation' }
CpCustomEvent class >> new [

	^ self newWithDetail: nil
]

{ #category : 'instance creation' }
CpCustomEvent class >> newWithDetail: anObject [

	^ self basicNew
		initializeWithDetail: anObject ;
		yourself
]

{ #category : 'private' }
CpCustomEvent >> createWithDetail: anObject [

	"Create the actual JS CustomEvent underlying the receiver with the specified detail.
	This method should be executed exactly once for every event being instantiated/used."

	<primitive: 'primitiveCustomEventCreateWithDetail:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : 'accessing' }
CpCustomEvent >> detail [

	"Answer the detail of the receiver.
	Detail can be either a Dictionary like object or a String, Number, Boolean or nil."

	^ self propertyAt: #detail
]

{ #category : 'dispatching' }
CpCustomEvent >> dispatchFrom: anElement [

	"Dispatch the receiver from the specified element"

	<primitive: 'primitiveCustomEventDispatchFrom:' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : 'initialization' }
CpCustomEvent >> initializeWithDetail: anObject [

	self initialize.

	self createWithDetail: anObject
]

{ #category : 'printing' }
CpCustomEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name ;
		nextPutAll: ' detail: ' ;
		print: self detail
]
