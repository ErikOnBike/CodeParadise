Class {
	#name : #WaPopover,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaPopover >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #convenience }
WaPopover >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #convenience }
WaPopover >> beWithArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutArrow: false
]

{ #category : #convenience }
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
