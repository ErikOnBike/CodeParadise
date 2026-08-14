Class {
	#name : #WaToast,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #actions }
WaToast >> create: aString [

	"Creates a toast notification programmatically and adds it to the stack. Returns a reference to the created toast
	item element.
	
	Return type: Promise<WaToastItem>
	Parameter: message (string)"

	^ self apply: #create withArguments: { aString }
]

{ #category : #actions }
WaToast >> create: aString options: anObject [

	"Creates a toast notification programmatically and adds it to the stack. Returns a reference to the created toast
	item element.
	
	Return type: Promise<WaToastItem>
	Parameter: message (string)
	Parameter: options (ToastCreateOptions)"

	^ self apply: #create withArguments: { aString . anObject }
]

{ #category : #accessing }
WaToast >> placement [

	"The placement of the toast stack on the screen.
	
	Type: String
	Default: 'top-end'
	Allowed: 'top-start' | 'top-center' | 'top-end' | 'bottom-start' | 'bottom-center' | 'bottom-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaToast >> placement: aString [

	"The placement of the toast stack on the screen.
	
	Type: String
	Default: 'top-end'
	Allowed: 'top-start' | 'top-center' | 'top-end' | 'bottom-start' | 'bottom-center' | 'bottom-end'"

	self propertyAt: #placement put: aString
]

{ #category : #'accessing - convenience' }
WaToast >> placementBottomCenter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-center'
]

{ #category : #'accessing - convenience' }
WaToast >> placementBottomEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-end'
]

{ #category : #'accessing - convenience' }
WaToast >> placementBottomStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-start'
]

{ #category : #'accessing - convenience' }
WaToast >> placementTopCenter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-center'
]

{ #category : #'accessing - convenience' }
WaToast >> placementTopEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-end'
]

{ #category : #'accessing - convenience' }
WaToast >> placementTopStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-start'
]

{ #category : #'accessing - convenience' }
WaToast >> slotNames [

	^ #()
]
