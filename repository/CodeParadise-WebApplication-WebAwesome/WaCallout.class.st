Class {
	#name : #WaCallout,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaCallout >> appearance [

	"The callout's visual appearance.
	
	Type: String
	Allowed: 'accent' | 'filled' | 'outlined' | 'plain' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaCallout >> appearance: aString [

	"The callout's visual appearance.
	
	Type: String
	Allowed: 'accent' | 'filled' | 'outlined' | 'plain' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaCallout >> appearanceAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #'accessing - convenience' }
WaCallout >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaCallout >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaCallout >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaCallout >> appearancePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #'accessing - slots' }
WaCallout >> iconElement [

	"An icon to show in the callout. Works best with `<wa-icon>`."

	^ self firstChildAtSlotNamed: #icon
]

{ #category : #'accessing - slots' }
WaCallout >> iconElement: anElement [

	"An icon to show in the callout. Works best with `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #icon
]

{ #category : #accessing }
WaCallout >> size [

	"The callout's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaCallout >> size: aString [

	"The callout's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaCallout >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #accessing }
WaCallout >> variant [

	"The callout's theme variant. Defaults to `brand` if not within another element with a variant.
	
	Type: String
	Default: 'brand'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaCallout >> variant: aString [

	"The callout's theme variant. Defaults to `brand` if not within another element with a variant.
	
	Type: String
	Default: 'brand'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	self propertyAt: #variant put: aString
]

{ #category : #'accessing - convenience' }
WaCallout >> variantBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #'accessing - convenience' }
WaCallout >> variantDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaCallout >> variantNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #'accessing - convenience' }
WaCallout >> variantSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #'accessing - convenience' }
WaCallout >> variantWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]
