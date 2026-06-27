Class {
	#name : #WaDropdown,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaDropdown >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaDropdown >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #accessing }
WaDropdown >> distance [

	"The distance of the dropdown menu from its trigger.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #distance
]

{ #category : #accessing }
WaDropdown >> distance: aNumber [

	"The distance of the dropdown menu from its trigger.
	
	Type: Number
	Default: 0"

	self propertyAt: #distance put: aNumber
]

{ #category : #accessing }
WaDropdown >> open [

	"Opens or closes the dropdown.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaDropdown >> open: aBoolean [

	"Opens or closes the dropdown.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaDropdown >> placement [

	"The placement of the dropdown menu in reference to the trigger. The menu will shift to a more optimal location if
	the preferred placement doesn't have enough room.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaDropdown >> placement: aString [

	"The placement of the dropdown menu in reference to the trigger. The menu will shift to a more optimal location if
	the preferred placement doesn't have enough room.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	self propertyAt: #placement put: aString
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementBottom [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #bottom
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementBottomEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-end'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementBottomStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'bottom-start'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementLeft [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #left
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementLeftEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'left-end'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementLeftStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'left-start'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementRight [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #right
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementRightEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'right-end'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementRightStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'right-start'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementTop [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #top
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementTopEnd [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-end'
]

{ #category : #'accessing - convenience' }
WaDropdown >> placementTopStart [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #'top-start'
]

{ #category : #accessing }
WaDropdown >> size [

	"The dropdown's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaDropdown >> size: aString [

	"The dropdown's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaDropdown >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #accessing }
WaDropdown >> skidding [

	"The offset of the dropdown menu along its trigger.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #skidding
]

{ #category : #accessing }
WaDropdown >> skidding: aNumber [

	"The offset of the dropdown menu along its trigger.
	
	Type: Number
	Default: 0"

	self propertyAt: #skidding put: aNumber
]

{ #category : #'accessing - slots' }
WaDropdown >> triggerElement [

	"The element that triggers the dropdown, such as a `<wa-button>` or `<button>`."

	^ self firstChildAtSlotNamed: #trigger
]

{ #category : #'accessing - slots' }
WaDropdown >> triggerElement: anElement [

	"The element that triggers the dropdown, such as a `<wa-button>` or `<button>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #trigger
]
