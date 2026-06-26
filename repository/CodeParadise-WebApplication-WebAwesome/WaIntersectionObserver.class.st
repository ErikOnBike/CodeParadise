Class {
	#name : #WaIntersectionObserver,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaIntersectionObserver >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaIntersectionObserver >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaIntersectionObserver >> beNotOnce [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self once: false
]

{ #category : #convenience }
WaIntersectionObserver >> beOnce [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self once: true
]

{ #category : #accessing }
WaIntersectionObserver >> disabled [

	"Deactivates the intersection observer functionality.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaIntersectionObserver >> disabled: aBoolean [

	"Deactivates the intersection observer functionality.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaIntersectionObserver >> intersectClass [

	"CSS class applied to elements during intersection. Automatically removed when elements leave
	the viewport, enabling pure CSS styling based on visibility state.
	
	Type: String
	Default: ''"

	^ self propertyAt: #intersectClass
]

{ #category : #accessing }
WaIntersectionObserver >> intersectClass: aString [

	"CSS class applied to elements during intersection. Automatically removed when elements leave
	the viewport, enabling pure CSS styling based on visibility state.
	
	Type: String
	Default: ''"

	self propertyAt: #intersectClass put: aString
]

{ #category : #accessing }
WaIntersectionObserver >> once [

	"If enabled, observation ceases after initial intersection.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #once
]

{ #category : #accessing }
WaIntersectionObserver >> once: aBoolean [

	"If enabled, observation ceases after initial intersection.
	
	Type: Boolean
	Default: false"

	self propertyAt: #once put: aBoolean
]

{ #category : #accessing }
WaIntersectionObserver >> root [

	"Element ID to define the viewport boundaries for tracked targets.
	
	Type: String"

	^ self propertyAt: #root
]

{ #category : #accessing }
WaIntersectionObserver >> root: aString [

	"Element ID to define the viewport boundaries for tracked targets.
	
	Type: String"

	self propertyAt: #root put: aString
]

{ #category : #accessing }
WaIntersectionObserver >> rootMargin [

	"Offset space around the root boundary. Accepts values like CSS margin syntax.
	
	Type: String
	Default: '0px'"

	^ self propertyAt: #rootMargin
]

{ #category : #accessing }
WaIntersectionObserver >> rootMargin: aString [

	"Offset space around the root boundary. Accepts values like CSS margin syntax.
	
	Type: String
	Default: '0px'"

	self propertyAt: #rootMargin put: aString
]

{ #category : #accessing }
WaIntersectionObserver >> threshold [

	"One or more space-separated values representing visibility percentages that trigger the observer callback.
	
	Type: String
	Default: '0'"

	^ self propertyAt: #threshold
]

{ #category : #accessing }
WaIntersectionObserver >> threshold: aString [

	"One or more space-separated values representing visibility percentages that trigger the observer callback.
	
	Type: String
	Default: '0'"

	self propertyAt: #threshold put: aString
]
