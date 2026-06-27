Class {
	#name : #WaTimeInput,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTimeInput >> appearance [

	"The time picker's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaTimeInput >> appearance: aString [

	"The time picker's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #accessing }
WaTimeInput >> assumeInteractionOn [

	"Every segment edit dispatches `input`, so a single observed `input` event marks the field as interacted with.
	
	Type: Array (string[])"

	^ self propertyAt: #assumeInteractionOn
]

{ #category : #accessing }
WaTimeInput >> assumeInteractionOn: anArray [

	"Every segment edit dispatches `input`, so a single observed `input` event marks the field as interacted with.
	
	Type: Array (string[])"

	self propertyAt: #assumeInteractionOn put: anArray
]

{ #category : #accessing }
WaTimeInput >> autocomplete [

	"Forwarded to the hidden form input to enable browser autofill (`on`/`off`/custom tokens).
	
	Type: String
	Default: ''"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaTimeInput >> autocomplete: aString [

	"Forwarded to the hidden form input to enable browser autofill (`on`/`off`/custom tokens).
	
	Type: String
	Default: ''"

	self propertyAt: #autocomplete put: aString
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaTimeInput >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithNow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withNow: true
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithoutClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #'accessing - convenience' }
WaTimeInput >> beWithoutNow [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withNow: false
]

{ #category : #actions }
WaTimeInput >> blur [

	"Removes focus from the time picker."

	^ self apply: #blur
]

{ #category : #accessing }
WaTimeInput >> defaultValue [

	"The default value of the form control. Used for form reset.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaTimeInput >> defaultValue: aString [

	"The default value of the form control. Used for form reset.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaTimeInput >> disabled [

	"Disables the time picker.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaTimeInput >> disabled: aBoolean [

	"Disables the time picker.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> distance [

	"Distance in pixels between the popup and the input.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #distance
]

{ #category : #accessing }
WaTimeInput >> distance: aNumber [

	"Distance in pixels between the popup and the input.
	
	Type: Number
	Default: 0"

	self propertyAt: #distance put: aNumber
]

{ #category : #actions }
WaTimeInput >> focus [

	"Sets focus on the first empty (else first) segment."

	^ self apply: #focus
]

{ #category : #actions }
WaTimeInput >> focus: anObject [

	"Sets focus on the first empty (else first) segment.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaTimeInput >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaTimeInput >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #actions }
WaTimeInput >> hide [

	"Closes the popup.
	
	Return type: Promise<void>"

	^ self apply: #hide
]

{ #category : #accessing }
WaTimeInput >> hint [

	"The time picker's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaTimeInput >> hint: aString [

	"The time picker's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaTimeInput >> hourFormat [

	"Whether the UI uses a 12-hour or 24-hour clock. `auto` follows the resolved locale.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | '12' | '24'"

	^ self propertyAt: #hourFormat
]

{ #category : #accessing }
WaTimeInput >> hourFormat: aString [

	"Whether the UI uses a 12-hour or 24-hour clock. `auto` follows the resolved locale.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | '12' | '24'"

	self propertyAt: #hourFormat put: aString
]

{ #category : #accessing }
WaTimeInput >> label [

	"The time picker's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaTimeInput >> label: aString [

	"The time picker's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaTimeInput >> max [

	"The latest selectable time in wire format.
	
	Type: String
	Default: ''"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaTimeInput >> max: aString [

	"The latest selectable time in wire format.
	
	Type: String
	Default: ''"

	self propertyAt: #max put: aString
]

{ #category : #accessing }
WaTimeInput >> min [

	"The earliest selectable time in wire format. May be later than `max` to represent an overnight range. The picker
	delegates reversed-range semantics to the mirrored native `<input type=""time"">`.
	
	Type: String
	Default: ''"

	^ self propertyAt: #min
]

{ #category : #accessing }
WaTimeInput >> min: aString [

	"The earliest selectable time in wire format. May be later than `max` to represent an overnight range. The picker
	delegates reversed-range semantics to the mirrored native `<input type=""time"">`.
	
	Type: String
	Default: ''"

	self propertyAt: #min put: aString
]

{ #category : #accessing }
WaTimeInput >> name [

	"The time picker's name, submitted as a name/value pair with form data.
	
	Type: String
	Default: ''"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaTimeInput >> name: aString [

	"The time picker's name, submitted as a name/value pair with form data.
	
	Type: String
	Default: ''"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaTimeInput >> open [

	"Whether the popup is open.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaTimeInput >> open: aBoolean [

	"Whether the popup is open.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> pill [

	"Draws a pill-style time picker with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaTimeInput >> pill: aBoolean [

	"Draws a pill-style time picker with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> placement [

	"Preferred popup placement.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaTimeInput >> placement: aString [

	"Preferred popup placement.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end'"

	self propertyAt: #placement put: aString
]

{ #category : #accessing }
WaTimeInput >> readonly [

	"Makes the input non-editable. The popup still opens for browsing.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaTimeInput >> readonly: aBoolean [

	"Makes the input non-editable. The popup still opens for browsing.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> required [

	"Makes the time picker required for form submission.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaTimeInput >> required: aBoolean [

	"Makes the time picker required for form submission.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaTimeInput >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaTimeInput >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #actions }
WaTimeInput >> show [

	"Opens the popup.
	
	Return type: Promise<void>"

	^ self apply: #show
]

{ #category : #accessing }
WaTimeInput >> size [

	"The time picker's size.
	
	Type: String
	Default: 'm'
	Allowed: 's' | 'xs' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaTimeInput >> size: aString [

	"The time picker's size.
	
	Type: String
	Default: 'm'
	Allowed: 's' | 'xs' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaTimeInput >> step [

	"The granularity, in seconds, matching HTML `<input type=""time"">`. Default `60` hides the seconds segment.
	Values below 60 reveal the seconds segment. `'any'` disables `stepMismatch` enforcement.
	
	Type: NumberOrString
	Default: 60
	Allowed: 'any'"

	^ self propertyAt: #step
]

{ #category : #accessing }
WaTimeInput >> step: aNumberOrString [

	"The granularity, in seconds, matching HTML `<input type=""time"">`. Default `60` hides the seconds segment.
	Values below 60 reveal the seconds segment. `'any'` disables `stepMismatch` enforcement.
	
	Type: NumberOrString
	Default: 60
	Allowed: 'any'"

	self propertyAt: #step put: aNumberOrString
]

{ #category : #accessing }
WaTimeInput >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaTimeInput >> value [

	"The default value of the form control. Used for form reset.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaTimeInput >> value: aString [

	"The default value of the form control. Used for form reset.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaTimeInput >> valueAsDate [

	"The time as a `Date` (today + wire value), or `null` when empty.
	
	Type: Date
	Read-only: true"

	^ self propertyAt: #valueAsDate
]

{ #category : #accessing }
WaTimeInput >> valueAsNumber [

	"Milliseconds since midnight, or `NaN` when empty.
	
	Type: Number
	Read-only: true"

	^ self propertyAt: #valueAsNumber
]

{ #category : #accessing }
WaTimeInput >> withClear [

	"Shows a clear button when the time picker has a value.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withClear
]

{ #category : #accessing }
WaTimeInput >> withClear: aBoolean [

	"Shows a clear button when the time picker has a value.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withClear put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaTimeInput >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaTimeInput >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]

{ #category : #accessing }
WaTimeInput >> withNow [

	"Renders a ""Now"" button in the popup footer.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withNow
]

{ #category : #accessing }
WaTimeInput >> withNow: aBoolean [

	"Renders a ""Now"" button in the popup footer.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withNow put: aBoolean
]
