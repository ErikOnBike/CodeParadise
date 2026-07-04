Class {
	#name : #WaPopover,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaPopover >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaPopover >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaPopover >> beWithArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutArrow: false
]

{ #category : #'accessing - convenience' }
WaPopover >> beWithoutArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutArrow: true
]

{ #category : #accessing }
WaPopover >> distance [

	"The distance in pixels from which to offset the popover away from its target.
	
	Type: Number
	Default: 8"

	^ self propertyAt: #distance
]

{ #category : #accessing }
WaPopover >> distance: aNumber [

	"The distance in pixels from which to offset the popover away from its target.
	
	Type: Number
	Default: 8"

	self propertyAt: #distance put: aNumber
]

{ #category : #accessing }
WaPopover >> for [

	"The ID of the popover's anchor element. This must be an interactive/focusable element such as a button.
	
	Type: String"

	^ self propertyAt: #for
]

{ #category : #accessing }
WaPopover >> for: aString [

	"The ID of the popover's anchor element. This must be an interactive/focusable element such as a button.
	
	Type: String"

	self propertyAt: #for put: aString
]

{ #category : #actions }
WaPopover >> hide [

	"Hides the popover."

	^ self apply: #hide
]

{ #category : #accessing }
WaPopover >> open [

	"Shows or hides the popover.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaPopover >> open: aBoolean [

	"Shows or hides the popover.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaPopover >> placement [

	"The preferred placement of the popover. Note that the actual placement may vary as needed to keep the popover
	inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'right' | 'right-start' | 'right-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'left' | 'left-start' | 'left-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaPopover >> placement: aString [

	"The preferred placement of the popover. Note that the actual placement may vary as needed to keep the popover
	inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'right' | 'right-start' | 'right-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'left' | 'left-start' | 'left-end'"

	self propertyAt: #placement put: aString
]

{ #category : #'accessing - convenience' }
WaPopover >> placementBottom [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #bottom
]

{ #category : #'accessing - convenience' }
WaPopover >> placementBottomEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-end'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementBottomStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-start'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementLeft [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #left
]

{ #category : #'accessing - convenience' }
WaPopover >> placementLeftEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'left-end'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementLeftStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'left-start'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementRight [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #right
]

{ #category : #'accessing - convenience' }
WaPopover >> placementRightEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'right-end'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementRightStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'right-start'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementTop [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #top
]

{ #category : #'accessing - convenience' }
WaPopover >> placementTopEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-end'
]

{ #category : #'accessing - convenience' }
WaPopover >> placementTopStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-start'
]

{ #category : #actions }
WaPopover >> show [

	"Shows the popover."

	^ self apply: #show
]

{ #category : #accessing }
WaPopover >> skidding [

	"The distance in pixels from which to offset the popover along its target.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #skidding
]

{ #category : #accessing }
WaPopover >> skidding: aNumber [

	"The distance in pixels from which to offset the popover along its target.
	
	Type: Number
	Default: 0"

	self propertyAt: #skidding put: aNumber
]

{ #category : #accessing }
WaPopover >> withoutArrow [

	"Removes the arrow from the popover.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutArrow
]

{ #category : #accessing }
WaPopover >> withoutArrow: aBoolean [

	"Removes the arrow from the popover.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutArrow put: aBoolean
]
