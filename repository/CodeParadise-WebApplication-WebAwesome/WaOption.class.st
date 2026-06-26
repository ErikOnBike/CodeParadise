Class {
	#name : #WaOption,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaOption >> beDefaultSelected [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultSelected: true
]

{ #category : #convenience }
WaOption >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaOption >> beNotDefaultSelected [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultSelected: false
]

{ #category : #convenience }
WaOption >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaOption >> defaultLabel [

	"The default label, generated from the element contents. Will be equal to `label` in most cases.
	
	Type: String
	Read-only: true"

	^ self propertyAt: #defaultLabel
]

{ #category : #accessing }
WaOption >> defaultSelected [

	"Selects an option initially.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #defaultSelected
]

{ #category : #accessing }
WaOption >> defaultSelected: aBoolean [

	"Selects an option initially.
	
	Type: Boolean
	Default: false"

	self propertyAt: #defaultSelected put: aBoolean
]

{ #category : #accessing }
WaOption >> disabled [

	"Draws the option in a disabled state, preventing selection.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaOption >> disabled: aBoolean [

	"Draws the option in a disabled state, preventing selection.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaOption >> label [

	"The option’s plain text label.
	Usually automatically generated, but can be useful to provide manually for cases involving complex content.
	
	Type: String"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaOption >> label: aString [

	"The option’s plain text label.
	Usually automatically generated, but can be useful to provide manually for cases involving complex content.
	
	Type: String"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaOption >> value [

	"The option's value. When selected, the containing form control will receive this value. The value must be unique
	from other options in the same group. Values may not contain spaces, as spaces are used as delimiters when listing
	multiple values.
	
	Type: String
	Default: ''"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaOption >> value: aString [

	"The option's value. When selected, the containing form control will receive this value. The value must be unique
	from other options in the same group. Values may not contain spaces, as spaces are used as delimiters when listing
	multiple values.
	
	Type: String
	Default: ''"

	self propertyAt: #value put: aString
]
