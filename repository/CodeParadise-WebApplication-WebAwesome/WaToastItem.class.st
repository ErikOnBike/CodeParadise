Class {
	#name : #WaToastItem,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaToastItem >> beWithIcon [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withIcon: true
]

{ #category : #'accessing - convenience' }
WaToastItem >> beWithoutIcon [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withIcon: false
]

{ #category : #accessing }
WaToastItem >> duration [

	"The length of time in milliseconds before the toast item is automatically dismissed. Set to 0 to keep the toast
	item open until the user dismisses it.
	
	Type: Number
	Default: 5000"

	^ self propertyAt: #duration
]

{ #category : #accessing }
WaToastItem >> duration: aNumber [

	"The length of time in milliseconds before the toast item is automatically dismissed. Set to 0 to keep the toast
	item open until the user dismisses it.
	
	Type: Number
	Default: 5000"

	self propertyAt: #duration put: aNumber
]

{ #category : #actions }
WaToastItem >> hide [

	"Hides the toast item with animation and removes it from the DOM."

	^ self apply: #hide
]

{ #category : #'accessing - slots' }
WaToastItem >> iconElement [

	"An optional icon to show at the start of the toast item."

	^ self firstChildAtSlotNamed: #icon
]

{ #category : #'accessing - slots' }
WaToastItem >> iconElement: anElement [

	"An optional icon to show at the start of the toast item."

	self replaceAllChildrenWith: anElement atSlotNamed: #icon
]

{ #category : #accessing }
WaToastItem >> size [

	"The toast item's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaToastItem >> size: aString [

	"The toast item's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaToastItem >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaToastItem >> slotNames [

	^ #(#icon)
]

{ #category : #accessing }
WaToastItem >> variant [

	"The toast item's variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'brand' | 'success' | 'warning' | 'danger' | 'neutral'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaToastItem >> variant: aString [

	"The toast item's variant.
	
	Type: String
	Default: 'neutral'
	Allowed: 'brand' | 'success' | 'warning' | 'danger' | 'neutral'"

	self propertyAt: #variant put: aString
]

{ #category : #'accessing - convenience' }
WaToastItem >> variantBrand [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #brand
]

{ #category : #'accessing - convenience' }
WaToastItem >> variantDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaToastItem >> variantNeutral [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #neutral
]

{ #category : #'accessing - convenience' }
WaToastItem >> variantSuccess [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #success
]

{ #category : #'accessing - convenience' }
WaToastItem >> variantWarning [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #warning
]

{ #category : #accessing }
WaToastItem >> withIcon [

	"Only required for SSR. Set to `true` if you're slotting in an `icon` element so the server-rendered markup
	includes the icon before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withIcon
]

{ #category : #accessing }
WaToastItem >> withIcon: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in an `icon` element so the server-rendered markup
	includes the icon before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withIcon put: aBoolean
]
