Class {
	#name : #WaCheckbox,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaCheckbox >> beChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: true
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beDefaultChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultChecked: true
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beIndeterminate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self indeterminate: true
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beNotChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: false
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beNotDefaultChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultChecked: false
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beNotIndeterminate [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self indeterminate: false
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaCheckbox >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #actions }
WaCheckbox >> blur [

	"Removes focus from the checkbox."

	^ self apply: #blur
]

{ #category : #accessing }
WaCheckbox >> checked [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	^ self propertyAt: #checked
]

{ #category : #accessing }
WaCheckbox >> checked: aBoolean [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
WaCheckbox >> click [

	"Simulates a click on the checkbox."

	^ self apply: #click
]

{ #category : #accessing }
WaCheckbox >> defaultChecked [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	^ self propertyAt: #defaultChecked
]

{ #category : #accessing }
WaCheckbox >> defaultChecked: aBoolean [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	self propertyAt: #defaultChecked put: aBoolean
]

{ #category : #accessing }
WaCheckbox >> disabled [

	"Disables the checkbox.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaCheckbox >> disabled: aBoolean [

	"Disables the checkbox.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaCheckbox >> focus [

	"Sets focus on the checkbox."

	^ self apply: #focus
]

{ #category : #actions }
WaCheckbox >> focus: anObject [

	"Sets focus on the checkbox.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaCheckbox >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaCheckbox >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaCheckbox >> hint [

	"The checkbox's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaCheckbox >> hint: aString [

	"The checkbox's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaCheckbox >> indeterminate [

	"Draws the checkbox in an indeterminate state. This is usually applied to checkboxes that represents a ""select
	all/none"" behavior when associated checkboxes have a mix of checked and unchecked states.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #indeterminate
]

{ #category : #accessing }
WaCheckbox >> indeterminate: aBoolean [

	"Draws the checkbox in an indeterminate state. This is usually applied to checkboxes that represents a ""select
	all/none"" behavior when associated checkboxes have a mix of checked and unchecked states.
	
	Type: Boolean
	Default: false"

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : #accessing }
WaCheckbox >> name [

	"The name of the checkbox, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaCheckbox >> name: aString [

	"The name of the checkbox, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaCheckbox >> required [

	"Makes the checkbox a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaCheckbox >> required: aBoolean [

	"Makes the checkbox a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaCheckbox >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaCheckbox >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaCheckbox >> size [

	"The checkbox's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaCheckbox >> size: aString [

	"The checkbox's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaCheckbox >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaCheckbox >> value [

	"The value of the checkbox, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaCheckbox >> value: aString [

	"The value of the checkbox, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #value put: aString
]
