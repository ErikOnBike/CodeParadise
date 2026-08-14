Class {
	#name : #WaOtpInput,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaOtpInput >> appearance [

	"Visual appearance of the segments.
	
	Type: String
	Default: 'outlined'
	Allowed: 'outlined' | 'filled' | 'filled-outlined' | 'contained'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaOtpInput >> appearance: aString [

	"Visual appearance of the segments.
	
	Type: String
	Default: 'outlined'
	Allowed: 'outlined' | 'filled' | 'filled-outlined' | 'contained'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaOtpInput >> appearanceContained [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #contained
]

{ #category : #'accessing - convenience' }
WaOtpInput >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaOtpInput >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaOtpInput >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #accessing }
WaOtpInput >> autocomplete [

	"The `autocomplete` attribute forwarded to the underlying input.
	
	Type: String
	Default: 'one-time-code'"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaOtpInput >> autocomplete: aString [

	"The `autocomplete` attribute forwarded to the underlying input.
	
	Type: String
	Default: 'one-time-code'"

	self propertyAt: #autocomplete put: aString
]

{ #category : #accessing }
WaOtpInput >> autofocus [

	"Automatically focuses the field when the page loads.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #autofocus
]

{ #category : #accessing }
WaOtpInput >> autofocus: aBoolean [

	"Automatically focuses the field when the page loads.
	
	Type: Boolean
	Default: false"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #accessing }
WaOtpInput >> autosubmit [

	"When true, the form is submitted automatically once all segments are filled.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #autosubmit
]

{ #category : #accessing }
WaOtpInput >> autosubmit: aBoolean [

	"When true, the form is submitted automatically once all segments are filled.
	
	Type: Boolean
	Default: false"

	self propertyAt: #autosubmit put: aBoolean
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beAutosubmit [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autosubmit: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beMask [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self mask: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotAutosubmit [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autosubmit: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotMask [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self mask: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beWithMask [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMask: true
]

{ #category : #'accessing - convenience' }
WaOtpInput >> beWithoutMask [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMask: false
]

{ #category : #actions }
WaOtpInput >> blur [

	"Removes focus from the field."

	^ self apply: #blur
]

{ #category : #accessing }
WaOtpInput >> case [

	"Case transformation applied to entered characters.
	
	Type: String
	Default: 'preserve'
	Allowed: 'preserve' | 'upper' | 'lower'"

	^ self propertyAt: #case
]

{ #category : #accessing }
WaOtpInput >> case: aString [

	"Case transformation applied to entered characters.
	
	Type: String
	Default: 'preserve'
	Allowed: 'preserve' | 'upper' | 'lower'"

	self propertyAt: #case put: aString
]

{ #category : #actions }
WaOtpInput >> clear [

	"Clears the current value and returns focus to the field."

	^ self apply: #clear
]

{ #category : #accessing }
WaOtpInput >> defaultValue [

	"The default value. Used to restore the field on form reset. Reflects the `value` HTML attribute.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaOtpInput >> defaultValue: aString [

	"The default value. Used to restore the field on form reset. Reflects the `value` HTML attribute.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaOtpInput >> disabled [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaOtpInput >> disabled: aBoolean [

	"Disables the form control.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaOtpInput >> effectiveLength [

	"Number of segments derived from `format` (count of `#`) or `length`.
	
	Type: Number
	Read-only: true"

	^ self propertyAt: #effectiveLength
]

{ #category : #actions }
WaOtpInput >> focus [

	"Focuses the field."

	^ self apply: #focus
]

{ #category : #actions }
WaOtpInput >> focus: anObject [

	"Focuses the field.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaOtpInput >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaOtpInput >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaOtpInput >> format [

	"Segment format string using `#` as a segment placeholder and any other character as a literal separator.
	Setting `format` overrides `length` (the segment count is derived from the number of `#` characters).
	
	Type: String
	Default: ''"

	^ self propertyAt: #format
]

{ #category : #accessing }
WaOtpInput >> format: aString [

	"Segment format string using `#` as a segment placeholder and any other character as a literal separator.
	Setting `format` overrides `length` (the segment count is derived from the number of `#` characters).
	
	Type: String
	Default: ''"

	self propertyAt: #format put: aString
]

{ #category : #accessing }
WaOtpInput >> hint [

	"Hint text shown below the segments. Use the `hint` slot for HTML content.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaOtpInput >> hint: aString [

	"Hint text shown below the segments. Use the `hint` slot for HTML content.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #'accessing - slots' }
WaOtpInput >> hintElement [

	"Optional hint text. Use this for hints that contain HTML. When `hint` attribute is set it takes priority."

	^ self firstChildAtSlotNamed: #hint
]

{ #category : #'accessing - slots' }
WaOtpInput >> hintElement: anElement [

	"Optional hint text. Use this for hints that contain HTML. When `hint` attribute is set it takes priority."

	self replaceAllChildrenWith: anElement atSlotNamed: #hint
]

{ #category : #accessing }
WaOtpInput >> input [

	"The real `<input>` used for form association and validation (visually hidden).
	
	Type: Object ((HTMLElement & { value: unknown }) | HTMLInputElement | HTMLTextAreaElement | undefined)"

	^ self propertyAt: #input
]

{ #category : #accessing }
WaOtpInput >> input: anObject [

	"The real `<input>` used for form association and validation (visually hidden).
	
	Type: Object ((HTMLElement & { value: unknown }) | HTMLInputElement | HTMLTextAreaElement | undefined)"

	self propertyAt: #input put: anObject
]

{ #category : #accessing }
WaOtpInput >> label [

	"A label shown above the segments. Use the `label` slot for HTML content.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaOtpInput >> label: aString [

	"A label shown above the segments. Use the `label` slot for HTML content.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaOtpInput >> labelElement [

	"An optional label. Use this for labels that contain HTML. When `label` attribute is set it takes priority."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #'accessing - slots' }
WaOtpInput >> labelElement: anElement [

	"An optional label. Use this for labels that contain HTML. When `label` attribute is set it takes priority."

	self replaceAllChildrenWith: anElement atSlotNamed: #label
]

{ #category : #accessing }
WaOtpInput >> length [

	"Number of character segments to display. Overridden by `format` when set.
	
	Type: Number
	Default: 6"

	^ self propertyAt: #length
]

{ #category : #accessing }
WaOtpInput >> length: aNumber [

	"Number of character segments to display. Overridden by `format` when set.
	
	Type: Number
	Default: 6"

	self propertyAt: #length put: aNumber
]

{ #category : #accessing }
WaOtpInput >> mask [

	"When true, entered characters are displayed as `--mask-char` instead of their real value.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #mask
]

{ #category : #accessing }
WaOtpInput >> mask: aBoolean [

	"When true, entered characters are displayed as `--mask-char` instead of their real value.
	
	Type: Boolean
	Default: false"

	self propertyAt: #mask put: aBoolean
]

{ #category : #accessing }
WaOtpInput >> name [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaOtpInput >> name: aString [

	"The name of the input, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaOtpInput >> readonly [

	"Makes the field readonly — the value displays but cannot be edited by the user.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaOtpInput >> readonly: aBoolean [

	"Makes the field readonly — the value displays but cannot be edited by the user.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaOtpInput >> required [

	"Makes the field required. A partially-filled field is always invalid regardless of this attribute.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaOtpInput >> required: aBoolean [

	"Makes the field required. A partially-filled field is always invalid regardless of this attribute.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaOtpInput >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaOtpInput >> select [

	"Selects all entered characters in the hidden input."

	^ self apply: #select
]

{ #category : #actions }
WaOtpInput >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaOtpInput >> size [

	"The size of each segment.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaOtpInput >> size: aString [

	"The size of each segment.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaOtpInput >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaOtpInput >> slotNames [

	^ #(#label #hint)
]

{ #category : #accessing }
WaOtpInput >> type [

	"Allowed character class.
	
	Type: String
	Default: 'numeric'
	Allowed: 'numeric' | 'alpha' | 'alphanumeric'"

	^ self propertyAt: #type
]

{ #category : #accessing }
WaOtpInput >> type: aString [

	"Allowed character class.
	
	Type: String
	Default: 'numeric'
	Allowed: 'numeric' | 'alpha' | 'alphanumeric'"

	self propertyAt: #type put: aString
]

{ #category : #accessing }
WaOtpInput >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaOtpInput >> value [

	"The default value. Used to restore the field on form reset. Reflects the `value` HTML attribute.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaOtpInput >> value: aString [

	"The default value. Used to restore the field on form reset. Reflects the `value` HTML attribute.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaOtpInput >> withMask [

	"When true, empty segments show `--mask-char` as a hint instead of appearing blank, similar to
	how a password field communicates its expected length before anything is typed.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withMask
]

{ #category : #accessing }
WaOtpInput >> withMask: aBoolean [

	"When true, empty segments show `--mask-char` as a hint instead of appearing blank, similar to
	how a password field communicates its expected length before anything is typed.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withMask put: aBoolean
]
