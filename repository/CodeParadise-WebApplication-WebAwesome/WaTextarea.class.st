Class {
	#name : #WaTextarea,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTextarea >> appearance [

	"The textarea's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaTextarea >> appearance: aString [

	"The textarea's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #accessing }
WaTextarea >> autocapitalize [

	"Controls whether and how text input is automatically capitalized as it is entered by the user.
	
	Type: String
	Allowed: 'off' | 'none' | 'on' | 'sentences' | 'words' | 'characters'"

	^ self propertyAt: #autocapitalize
]

{ #category : #accessing }
WaTextarea >> autocapitalize: aString [

	"Controls whether and how text input is automatically capitalized as it is entered by the user.
	
	Type: String
	Allowed: 'off' | 'none' | 'on' | 'sentences' | 'words' | 'characters'"

	self propertyAt: #autocapitalize put: aString
]

{ #category : #accessing }
WaTextarea >> autocomplete [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaTextarea >> autocomplete: aString [

	"Specifies what permission the browser has to provide assistance in filling out form field values. Refer to
	[this page on MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) for available values.
	
	Type: String"

	self propertyAt: #autocomplete put: aString
]

{ #category : #accessing }
WaTextarea >> autocorrect [

	"Indicates whether the browser's autocorrect feature is on or off. When set as an attribute, use `""off""` or `""on""`.
	When set as a property, use `true` or `false`.
	
	Type: Boolean"

	^ self propertyAt: #autocorrect
]

{ #category : #accessing }
WaTextarea >> autocorrect: aBoolean [

	"Indicates whether the browser's autocorrect feature is on or off. When set as an attribute, use `""off""` or `""on""`.
	When set as a property, use `true` or `false`.
	
	Type: Boolean"

	self propertyAt: #autocorrect put: aBoolean
]

{ #category : #accessing }
WaTextarea >> autofocus [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	^ self propertyAt: #autofocus
]

{ #category : #accessing }
WaTextarea >> autofocus: aBoolean [

	"Indicates that the input should receive focus on page load.
	
	Type: Boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #convenience }
WaTextarea >> beAutocorrect [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autocorrect: true
]

{ #category : #convenience }
WaTextarea >> beAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: true
]

{ #category : #convenience }
WaTextarea >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaTextarea >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaTextarea >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaTextarea >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaTextarea >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaTextarea >> beNotAutocorrect [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autocorrect: false
]

{ #category : #convenience }
WaTextarea >> beNotAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: false
]

{ #category : #convenience }
WaTextarea >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaTextarea >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #convenience }
WaTextarea >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #convenience }
WaTextarea >> beNotSpellcheck [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self spellcheck: false
]

{ #category : #convenience }
WaTextarea >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaTextarea >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #convenience }
WaTextarea >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #convenience }
WaTextarea >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaTextarea >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaTextarea >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaTextarea >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaTextarea >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaTextarea >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaTextarea >> beSpellcheck [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self spellcheck: true
]

{ #category : #convenience }
WaTextarea >> beWithCount [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withCount: true
]

{ #category : #convenience }
WaTextarea >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #convenience }
WaTextarea >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #convenience }
WaTextarea >> beWithoutCount [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withCount: false
]

{ #category : #convenience }
WaTextarea >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #convenience }
WaTextarea >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #actions }
WaTextarea >> blur [

	"Removes focus from the textarea."

	^ self apply: #blur
]

{ #category : #accessing }
WaTextarea >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaTextarea >> defaultValue: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaTextarea >> disabled [

	"Disables the textarea.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaTextarea >> disabled: aBoolean [

	"Disables the textarea.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaTextarea >> enterkeyhint [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	^ self propertyAt: #enterkeyhint
]

{ #category : #accessing }
WaTextarea >> enterkeyhint: aString [

	"Used to customize the label or icon of the Enter key on virtual keyboards.
	
	Type: String
	Allowed: 'enter' | 'done' | 'go' | 'next' | 'previous' | 'search' | 'send'"

	self propertyAt: #enterkeyhint put: aString
]

{ #category : #actions }
WaTextarea >> focus [

	"Sets focus on the textarea."

	^ self apply: #focus
]

{ #category : #actions }
WaTextarea >> focus: anObject [

	"Sets focus on the textarea.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaTextarea >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaTextarea >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaTextarea >> hint [

	"The textarea's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaTextarea >> hint: aString [

	"The textarea's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaTextarea >> inputmode [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Allowed: 'none' | 'text' | 'decimal' | 'numeric' | 'tel' | 'search' | 'email' | 'url'"

	^ self propertyAt: #inputmode
]

{ #category : #accessing }
WaTextarea >> inputmode: aString [

	"Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
	keyboard on supportive devices.
	
	Type: String
	Allowed: 'none' | 'text' | 'decimal' | 'numeric' | 'tel' | 'search' | 'email' | 'url'"

	self propertyAt: #inputmode put: aString
]

{ #category : #accessing }
WaTextarea >> label [

	"The textarea's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaTextarea >> label: aString [

	"The textarea's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaTextarea >> maxlength [

	"The maximum length of input that will be considered valid.
	
	Type: Number"

	^ self propertyAt: #maxlength
]

{ #category : #accessing }
WaTextarea >> maxlength: aNumber [

	"The maximum length of input that will be considered valid.
	
	Type: Number"

	self propertyAt: #maxlength put: aNumber
]

{ #category : #accessing }
WaTextarea >> minlength [

	"The minimum length of input that will be considered valid.
	
	Type: Number"

	^ self propertyAt: #minlength
]

{ #category : #accessing }
WaTextarea >> minlength: aNumber [

	"The minimum length of input that will be considered valid.
	
	Type: Number"

	self propertyAt: #minlength put: aNumber
]

{ #category : #accessing }
WaTextarea >> name [

	"The name of the textarea, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaTextarea >> name: aString [

	"The name of the textarea, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaTextarea >> placeholder [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
WaTextarea >> placeholder: aString [

	"Placeholder text to show as a hint when the input is empty.
	
	Type: String
	Default: ''"

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
WaTextarea >> readonly [

	"Makes the textarea readonly.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaTextarea >> readonly: aBoolean [

	"Makes the textarea readonly.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaTextarea >> required [

	"Makes the textarea a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaTextarea >> required: aBoolean [

	"Makes the textarea a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaTextarea >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #accessing }
WaTextarea >> resize [

	"Controls how the textarea can be resized.
	
	Type: String
	Default: 'vertical'
	Allowed: 'none' | 'vertical' | 'horizontal' | 'both' | 'auto'"

	^ self propertyAt: #resize
]

{ #category : #accessing }
WaTextarea >> resize: aString [

	"Controls how the textarea can be resized.
	
	Type: String
	Default: 'vertical'
	Allowed: 'none' | 'vertical' | 'horizontal' | 'both' | 'auto'"

	self propertyAt: #resize put: aString
]

{ #category : #accessing }
WaTextarea >> rows [

	"The number of rows to display by default.
	
	Type: Number
	Default: 4"

	^ self propertyAt: #rows
]

{ #category : #accessing }
WaTextarea >> rows: aNumber [

	"The number of rows to display by default.
	
	Type: Number
	Default: 4"

	self propertyAt: #rows put: aNumber
]

{ #category : #actions }
WaTextarea >> scrollPosition [

	"Gets or sets the textarea's scroll position.
	
	Return type: { top: number; left: number } | undefined"

	^ self apply: #scrollPosition
]

{ #category : #actions }
WaTextarea >> scrollPosition: anObject [

	"Gets or sets the textarea's scroll position.
	
	Return type: { top: number; left: number } | undefined
	Parameter: position ({ top?: number; left?: number })"

	^ self apply: #scrollPosition withArguments: { anObject }
]

{ #category : #actions }
WaTextarea >> select [

	"Selects all the text in the textarea."

	^ self apply: #select
]

{ #category : #actions }
WaTextarea >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #actions }
WaTextarea >> setRangeText: aString [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)"

	^ self apply: #setRangeText withArguments: { aString }
]

{ #category : #actions }
WaTextarea >> setRangeText: aString start: aNumber [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)"

	^ self apply: #setRangeText withArguments: { aString . aNumber }
]

{ #category : #actions }
WaTextarea >> setRangeTextReplacement: aString start: startNumber end: endNumber [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)
	Parameter: end (number)"

	^ self apply: #setRangeText withArguments: { aString . startNumber . endNumber }
]

{ #category : #actions }
WaTextarea >> setRangeTextReplacement: replacementString start: startNumber end: endNumber selectMode: selectModeString [

	"Replaces a range of text with a new string.
	
	Parameter: replacement (string)
	Parameter: start (number)
	Parameter: end (number)
	Parameter: selectMode (string)"

	^ self apply: #setRangeText withArguments: { replacementString . startNumber . endNumber . selectModeString }
]

{ #category : #actions }
WaTextarea >> setSelectionRange: startNumber end: endNumber [

	"Sets the start and end positions of the text selection (0-based).
	
	Parameter: start (number)
	Parameter: end (number)"

	^ self apply: #setSelectionRange withArguments: { startNumber . endNumber }
]

{ #category : #actions }
WaTextarea >> setSelectionRangeStart: startNumber end: endNumber direction: aString [

	"Sets the start and end positions of the text selection (0-based).
	
	Parameter: start (number)
	Parameter: end (number)
	Parameter: direction (string)"

	^ self apply: #setSelectionRange withArguments: { startNumber . endNumber . aString }
]

{ #category : #accessing }
WaTextarea >> size [

	"The textarea's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaTextarea >> size: aString [

	"The textarea's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaTextarea >> spellcheck [

	"Enables spell checking on the textarea.
	
	Type: Boolean
	Default: true"

	^ self propertyAt: #spellcheck
]

{ #category : #accessing }
WaTextarea >> spellcheck: aBoolean [

	"Enables spell checking on the textarea.
	
	Type: Boolean
	Default: true"

	self propertyAt: #spellcheck put: aBoolean
]

{ #category : #accessing }
WaTextarea >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaTextarea >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaTextarea >> value: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaTextarea >> withCount [

	"Shows a character count below the textarea. When `maxlength` is set, shows remaining characters instead.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withCount
]

{ #category : #accessing }
WaTextarea >> withCount: aBoolean [

	"Shows a character count below the textarea. When `maxlength` is set, shows remaining characters instead.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withCount put: aBoolean
]

{ #category : #accessing }
WaTextarea >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaTextarea >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaTextarea >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaTextarea >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]
