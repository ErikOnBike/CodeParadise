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
WaBadge >> beAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #'accessing - convenience' }
WaBadge >> beBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #'accessing - convenience' }
WaBadge >> beDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaBadge >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaBadge >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaBadge >> beNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #'accessing - convenience' }
WaBadge >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaBadge >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaBadge >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - convenience' }
WaBadge >> beSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #'accessing - convenience' }
WaBadge >> beWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
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
