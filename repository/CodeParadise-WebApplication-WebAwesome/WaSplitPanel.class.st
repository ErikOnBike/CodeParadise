Class {
	#name : #WaSplitPanel,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaSplitPanel >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaSplitPanel >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaSplitPanel >> disabled [

	"Disables resizing. Note that the position may still change as a result of resizing the host element.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaSplitPanel >> disabled: aBoolean [

	"Disables resizing. Note that the position may still change as a result of resizing the host element.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaSplitPanel >> orientation [

	"Sets the split panel's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaSplitPanel >> orientation: aString [

	"Sets the split panel's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaSplitPanel >> position [

	"The current position of the divider from the primary panel's edge as a percentage 0-100. Defaults to 50% of the
	container's initial size.
	
	Type: Number
	Default: 50"

	^ self propertyAt: #position
]

{ #category : #accessing }
WaSplitPanel >> position: aNumber [

	"The current position of the divider from the primary panel's edge as a percentage 0-100. Defaults to 50% of the
	container's initial size.
	
	Type: Number
	Default: 50"

	self propertyAt: #position put: aNumber
]

{ #category : #accessing }
WaSplitPanel >> positionInPixels [

	"The current position of the divider from the primary panel's edge in pixels.
	
	Type: Number"

	^ self propertyAt: #positionInPixels
]

{ #category : #accessing }
WaSplitPanel >> positionInPixels: aNumber [

	"The current position of the divider from the primary panel's edge in pixels.
	
	Type: Number"

	self propertyAt: #positionInPixels put: aNumber
]

{ #category : #accessing }
WaSplitPanel >> primary [

	"If no primary panel is designated, both panels will resize proportionally when the host element is resized. If a
	primary panel is designated, it will maintain its size and the other panel will grow or shrink as needed when the
	host element is resized.
	
	Type: String
	Allowed: 'start' | 'end'"

	^ self propertyAt: #primary
]

{ #category : #accessing }
WaSplitPanel >> primary: aString [

	"If no primary panel is designated, both panels will resize proportionally when the host element is resized. If a
	primary panel is designated, it will maintain its size and the other panel will grow or shrink as needed when the
	host element is resized.
	
	Type: String
	Allowed: 'start' | 'end'"

	self propertyAt: #primary put: aString
]

{ #category : #accessing }
WaSplitPanel >> snap [

	"One or more space-separated values at which the divider should snap. Values can be in pixels or percentages, e.g.
	`""100px 50%""`.
	
	Type: String"

	^ self propertyAt: #snap
]

{ #category : #accessing }
WaSplitPanel >> snap: aString [

	"One or more space-separated values at which the divider should snap. Values can be in pixels or percentages, e.g.
	`""100px 50%""`.
	
	Type: String"

	self propertyAt: #snap put: aString
]

{ #category : #accessing }
WaSplitPanel >> snapThreshold [

	"How close the divider must be to a snap point until snapping occurs.
	
	Type: Number
	Default: 12"

	^ self propertyAt: #snapThreshold
]

{ #category : #accessing }
WaSplitPanel >> snapThreshold: aNumber [

	"How close the divider must be to a snap point until snapping occurs.
	
	Type: Number
	Default: 12"

	self propertyAt: #snapThreshold put: aNumber
]
