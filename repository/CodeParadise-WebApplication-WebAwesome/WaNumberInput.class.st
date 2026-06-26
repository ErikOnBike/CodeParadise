Class {
	#name : #WaNumberInput,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaNumberInput >> appearance [

	"The input's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaNumberInput >> appearance: aString [

	"The input's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #accessing }
WaNumberInput >> autocomplete [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaNumberInput >> autocomplete: aString [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	self propertyAt: #autocomplete put: aString
]

{ #category : #accessing }
WaNumberInput >> autofocus [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	^ self propertyAt: #autofocus
]

{ #category : #accessing }
WaNumberInput >> autofocus: aBoolean [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #convenience }
WaNumberInput >> beAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: true
]

{ #category : #convenience }
WaNumberInput >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaNumberInput >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaNumberInput >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaNumberInput >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaNumberInput >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaNumberInput >> beNotAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: false
]

{ #category : #convenience }
WaNumberInput >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaNumberInput >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #convenience }
WaNumberInput >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #convenience }
WaNumberInput >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #convenience }
WaNumberInput >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaNumberInput >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #convenience }
WaNumberInput >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #convenience }
WaNumberInput >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #convenience }
WaNumberInput >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaNumberInput >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaNumberInput >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaNumberInput >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaNumberInput >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaNumberInput >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaNumberInput >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #convenience }
WaNumberInput >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #convenience }
WaNumberInput >> beWithSteppers [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutSteppers: false
]

{ #category : #convenience }
WaNumberInput >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #convenience }
WaNumberInput >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #convenience }
WaNumberInput >> beWithoutSteppers [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutSteppers: true
]

{ #category : #actions }
WaNumberInput >> blur [

	"Removes focus from the input."

	^ self apply: #blur
]

{ #category : #accessing }
WaNumberInput >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaNumberInput >> defaultValue: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaNumberInput >> disabled [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaNumberInput >> disabled: aBoolean [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaNumberInput >> enterkeyhint [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #accessing }
WaNumberInput >> enterkeyhint: aString [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #actions }
WaNumberInput >> focus [

	"Sets focus on the input."

	^ self apply: #focus
]

{ #category : #actions }
WaNumberInput >> focus: anObject [

	"Sets focus on the input.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaNumberInput >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaNumberInput >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaNumberInput >> hint [

	"The input's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaNumberInput >> hint: aString [

	"The input's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaNumberInput >> inputmode [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Default: 'numeric'
	Allowed: 'numeric' | 'decimal'"

	^ self propertyAt: #inputmode
]

{ #category : #accessing }
WaNumberInput >> inputmode: aString [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Default: 'numeric'
	Allowed: 'numeric' | 'decimal'"

	self propertyAt: #inputmode put: aString
]

{ #category : #accessing }
WaNumberInput >> label [

	"The input's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaNumberInput >> label: aString [

	"The input's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaNumberInput >> max [

	"The input's maximum value.
	
	Type: Number"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaNumberInput >> max: aNumber [

	"The input's maximum value.
	
	Type: Number"

	self propertyAt: #max put: aNumber
]

{ #category : #accessing }
WaNumberInput >> min [

	"The input's minimum value.
	
	Type: Number"

	^ self propertyAt: #min
]

{ #category : #accessing }
WaNumberInput >> min: aNumber [

	"The input's minimum value.
	
	Type: Number"

	self propertyAt: #min put: aNumber
]

{ #category : #accessing }
WaNumberInput >> name [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaNumberInput >> name: aString [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaNumberInput >> pill [

	"Draws a pill-style input with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaNumberInput >> pill: aBoolean [

	"Draws a pill-style input with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaNumberInput >> placeholder [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
WaNumberInput >> placeholder: aString [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
WaNumberInput >> readonly [

	"Makes the input readonly.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaNumberInput >> readonly: aBoolean [

	"Makes the input readonly.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaNumberInput >> required [

	"Makes the input a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaNumberInput >> required: aBoolean [

	"Makes the input a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaNumberInput >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaNumberInput >> select [

	"Selects all the text in the input."

	^ self apply: #select
]

{ #category : #actions }
WaNumberInput >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaNumberInput >> size [

	"The input's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaNumberInput >> size: aString [

	"The input's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaNumberInput >> step [

	"Specifies the granularity that the value must adhere to, or the special value `any` which means no stepping is
	implied, allowing any numeric value.
	
	Type: NumberOrString
	Default: 1
	Allowed: 'any'"

	^ self propertyAt: #step
]

{ #category : #accessing }
WaNumberInput >> step: aNumberOrString [

	"Specifies the granularity that the value must adhere to, or the special value `any` which means no stepping is
	implied, allowing any numeric value.
	
	Type: NumberOrString
	Default: 1
	Allowed: 'any'"

	self propertyAt: #step put: aNumberOrString
]

{ #category : #actions }
WaNumberInput >> stepDown [

	"Decrements the value by the step amount."

	^ self apply: #stepDown
]

{ #category : #actions }
WaNumberInput >> stepUp [

	"Increments the value by the step amount."

	^ self apply: #stepUp
]

{ #category : #accessing }
WaNumberInput >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaNumberInput >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaNumberInput >> value: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaNumberInput >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaNumberInput >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaNumberInput >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaNumberInput >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]

{ #category : #accessing }
WaNumberInput >> withoutSteppers [

	"Hides the increment/decrement stepper buttons.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutSteppers
]

{ #category : #accessing }
WaNumberInput >> withoutSteppers: aBoolean [

	"Hides the increment/decrement stepper buttons.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutSteppers put: aBoolean
]
