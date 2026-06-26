Class {
	#name : #WaCheckboxGroup,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaCheckboxGroup >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaCheckboxGroup >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaCheckboxGroup >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #convenience }
WaCheckboxGroup >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #convenience }
WaCheckboxGroup >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaCheckboxGroup >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaCheckboxGroup >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaCheckboxGroup >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaCheckboxGroup >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaCheckboxGroup >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaCheckboxGroup >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #convenience }
WaCheckboxGroup >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #convenience }
WaCheckboxGroup >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #convenience }
WaCheckboxGroup >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #accessing }
WaCheckboxGroup >> hint [

	"The checkbox group's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaCheckboxGroup >> hint: aString [

	"The checkbox group's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaCheckboxGroup >> label [

	"The checkbox group's label. Required for proper accessibility. If you need to display HTML, use the `label` slot
	instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaCheckboxGroup >> label: aString [

	"The checkbox group's label. Required for proper accessibility. If you need to display HTML, use the `label` slot
	instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaCheckboxGroup >> orientation [

	"The orientation in which to show grouped checkboxes.
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaCheckboxGroup >> orientation: aString [

	"The orientation in which to show grouped checkboxes.
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaCheckboxGroup >> required [

	"Indicates that at least one option should be selected. This only adds a visual indicator to the label. To enforce
	the requirement, use the `required` attribute on the individual checkboxes and/or their `setCustomValidity()`
	method.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaCheckboxGroup >> required: aBoolean [

	"Indicates that at least one option should be selected. This only adds a visual indicator to the label. To enforce
	the requirement, use the `required` attribute on the individual checkboxes and/or their `setCustomValidity()`
	method.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #accessing }
WaCheckboxGroup >> size [

	"The group's size. When present, this size will be applied to all `<wa-checkbox>` and `<wa-switch>` items inside.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaCheckboxGroup >> size: aString [

	"The group's size. When present, this size will be applied to all `<wa-checkbox>` and `<wa-switch>` items inside.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaCheckboxGroup >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup includes
	the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaCheckboxGroup >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup includes
	the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaCheckboxGroup >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup includes
	the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaCheckboxGroup >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup includes
	the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]
