Class {
	#name : #WaScroller,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaScroller >> beWithScrollbar [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutScrollbar: false
]

{ #category : #'accessing - convenience' }
WaScroller >> beWithShadow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutShadow: false
]

{ #category : #'accessing - convenience' }
WaScroller >> beWithoutScrollbar [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutScrollbar: true
]

{ #category : #'accessing - convenience' }
WaScroller >> beWithoutShadow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutShadow: true
]

{ #category : #accessing }
WaScroller >> orientation [

	"The scroller's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaScroller >> orientation: aString [

	"The scroller's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaScroller >> withoutScrollbar [

	"Removes the visible scrollbar.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutScrollbar
]

{ #category : #accessing }
WaScroller >> withoutScrollbar: aBoolean [

	"Removes the visible scrollbar.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutScrollbar put: aBoolean
]

{ #category : #accessing }
WaScroller >> withoutShadow [

	"Removes the shadows.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutShadow
]

{ #category : #accessing }
WaScroller >> withoutShadow: aBoolean [

	"Removes the shadows.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutShadow put: aBoolean
]
