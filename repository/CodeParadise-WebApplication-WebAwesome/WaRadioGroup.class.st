Class {
	#name : #WaRadioGroup,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaRadioGroup >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
WaRadioGroup >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #accessing }
WaRadioGroup >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaRadioGroup >> defaultValue: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaRadioGroup >> disabled [

	"Disables the radio group and all child radios.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaRadioGroup >> disabled: aBoolean [

	"Disables the radio group and all child radios.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaRadioGroup >> focus [

	"Sets focus on the radio group."

	^ self apply: #focus
]

{ #category : #actions }
WaRadioGroup >> focus: anObject [

	"Sets focus on the radio group.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaRadioGroup >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaRadioGroup >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaRadioGroup >> hint [

	"The radio groups's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaRadioGroup >> hint: aString [

	"The radio groups's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaRadioGroup >> label [

	"The radio group's label. Required for proper accessibility. If you need to display HTML, use the `label` slot
	instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaRadioGroup >> label: aString [

	"The radio group's label. Required for proper accessibility. If you need to display HTML, use the `label` slot
	instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaRadioGroup >> name [

	"The name of the radio group, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaRadioGroup >> name: aString [

	"The name of the radio group, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaRadioGroup >> orientation [

	"The orientation in which to show radio items.
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaRadioGroup >> orientation: aString [

	"The orientation in which to show radio items.
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaRadioGroup >> required [

	"Ensures a child radio is checked before allowing the containing form to submit.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaRadioGroup >> required: aBoolean [

	"Ensures a child radio is checked before allowing the containing form to submit.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaRadioGroup >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaRadioGroup >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaRadioGroup >> size [

	"The radio group's size. When present, this size will be applied to all `<wa-radio>` items inside.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaRadioGroup >> size: aString [

	"The radio group's size. When present, this size will be applied to all `<wa-radio>` items inside.
	
	Type: String
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaRadioGroup >> validationTarget [

	"We use the first available radio as the validationTarget similar to native HTML that shows the validation popup on
	the first radio element.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaRadioGroup >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaRadioGroup >> value: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaRadioGroup >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaRadioGroup >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaRadioGroup >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaRadioGroup >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]
