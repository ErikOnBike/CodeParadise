Class {
	#name : #WaDropdown,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaDropdown >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaDropdown >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

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

{ #category : #'accessing - convenience' }
WaDropdown >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaDropdown >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaDropdown >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaDropdown >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaDropdown >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaDropdown >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
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
