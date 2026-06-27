Class {
	#name : #WaSwitch,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaSwitch >> beChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: true
]

{ #category : #'accessing - convenience' }
WaSwitch >> beDefaultChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultChecked: true
]

{ #category : #'accessing - convenience' }
WaSwitch >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaSwitch >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaSwitch >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaSwitch >> beNotChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: false
]

{ #category : #'accessing - convenience' }
WaSwitch >> beNotDefaultChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self defaultChecked: false
]

{ #category : #'accessing - convenience' }
WaSwitch >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaSwitch >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaSwitch >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaSwitch >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaSwitch >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaSwitch >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #actions }
WaSwitch >> blur [

	"Removes focus from the switch."

	^ self apply: #blur
]

{ #category : #accessing }
WaSwitch >> checked [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	^ self propertyAt: #checked
]

{ #category : #accessing }
WaSwitch >> checked: aBoolean [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
WaSwitch >> click [

	"Simulates a click on the switch."

	^ self apply: #click
]

{ #category : #accessing }
WaSwitch >> defaultChecked [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	^ self propertyAt: #defaultChecked
]

{ #category : #accessing }
WaSwitch >> defaultChecked: aBoolean [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Boolean"

	self propertyAt: #defaultChecked put: aBoolean
]

{ #category : #accessing }
WaSwitch >> disabled [

	"Disables the switch.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaSwitch >> disabled: aBoolean [

	"Disables the switch.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaSwitch >> focus [

	"Sets focus on the switch."

	^ self apply: #focus
]

{ #category : #actions }
WaSwitch >> focus: anObject [

	"Sets focus on the switch.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaSwitch >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaSwitch >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaSwitch >> hint [

	"The switch's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaSwitch >> hint: aString [

	"The switch's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #'accessing - slots' }
WaSwitch >> hintElement [

	"Text that describes how to use the switch. Alternatively, you can use the `hint` attribute."

	^ self firstChildAtSlotNamed: #hint
]

{ #category : #'accessing - slots' }
WaSwitch >> hintElement: anElement [

	"Text that describes how to use the switch. Alternatively, you can use the `hint` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #hint
]

{ #category : #accessing }
WaSwitch >> name [

	"The name of the switch, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaSwitch >> name: aString [

	"The name of the switch, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaSwitch >> required [

	"Makes the switch a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaSwitch >> required: aBoolean [

	"Makes the switch a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaSwitch >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaSwitch >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaSwitch >> size [

	"The switch's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaSwitch >> size: aString [

	"The switch's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaSwitch >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaSwitch >> value [

	"The value of the switch, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaSwitch >> value: aString [

	"The value of the switch, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaSwitch >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaSwitch >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]
