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

{ #category : #convenience }
WaTag >> beAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #convenience }
WaTag >> beBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #convenience }
WaTag >> beDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #convenience }
WaTag >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaTag >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaTag >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaTag >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaTag >> beNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #convenience }
WaTag >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #convenience }
WaTag >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaTag >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #convenience }
WaTag >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaTag >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaTag >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaTag >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaTag >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaTag >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaTag >> beSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #convenience }
WaTag >> beWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]

{ #category : #convenience }
WaTag >> beWithRemove [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withRemove: true
]

{ #category : #convenience }
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
