Class {
	#name : #WaBadge,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaBadge >> appearance [

	"The badge's visual appearance.
	
	Type: String
	Default: 'accent'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaBadge >> appearance: aString [

	"The badge's visual appearance.
	
	Type: String
	Default: 'accent'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaBadge >> appearanceAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #'accessing - convenience' }
WaBadge >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaBadge >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaBadge >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #accessing }
WaBadge >> attention [

	"Adds an animation to draw attention to the badge.
	
	Type: String
	Default: 'none'
	Allowed: 'none' | 'pulse' | 'bounce'"

	^ self propertyAt: #attention
]

{ #category : #accessing }
WaBadge >> attention: aString [

	"Adds an animation to draw attention to the badge.
	
	Type: String
	Default: 'none'
	Allowed: 'none' | 'pulse' | 'bounce'"

	self propertyAt: #attention put: aString
]

{ #category : #'accessing - convenience' }
WaBadge >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaBadge >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - slots' }
WaBadge >> endElement [

	"An element, such as `<wa-icon>`, placed after the label."

	^ self firstChildAtSlotNamed: #end
]

{ #category : #'accessing - slots' }
WaBadge >> endElement: anElement [

	"An element, such as `<wa-icon>`, placed after the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #end
]

{ #category : #accessing }
WaBadge >> pill [

	"Draws a pill-style badge with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaBadge >> pill: aBoolean [

	"Draws a pill-style badge with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #'accessing - slots' }
WaBadge >> startElement [

	"An element, such as `<wa-icon>`, placed before the label."

	^ self firstChildAtSlotNamed: #start
]

{ #category : #'accessing - slots' }
WaBadge >> startElement: anElement [

	"An element, such as `<wa-icon>`, placed before the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #start
]

{ #category : #accessing }
WaBadge >> variant [

	"The badge's theme variant. Defaults to `brand` if not within another element with a variant.
	
	Type: String
	Default: 'brand'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaBadge >> variant: aString [

	"The badge's theme variant. Defaults to `brand` if not within another element with a variant.
	
	Type: String
	Default: 'brand'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	self propertyAt: #variant put: aString
]

{ #category : #'accessing - convenience' }
WaBadge >> variantBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #'accessing - convenience' }
WaBadge >> variantDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaBadge >> variantNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #'accessing - convenience' }
WaBadge >> variantSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #'accessing - convenience' }
WaBadge >> variantWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]
