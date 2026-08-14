Class {
	#name : #WaRandomContent,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaRandomContent >> animation [

	"Entrance animation for newly shown children.
	
	Type: String
	Default: 'none'
	Allowed: 'none' | 'fade' | 'fade-up' | 'fade-down' | 'fade-left' | 'fade-right'"

	^ self propertyAt: #animation
]

{ #category : #accessing }
WaRandomContent >> animation: aString [

	"Entrance animation for newly shown children.
	
	Type: String
	Default: 'none'
	Allowed: 'none' | 'fade' | 'fade-up' | 'fade-down' | 'fade-left' | 'fade-right'"

	self propertyAt: #animation put: aString
]

{ #category : #accessing }
WaRandomContent >> autoplay [

	"Rotate the content automatically. Set the cadence with `autoplay-interval`.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #autoplay
]

{ #category : #accessing }
WaRandomContent >> autoplay: aBoolean [

	"Rotate the content automatically. Set the cadence with `autoplay-interval`.
	
	Type: Boolean
	Default: false"

	self propertyAt: #autoplay put: aBoolean
]

{ #category : #accessing }
WaRandomContent >> autoplayInterval [

	"Autoplay cadence in milliseconds.
	
	Type: Number
	Default: 3000"

	^ self propertyAt: #autoplayInterval
]

{ #category : #accessing }
WaRandomContent >> autoplayInterval: aNumber [

	"Autoplay cadence in milliseconds.
	
	Type: Number
	Default: 3000"

	self propertyAt: #autoplayInterval put: aNumber
]

{ #category : #'accessing - convenience' }
WaRandomContent >> beAutoplay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoplay: true
]

{ #category : #'accessing - convenience' }
WaRandomContent >> beNotAutoplay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoplay: false
]

{ #category : #accessing }
WaRandomContent >> items [

	"Number of children to show simultaneously. Clamped to [1, childCount].
	
	Type: Number
	Default: 1"

	^ self propertyAt: #items
]

{ #category : #accessing }
WaRandomContent >> items: aNumber [

	"Number of children to show simultaneously. Clamped to [1, childCount].
	
	Type: Number
	Default: 1"

	self propertyAt: #items put: aNumber
]

{ #category : #accessing }
WaRandomContent >> mode [

	"Selection strategy: `unique` (default), `random`, or `sequence`.
	
	Type: String
	Default: 'unique'
	Allowed: 'random' | 'unique' | 'sequence'"

	^ self propertyAt: #mode
]

{ #category : #accessing }
WaRandomContent >> mode: aString [

	"Selection strategy: `unique` (default), `random`, or `sequence`.
	
	Type: String
	Default: 'unique'
	Allowed: 'random' | 'unique' | 'sequence'"

	self propertyAt: #mode put: aString
]

{ #category : #actions }
WaRandomContent >> randomize [

	"Selects a new set of children using the current mode. Returns the elements now shown.
	
	Return type: Element[]"

	^ self apply: #randomize
]

{ #category : #'accessing - convenience' }
WaRandomContent >> slotNames [

	^ #()
]
