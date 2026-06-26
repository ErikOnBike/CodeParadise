Class {
	#name : #WaInput,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaInput >> appearance [

	"The input's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaInput >> appearance: aString [

	"The input's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #accessing }
WaInput >> autocapitalize [

	"Controls whether and how text input is automatically capitalized as it is entered by the user.
	
	Type: String
	Allowed: 'off' | 'none' | 'on' | 'sentences' | 'words' | 'characters'"

	^ self propertyAt: #autocapitalize
]

{ #category : #accessing }
WaInput >> autocapitalize: aString [

	"Controls whether and how text input is automatically capitalized as it is entered by the user.
	
	Type: String
	Allowed: 'off' | 'none' | 'on' | 'sentences' | 'words' | 'characters'"

	self propertyAt: #autocapitalize put: aString
]

{ #category : #accessing }
WaInput >> autocomplete [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaInput >> autocomplete: aString [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	self propertyAt: #autocomplete put: aString
]

{ #category : #accessing }
WaInput >> autocorrect [

	"Indicates whether the browser's autocorrect feature is on or off. When set as an attribute, use `""off""` or `""on""`.
	When set as a property, use `true` or `false`.
	
	Type: Boolean"

	^ self propertyAt: #autocorrect
]

{ #category : #accessing }
WaInput >> autocorrect: aBoolean [

	"Indicates whether the browser's autocorrect feature is on or off. When set as an attribute, use `""off""` or `""on""`.
	When set as a property, use `true` or `false`.
	
	Type: Boolean"

	self propertyAt: #autocorrect put: aBoolean
]

{ #category : #accessing }
WaInput >> autofocus [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	^ self propertyAt: #autofocus
]

{ #category : #accessing }
WaInput >> autofocus: aBoolean [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #convenience }
WaInput >> beAutocorrect [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autocorrect: true
]

{ #category : #convenience }
WaInput >> beAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: true
]

{ #category : #convenience }
WaInput >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaInput >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaInput >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaInput >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaInput >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaInput >> beNotAutocorrect [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autocorrect: false
]

{ #category : #convenience }
WaInput >> beNotAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: false
]

{ #category : #convenience }
WaInput >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaInput >> beNotPasswordToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self passwordToggle: false
]

{ #category : #convenience }
WaInput >> beNotPasswordVisible [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self passwordVisible: false
]

{ #category : #convenience }
WaInput >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #convenience }
WaInput >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #convenience }
WaInput >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #convenience }
WaInput >> beNotSpellcheck [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self spellcheck: false
]

{ #category : #convenience }
WaInput >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaInput >> bePasswordToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self passwordToggle: true
]

{ #category : #convenience }
WaInput >> bePasswordVisible [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self passwordVisible: true
]

{ #category : #convenience }
WaInput >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #convenience }
WaInput >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #convenience }
WaInput >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #convenience }
WaInput >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaInput >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaInput >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaInput >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaInput >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaInput >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaInput >> beSpellcheck [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self spellcheck: true
]

{ #category : #convenience }
WaInput >> beWithClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: true
]

{ #category : #convenience }
WaInput >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #convenience }
WaInput >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #convenience }
WaInput >> beWithSpinButtons [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutSpinButtons: false
]

{ #category : #convenience }
WaInput >> beWithoutClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: false
]

{ #category : #convenience }
WaInput >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #convenience }
WaInput >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #convenience }
WaInput >> beWithoutSpinButtons [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutSpinButtons: true
]

{ #category : #actions }
WaInput >> blur [

	"Removes focus from the input."

	^ self apply: #blur
]

{ #category : #accessing }
WaInput >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaInput >> defaultValue: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaInput >> disabled [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaInput >> disabled: aBoolean [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaInput >> enterkeyhint [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #accessing }
WaInput >> enterkeyhint: aString [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #actions }
WaInput >> focus [

	"Sets focus on the input."

	^ self apply: #focus
]

{ #category : #actions }
WaInput >> focus: anObject [

	"Sets focus on the input.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaInput >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaInput >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaInput >> hint [

	"The input's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaInput >> hint: aString [

	"The input's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaInput >> inputmode [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Allowed: 'none' | 'text' | 'decimal' | 'numeric' | 'tel' | 'search' | 'email' | 'url'"

	^ self propertyAt: #inputmode
]

{ #category : #accessing }
WaInput >> inputmode: aString [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Allowed: 'none' | 'text' | 'decimal' | 'numeric' | 'tel' | 'search' | 'email' | 'url'"

	self propertyAt: #inputmode put: aString
]

{ #category : #accessing }
WaInput >> label [

	"The input's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaInput >> label: aString [

	"The input's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaInput >> max [

	"The input's maximum value. Only applies to date and number input types.
	
	Type: NumberOrString"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaInput >> max: aNumberOrString [

	"The input's maximum value. Only applies to date and number input types.
	
	Type: NumberOrString"

	self propertyAt: #max put: aNumberOrString
]

{ #category : #accessing }
WaInput >> maxlength [

	"The maximum length of input that will be considered valid.
	
	Type: Number"

	^ self propertyAt: #maxlength
]

{ #category : #accessing }
WaInput >> maxlength: aNumber [

	"The maximum length of input that will be considered valid.
	
	Type: Number"

	self propertyAt: #maxlength put: aNumber
]

{ #category : #accessing }
WaInput >> min [

	"The input's minimum value. Only applies to date and number input types.
	
	Type: NumberOrString"

	^ self propertyAt: #min
]

{ #category : #accessing }
WaInput >> min: aNumberOrString [

	"The input's minimum value. Only applies to date and number input types.
	
	Type: NumberOrString"

	self propertyAt: #min put: aNumberOrString
]

{ #category : #accessing }
WaInput >> minlength [

	"The minimum length of input that will be considered valid.
	
	Type: Number"

	^ self propertyAt: #minlength
]

{ #category : #accessing }
WaInput >> minlength: aNumber [

	"The minimum length of input that will be considered valid.
	
	Type: Number"

	self propertyAt: #minlength put: aNumber
]

{ #category : #accessing }
WaInput >> name [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaInput >> name: aString [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaInput >> passwordToggle [

	"Adds a button to toggle the password's visibility. Only applies to password types.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #passwordToggle
]

{ #category : #accessing }
WaInput >> passwordToggle: aBoolean [

	"Adds a button to toggle the password's visibility. Only applies to password types.
	
	Type: Boolean
	Default: false"

	self propertyAt: #passwordToggle put: aBoolean
]

{ #category : #accessing }
WaInput >> passwordVisible [

	"Determines whether or not the password is currently visible. Only applies to password input types.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #passwordVisible
]

{ #category : #accessing }
WaInput >> passwordVisible: aBoolean [

	"Determines whether or not the password is currently visible. Only applies to password input types.
	
	Type: Boolean
	Default: false"

	self propertyAt: #passwordVisible put: aBoolean
]

{ #category : #accessing }
WaInput >> pattern [

	"A regular expression pattern to validate input against.
	
	Type: String"

	^ self propertyAt: #pattern
]

{ #category : #accessing }
WaInput >> pattern: aString [

	"A regular expression pattern to validate input against.
	
	Type: String"

	self propertyAt: #pattern put: aString
]

{ #category : #accessing }
WaInput >> pill [

	"Draws a pill-style input with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaInput >> pill: aBoolean [

	"Draws a pill-style input with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaInput >> placeholder [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
WaInput >> placeholder: aString [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
WaInput >> readonly [

	"Makes the input readonly.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaInput >> readonly: aBoolean [

	"Makes the input readonly.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaInput >> required [

	"Makes the input a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaInput >> required: aBoolean [

	"Makes the input a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaInput >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaInput >> select [

	"Selects all the text in the input."

	^ self apply: #select
]

{ #category : #actions }
WaInput >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #actions }
WaInput >> setRangeText: aString [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)"

	^ self apply: #setRangeText withArguments: { aString }
]

{ #category : #actions }
WaInput >> setRangeText: aString start: aNumber [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)"

	^ self apply: #setRangeText withArguments: { aString . aNumber }
]

{ #category : #actions }
WaInput >> setRangeTextReplacement: aString start: startNumber end: endNumber [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)
	Parameter: end (number)"

	^ self apply: #setRangeText withArguments: { aString . startNumber . endNumber }
]

{ #category : #actions }
WaInput >> setRangeTextReplacement: replacementString start: startNumber end: endNumber selectMode: selectModeString [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)
	Parameter: end (number)
	Parameter: selectMode (string)"

	^ self apply: #setRangeText withArguments: { replacementString . startNumber . endNumber . selectModeString }
]

{ #category : #actions }
WaInput >> setSelectionRange: startNumber end: endNumber [

	"Sets the start and end positions of the text selection (0-based).
	
	Parameter: start (number)
	Parameter: end (number)"

	^ self apply: #setSelectionRange withArguments: { startNumber . endNumber }
]

{ #category : #actions }
WaInput >> setSelectionRangeStart: startNumber end: endNumber direction: aString [

	"Sets the start and end positions of the text selection (0-based).
	
	Parameter: start (number)
	Parameter: end (number)
	Parameter: direction (string)"

	^ self apply: #setSelectionRange withArguments: { startNumber . endNumber . aString }
]

{ #category : #actions }
WaInput >> showPicker [

	"Displays the browser picker for an input element (only works if the browser supports it for the input type)."

	^ self apply: #showPicker
]

{ #category : #accessing }
WaInput >> size [

	"The input's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaInput >> size: aString [

	"The input's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaInput >> spellcheck [

	"Enables spell checking on the input.
	
	Type: Boolean
	Default: true"

	^ self propertyAt: #spellcheck
]

{ #category : #accessing }
WaInput >> spellcheck: aBoolean [

	"Enables spell checking on the input.
	
	Type: Boolean
	Default: true"

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #accessing }
WaInput >> step [

	"Specifies the granularity that the value must adhere to, or the special value `any` which means no stepping is
	implied, allowing any numeric value. Only applies to date and number input types.
	
	Type: NumberOrString
	Allowed: 'any'"

	^ self propertyAt: #step
]

{ #category : #accessing }
WaInput >> step: aNumberOrString [

	"Specifies the granularity that the value must adhere to, or the special value `any` which means no stepping is
	implied, allowing any numeric value. Only applies to date and number input types.
	
	Type: NumberOrString
	Allowed: 'any'"

	self propertyAt: #step put: aNumberOrString
]

{ #category : #actions }
WaInput >> stepDown [

	"Decrements the value of a numeric input type by the value of the step attribute."

	^ self apply: #stepDown
]

{ #category : #actions }
WaInput >> stepUp [

	"Increments the value of a numeric input type by the value of the step attribute."

	^ self apply: #stepUp
]

{ #category : #accessing }
WaInput >> type [

	"The type of input. Works the same as a native `<input>` element, but only a subset of types are supported. Defaults
	to `text`.
	
	Type: String
	Default: 'text'
	Allowed: 'date' | 'datetime-local' | 'email' | 'number' | 'password' | 'search' | 'tel' | 'text' | 'time' | 'url'"

	^ self propertyAt: #type
]

{ #category : #accessing }
WaInput >> type: aString [

	"The type of input. Works the same as a native `<input>` element, but only a subset of types are supported. Defaults
	to `text`.
	
	Type: String
	Default: 'text'
	Allowed: 'date' | 'datetime-local' | 'email' | 'number' | 'password' | 'search' | 'tel' | 'text' | 'time' | 'url'"

	self propertyAt: #type put: aString
]

{ #category : #accessing }
WaInput >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaInput >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaInput >> value: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaInput >> withClear [

	"Adds a clear button when the input is not empty.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withClear
]

{ #category : #accessing }
WaInput >> withClear: aBoolean [

	"Adds a clear button when the input is not empty.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withClear put: aBoolean
]

{ #category : #accessing }
WaInput >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaInput >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaInput >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaInput >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]

{ #category : #accessing }
WaInput >> withoutSpinButtons [

	"Hides the browser's built-in increment/decrement spin buttons for number inputs.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutSpinButtons
]

{ #category : #accessing }
WaInput >> withoutSpinButtons: aBoolean [

	"Hides the browser's built-in increment/decrement spin buttons for number inputs.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutSpinButtons put: aBoolean
]
