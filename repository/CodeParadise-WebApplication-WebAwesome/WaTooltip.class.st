Class {
	#name : #WaTooltip,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaTooltip >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaTooltip >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaTooltip >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaTooltip >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaTooltip >> beWithArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutArrow: false
]

{ #category : #'accessing - convenience' }
WaTooltip >> beWithoutArrow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutArrow: true
]

{ #category : #accessing }
WaTooltip >> disabled [

	"Disables the tooltip so it won't show when triggered.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaTooltip >> disabled: aBoolean [

	"Disables the tooltip so it won't show when triggered.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaTooltip >> distance [

	"The distance in pixels from which to offset the tooltip away from its target.
	
	Type: Number
	Default: 8"

	^ self propertyAt: #distance
]

{ #category : #accessing }
WaTooltip >> distance: aNumber [

	"The distance in pixels from which to offset the tooltip away from its target.
	
	Type: Number
	Default: 8"

	self propertyAt: #distance put: aNumber
]

{ #category : #actions }
WaTooltip >> hide [

	"Hides the tooltip"

	^ self apply: #hide
]

{ #category : #accessing }
WaTooltip >> hideDelay [

	"The amount of time to wait before hiding the tooltip when the user mouses out.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #hideDelay
]

{ #category : #accessing }
WaTooltip >> hideDelay: aNumber [

	"The amount of time to wait before hiding the tooltip when the user mouses out.
	
	Type: Number
	Default: 0"

	self propertyAt: #hideDelay put: aNumber
]

{ #category : #accessing }
WaTooltip >> open [

	"Indicates whether or not the tooltip is open. You can use this in lieu of the show/hide methods.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaTooltip >> open: aBoolean [

	"Indicates whether or not the tooltip is open. You can use this in lieu of the show/hide methods.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaTooltip >> placement [

	"The preferred placement of the tooltip. Note that the actual placement may vary as needed to keep the tooltip
	inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'right' | 'right-start' | 'right-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'left' | 'left-start' | 'left-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaTooltip >> placement: aString [

	"The preferred placement of the tooltip. Note that the actual placement may vary as needed to keep the tooltip
	inside of the viewport.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'top-start' | 'top-end' | 'right' | 'right-start' | 'right-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'left' | 'left-start' | 'left-end'"

	self propertyAt: #placement put: aString
]

{ #category : #actions }
WaTooltip >> show [

	"Shows the tooltip."

	^ self apply: #show
]

{ #category : #accessing }
WaTooltip >> showDelay [

	"The amount of time to wait before showing the tooltip when the user mouses in.
	
	Type: Number
	Default: 150"

	^ self propertyAt: #showDelay
]

{ #category : #accessing }
WaTooltip >> showDelay: aNumber [

	"The amount of time to wait before showing the tooltip when the user mouses in.
	
	Type: Number
	Default: 150"

	self propertyAt: #showDelay put: aNumber
]

{ #category : #accessing }
WaTooltip >> skidding [

	"The distance in pixels from which to offset the tooltip along its target.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #skidding
]

{ #category : #accessing }
WaTooltip >> skidding: aNumber [

	"The distance in pixels from which to offset the tooltip along its target.
	
	Type: Number
	Default: 0"

	self propertyAt: #skidding put: aNumber
]

{ #category : #accessing }
WaTooltip >> trigger [

	"Controls how the tooltip is activated. Possible options include `click`, `hover`, `focus`, and `manual`. Multiple
	options can be passed by separating them with a space. When manual is used, the tooltip must be activated
	programmatically.
	
	Type: String
	Default: 'hover focus'"

	^ self propertyAt: #trigger
]

{ #category : #accessing }
WaTooltip >> trigger: aString [

	"Controls how the tooltip is activated. Possible options include `click`, `hover`, `focus`, and `manual`. Multiple
	options can be passed by separating them with a space. When manual is used, the tooltip must be activated
	programmatically.
	
	Type: String
	Default: 'hover focus'"

	self propertyAt: #trigger put: aString
]

{ #category : #accessing }
WaTooltip >> withoutArrow [

	"Removes the arrow from the tooltip.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutArrow
]

{ #category : #accessing }
WaTooltip >> withoutArrow: aBoolean [

	"Removes the arrow from the tooltip.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutArrow put: aBoolean
]
