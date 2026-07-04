Class {
	#name : #WaKnownDate,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaKnownDate >> appearance [

	"The known date's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaKnownDate >> appearance: aString [

	"The known date's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaKnownDate >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaKnownDate >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaKnownDate >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #accessing }
WaKnownDate >> autocomplete [

	"Browser autofill family. When set to `bday`, the three fields receive `bday-day`, `bday-month`, and
	`bday-year` respectively. The field-agnostic directives `off` and `on` are applied to all three fields.
	Any other value is forwarded only to the year field.
	
	Type: String
	Default: ''"

	^ self propertyAt: #autocomplete
]

{ #category : #accessing }
WaKnownDate >> autocomplete: aString [

	"Browser autofill family. When set to `bday`, the three fields receive `bday-day`, `bday-month`, and
	`bday-year` respectively. The field-agnostic directives `off` and `on` are applied to all three fields.
	Any other value is forwarded only to the year field.
	
	Type: String
	Default: ''"

	self propertyAt: #autocomplete put: aString
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaKnownDate >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
WaKnownDate >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #actions }
WaKnownDate >> blur [

	"Removes focus from the known date."

	^ self apply: #blur
]

{ #category : #accessing }
WaKnownDate >> defaultValue [

	"The default value used for form reset.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaKnownDate >> defaultValue: aString [

	"The default value used for form reset.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaKnownDate >> disabled [

	"Disables the known date.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaKnownDate >> disabled: aBoolean [

	"Disables the known date.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaKnownDate >> focus [

	"Focuses the first empty field, or the first field when all are filled."

	^ self apply: #focus
]

{ #category : #actions }
WaKnownDate >> focus: anObject [

	"Focuses the first empty field, or the first field when all are filled.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaKnownDate >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaKnownDate >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaKnownDate >> hint [

	"The known date's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaKnownDate >> hint: aString [

	"The known date's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #'accessing - slots' }
WaKnownDate >> hintElement [

	"Text that describes how to use the known date. Alternatively, use the `hint` attribute."

	^ self firstChildAtSlotNamed: #hint
]

{ #category : #'accessing - slots' }
WaKnownDate >> hintElement: anElement [

	"Text that describes how to use the known date. Alternatively, use the `hint` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #hint
]

{ #category : #accessing }
WaKnownDate >> label [

	"The known date's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaKnownDate >> label: aString [

	"The known date's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaKnownDate >> labelElement [

	"The known date's group label. Alternatively, use the `label` attribute."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #'accessing - slots' }
WaKnownDate >> labelElement: anElement [

	"The known date's group label. Alternatively, use the `label` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #label
]

{ #category : #accessing }
WaKnownDate >> locale [

	"BCP-47 locale override. When empty, the inherited `lang` attribute is used.
	
	Type: String
	Default: ''"

	^ self propertyAt: #locale
]

{ #category : #accessing }
WaKnownDate >> locale: aString [

	"BCP-47 locale override. When empty, the inherited `lang` attribute is used.
	
	Type: String
	Default: ''"

	self propertyAt: #locale put: aString
]

{ #category : #accessing }
WaKnownDate >> max [

	"Latest selectable date as `YYYY-MM-DD`.
	
	Type: String
	Default: ''"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaKnownDate >> max: aString [

	"Latest selectable date as `YYYY-MM-DD`.
	
	Type: String
	Default: ''"

	self propertyAt: #max put: aString
]

{ #category : #accessing }
WaKnownDate >> min [

	"Earliest selectable date as `YYYY-MM-DD`.
	
	Type: String
	Default: ''"

	^ self propertyAt: #min
]

{ #category : #accessing }
WaKnownDate >> min: aString [

	"Earliest selectable date as `YYYY-MM-DD`.
	
	Type: String
	Default: ''"

	self propertyAt: #min put: aString
]

{ #category : #accessing }
WaKnownDate >> name [

	"The name submitted with form data.
	
	Type: String
	Default: ''"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaKnownDate >> name: aString [

	"The name submitted with form data.
	
	Type: String
	Default: ''"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaKnownDate >> parts [

	"The three field strings. Stored verbatim so user-typed digits round-trip faithfully.
	
	Type: Object (DateParts)"

	^ self propertyAt: #parts
]

{ #category : #accessing }
WaKnownDate >> parts: anObject [

	"The three field strings. Stored verbatim so user-typed digits round-trip faithfully.
	
	Type: Object (DateParts)"

	self propertyAt: #parts put: anObject
]

{ #category : #accessing }
WaKnownDate >> pill [

	"Draws pill-style fields with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaKnownDate >> pill: aBoolean [

	"Draws pill-style fields with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaKnownDate >> readonly [

	"Makes the fields non-editable.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaKnownDate >> readonly: aBoolean [

	"Makes the fields non-editable.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #accessing }
WaKnownDate >> required [

	"Makes the known date required for form submission.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaKnownDate >> required: aBoolean [

	"Makes the known date required for form submission.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaKnownDate >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaKnownDate >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaKnownDate >> size [

	"The known date's size.
	
	Type: String
	Default: 'm'
	Allowed: 's' | 'xs' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaKnownDate >> size: aString [

	"The known date's size.
	
	Type: String
	Default: 'm'
	Allowed: 's' | 'xs' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaKnownDate >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #accessing }
WaKnownDate >> validationTarget [

	"Anchor native validation popups on a real visible input. The hidden mirror handles form data, but
	anchoring a popup on `display: none` content would render it at offset (0, 0).
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaKnownDate >> value [

	"The default value used for form reset.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaKnownDate >> value: aString [

	"The default value used for form reset.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaKnownDate >> valueAsDate [

	"The committed value as a `Date`, or `null` when the value is empty/invalid.
	
	Type: Date
	Read-only: true"

	^ self propertyAt: #valueAsDate
]

{ #category : #accessing }
WaKnownDate >> valueInput [

	"Hidden mirror used for native constraint validation (min/max/required + valid-date roundtrip).
	
	Type: Object (HTMLInputElement)"

	^ self propertyAt: #valueInput
]

{ #category : #accessing }
WaKnownDate >> valueInput: anObject [

	"Hidden mirror used for native constraint validation (min/max/required + valid-date roundtrip).
	
	Type: Object (HTMLInputElement)"

	self propertyAt: #valueInput put: anObject
]

{ #category : #accessing }
WaKnownDate >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaKnownDate >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaKnownDate >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaKnownDate >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]
