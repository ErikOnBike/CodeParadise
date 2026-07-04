Class {
	#name : #WaSelect,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaSelect >> appearance [

	"The select's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaSelect >> appearance: aString [

	"The select's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaSelect >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaSelect >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaSelect >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaSelect >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beMultiple [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self multiple: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beNotMultiple [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self multiple: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beNotPill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaSelect >> bePill [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pill: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithoutClear [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withClear: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
WaSelect >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #actions }
WaSelect >> blur [

	"Removes focus from the control."

	^ self apply: #blur
]

{ #category : #'accessing - slots' }
WaSelect >> clearIconElement [

	"An icon to use in lieu of the default clear icon."

	^ self firstChildAtSlotNamed: #'clear-icon'
]

{ #category : #'accessing - slots' }
WaSelect >> clearIconElement: anElement [

	"An icon to use in lieu of the default clear icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'clear-icon'
]

{ #category : #accessing }
WaSelect >> disabled [

	"Disables the select control.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaSelect >> disabled: aBoolean [

	"Disables the select control.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #'accessing - slots' }
WaSelect >> endElement [

	"An element, such as `<wa-icon>`, placed at the end of the combobox."

	^ self firstChildAtSlotNamed: #end
]

{ #category : #'accessing - slots' }
WaSelect >> endElement: anElement [

	"An element, such as `<wa-icon>`, placed at the end of the combobox."

	self replaceAllChildrenWith: anElement atSlotNamed: #end
]

{ #category : #'accessing - slots' }
WaSelect >> expandIconElement [

	"The icon to show when the control is expanded and collapsed. Rotates on open and close."

	^ self firstChildAtSlotNamed: #'expand-icon'
]

{ #category : #'accessing - slots' }
WaSelect >> expandIconElement: anElement [

	"The icon to show when the control is expanded and collapsed. Rotates on open and close."

	self replaceAllChildrenWith: anElement atSlotNamed: #'expand-icon'
]

{ #category : #actions }
WaSelect >> focus [

	"Sets focus on the control."

	^ self apply: #focus
]

{ #category : #actions }
WaSelect >> focus: anObject [

	"Sets focus on the control.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaSelect >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaSelect >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaSelect >> getTag [

	"A function that customizes the tags to be rendered when multiple=true. The first argument is the option, the second
	is the current tag's index.  The function should return either a Lit TemplateResult or a string containing trusted
	HTML of the symbol to render at the specified value.
	
	Type: Block ((option: WaOption, index: number) => TemplateResult | string | HTMLElement)"

	^ (self propertyAt: #getTag) ifNotNil: [ :function | function asBlock ifNil: [ function ] ]
]

{ #category : #accessing }
WaSelect >> getTag: aBlock [

	"A function that customizes the tags to be rendered when multiple=true. The first argument is the option, the second
	is the current tag's index.  The function should return either a Lit TemplateResult or a string containing trusted
	HTML of the symbol to render at the specified value.
	
	Type: Block ((option: WaOption, index: number) => TemplateResult | string | HTMLElement)"

	self propertyAt: #getTag put: aBlock asJavaScriptFunction
]

{ #category : #actions }
WaSelect >> hide [

	"Hides the listbox."

	^ self apply: #hide
]

{ #category : #accessing }
WaSelect >> hint [

	"The select's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaSelect >> hint: aString [

	"The select's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #'accessing - slots' }
WaSelect >> hintElement [

	"Text that describes how to use the input. Alternatively, you can use the `hint` attribute."

	^ self firstChildAtSlotNamed: #hint
]

{ #category : #'accessing - slots' }
WaSelect >> hintElement: anElement [

	"Text that describes how to use the input. Alternatively, you can use the `hint` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #hint
]

{ #category : #accessing }
WaSelect >> label [

	"The select's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaSelect >> label: aString [

	"The select's label. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaSelect >> labelElement [

	"The input's label. Alternatively, you can use the `label` attribute."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #'accessing - slots' }
WaSelect >> labelElement: anElement [

	"The input's label. Alternatively, you can use the `label` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #label
]

{ #category : #accessing }
WaSelect >> maxOptionsVisible [

	"The maximum number of selected options to show when `multiple` is true. After the maximum, ""+n"" will be shown to
	indicate the number of additional items that are selected. Set to 0 to remove the limit.
	
	Type: Number
	Default: 3"

	^ self propertyAt: #maxOptionsVisible
]

{ #category : #accessing }
WaSelect >> maxOptionsVisible: aNumber [

	"The maximum number of selected options to show when `multiple` is true. After the maximum, ""+n"" will be shown to
	indicate the number of additional items that are selected. Set to 0 to remove the limit.
	
	Type: Number
	Default: 3"

	self propertyAt: #maxOptionsVisible put: aNumber
]

{ #category : #accessing }
WaSelect >> multiple [

	"Allows more than one option to be selected.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #multiple
]

{ #category : #accessing }
WaSelect >> multiple: aBoolean [

	"Allows more than one option to be selected.
	
	Type: Boolean
	Default: false"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #accessing }
WaSelect >> name [

	"The name of the select, submitted as a name/value pair with form data.
	
	Type: String
	Default: ''"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaSelect >> name: aString [

	"The name of the select, submitted as a name/value pair with form data.
	
	Type: String
	Default: ''"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaSelect >> open [

	"Indicates whether or not the select is open. You can toggle this attribute to show and hide the menu, or you can
	use the `show()` and `hide()` methods and this attribute will reflect the select's open state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaSelect >> open: aBoolean [

	"Indicates whether or not the select is open. You can toggle this attribute to show and hide the menu, or you can
	use the `show()` and `hide()` methods and this attribute will reflect the select's open state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaSelect >> pill [

	"Draws a pill-style select with rounded edges.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pill
]

{ #category : #accessing }
WaSelect >> pill: aBoolean [

	"Draws a pill-style select with rounded edges.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
WaSelect >> placeholder [

	"Placeholder text to show as a hint when the select is empty.
	
	Type: String
	Default: ''"

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
WaSelect >> placeholder: aString [

	"Placeholder text to show as a hint when the select is empty.
	
	Type: String
	Default: ''"

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
WaSelect >> placement [

	"The preferred placement of the select's menu. Note that the actual placement may vary as needed to keep the listbox
	inside of the viewport.
	
	Type: String
	Default: 'bottom'
	Allowed: 'top' | 'bottom'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaSelect >> placement: aString [

	"The preferred placement of the select's menu. Note that the actual placement may vary as needed to keep the listbox
	inside of the viewport.
	
	Type: String
	Default: 'bottom'
	Allowed: 'top' | 'bottom'"

	self propertyAt: #placement put: aString
]

{ #category : #'accessing - convenience' }
WaSelect >> placementBottom [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #bottom
]

{ #category : #'accessing - convenience' }
WaSelect >> placementTop [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self placement: #top
]

{ #category : #accessing }
WaSelect >> required [

	"The select's required attribute.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaSelect >> required: aBoolean [

	"The select's required attribute.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaSelect >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaSelect >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #actions }
WaSelect >> show [

	"Shows the listbox."

	^ self apply: #show
]

{ #category : #accessing }
WaSelect >> size [

	"The select's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaSelect >> size: aString [

	"The select's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaSelect >> sizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - slots' }
WaSelect >> startElement [

	"An element, such as `<wa-icon>`, placed at the start of the combobox."

	^ self firstChildAtSlotNamed: #start
]

{ #category : #'accessing - slots' }
WaSelect >> startElement: anElement [

	"An element, such as `<wa-icon>`, placed at the start of the combobox."

	self replaceAllChildrenWith: anElement atSlotNamed: #start
]

{ #category : #accessing }
WaSelect >> validationTarget [

	"Where to anchor native constraint validation
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaSelect >> value [

	"The select's value. This will be a string for single select or an array for multi-select.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaSelect >> value: aString [

	"The select's value. This will be a string for single select or an array for multi-select.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaSelect >> withClear [

	"Adds a clear button when the select is not empty.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withClear
]

{ #category : #accessing }
WaSelect >> withClear: aBoolean [

	"Adds a clear button when the select is not empty.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withClear put: aBoolean
]

{ #category : #accessing }
WaSelect >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaSelect >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaSelect >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaSelect >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]
