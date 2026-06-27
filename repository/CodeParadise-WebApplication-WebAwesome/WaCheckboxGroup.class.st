Class {
	#name : #WaCheckboxGroup,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaCheckboxGroup >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
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
