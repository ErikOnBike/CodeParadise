Class {
	#name : #WaTag,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTag >> appearance [

	"The tag's visual appearance.
	
	Type: String
	Default: 'filled-outlined'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaTag >> appearance: aString [

	"The tag's visual appearance.
	
	Type: String
	Default: 'filled-outlined'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaTag >> beAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #'accessing - convenience' }
WaTag >> beBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #'accessing - convenience' }
WaTag >> beDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaTag >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaTag >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaTag >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaTag >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaTag >> beNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #'accessing - convenience' }
WaTag >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaTag >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaTag >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - convenience' }
WaTag >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaTag >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaTag >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaTag >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaTag >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaTag >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaTag >> beSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #'accessing - convenience' }
WaTag >> beWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]

{ #category : #'accessing - convenience' }
WaTag >> beWithRemove [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withRemove: true
]

{ #category : #'accessing - convenience' }
WaTag >> beWithoutRemove [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withRemove: false
]

{ #category : #accessing }
WaTag >> pill [

	"Draws a pill-style tag with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaTag >> pill: aBoolean [

	"Draws a pill-style tag with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaTag >> size [

	"The tag's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaTag >> size: aString [

	"The tag's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaTag >> variant [

	"The tag's theme variant. Defaults to `neutral` if not within another element with a variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaTag >> variant: aString [

	"The tag's theme variant. Defaults to `neutral` if not within another element with a variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'brand' | 'neutral' | 'success' | 'warning' | 'danger'"

	self propertyAt: #variant put: aString
]

{ #category : #accessing }
WaTag >> withRemove [

	"Makes the tag removable and shows a remove button.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withRemove
]

{ #category : #accessing }
WaTag >> withRemove: aBoolean [

	"Makes the tag removable and shows a remove button.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withRemove put: aBoolean
]
