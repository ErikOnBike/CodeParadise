Class {
	#name : #WaCopyButton,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaCopyButton >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaCopyButton >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaCopyButton >> copyLabel [

	"A custom label to use as the accessible name and tooltip text in the default copy state.
	
	Type: String
	Default: ''"

	^ self propertyAt: #copyLabel
]

{ #category : #accessing }
WaCopyButton >> copyLabel: aString [

	"A custom label to use as the accessible name and tooltip text in the default copy state.
	
	Type: String
	Default: ''"

	self propertyAt: #copyLabel put: aString
]

{ #category : #accessing }
WaCopyButton >> disabled [

	"Disables the copy button.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaCopyButton >> disabled: aBoolean [

	"Disables the copy button.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaCopyButton >> errorLabel [

	"A custom label to show in the tooltip when a copy error occurs.
	
	Type: String
	Default: ''"

	^ self propertyAt: #errorLabel
]

{ #category : #accessing }
WaCopyButton >> errorLabel: aString [

	"A custom label to show in the tooltip when a copy error occurs.
	
	Type: String
	Default: ''"

	self propertyAt: #errorLabel put: aString
]

{ #category : #accessing }
WaCopyButton >> feedbackDuration [

	"The length of time to show feedback before restoring the default trigger.
	
	Type: Number
	Default: 1000"

	^ self propertyAt: #feedbackDuration
]

{ #category : #accessing }
WaCopyButton >> feedbackDuration: aNumber [

	"The length of time to show feedback before restoring the default trigger.
	
	Type: Number
	Default: 1000"

	self propertyAt: #feedbackDuration put: aNumber
]

{ #category : #accessing }
WaCopyButton >> from [

	"An id that references an element in the same document from which data will be copied. If both this and `value` are
	present, this value will take precedence. By default, the target element's `textContent` will be copied. To copy an
	attribute, append the attribute name wrapped in square brackets, e.g. `from=""el[value]""`. To copy a property,
	append a dot and the property name, e.g. `from=""el.value""`.
	
	Type: String
	Default: ''"

	^ self propertyAt: #from
]

{ #category : #accessing }
WaCopyButton >> from: aString [

	"An id that references an element in the same document from which data will be copied. If both this and `value` are
	present, this value will take precedence. By default, the target element's `textContent` will be copied. To copy an
	attribute, append the attribute name wrapped in square brackets, e.g. `from=""el[value]""`. To copy a property,
	append a dot and the property name, e.g. `from=""el.value""`.
	
	Type: String
	Default: ''"

	self propertyAt: #from put: aString
]

{ #category : #accessing }
WaCopyButton >> successLabel [

	"A custom label to show in the tooltip after copying.
	
	Type: String
	Default: ''"

	^ self propertyAt: #successLabel
]

{ #category : #accessing }
WaCopyButton >> successLabel: aString [

	"A custom label to show in the tooltip after copying.
	
	Type: String
	Default: ''"

	self propertyAt: #successLabel put: aString
]

{ #category : #accessing }
WaCopyButton >> tooltip [

	"Controls the built-in tooltip. `full` (default) shows the tooltip on hover and focus and during copy feedback.
	`copy` keeps the tooltip silent on hover/focus and only shows it briefly to confirm a successful or failed copy.
	`none` disables the tooltip entirely. Applies to both the default and custom triggers.
	
	Type: String
	Default: 'full'
	Allowed: 'full' | 'copy' | 'none'"

	^ self propertyAt: #tooltip
]

{ #category : #accessing }
WaCopyButton >> tooltip: aString [

	"Controls the built-in tooltip. `full` (default) shows the tooltip on hover and focus and during copy feedback.
	`copy` keeps the tooltip silent on hover/focus and only shows it briefly to confirm a successful or failed copy.
	`none` disables the tooltip entirely. Applies to both the default and custom triggers.
	
	Type: String
	Default: 'full'
	Allowed: 'full' | 'copy' | 'none'"

	self propertyAt: #tooltip put: aString
]

{ #category : #accessing }
WaCopyButton >> tooltipPlacement [

	"The preferred placement of the tooltip.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'right' | 'bottom' | 'left'"

	^ self propertyAt: #tooltipPlacement
]

{ #category : #accessing }
WaCopyButton >> tooltipPlacement: aString [

	"The preferred placement of the tooltip.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'right' | 'bottom' | 'left'"

	self propertyAt: #tooltipPlacement put: aString
]

{ #category : #accessing }
WaCopyButton >> value [

	"The text value to copy.
	
	Type: String
	Default: ''"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaCopyButton >> value: aString [

	"The text value to copy.
	
	Type: String
	Default: ''"

	self propertyAt: #value put: aString
]
