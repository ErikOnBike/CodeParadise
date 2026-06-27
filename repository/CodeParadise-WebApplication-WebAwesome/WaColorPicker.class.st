Class {
	#name : #WaColorPicker,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaColorPicker >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beNotOpacity [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self opacity: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beNotRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beNotUppercase [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self uppercase: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beOpacity [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self opacity: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beRequired [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self required: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beUppercase [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self uppercase: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithFormatToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutFormatToggle: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithoutFormatToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutFormatToggle: true
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #'accessing - convenience' }
WaColorPicker >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #actions }
WaColorPicker >> blur [

	"Removes focus from the color picker."

	^ self apply: #blur
]

{ #category : #accessing }
WaColorPicker >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaColorPicker >> defaultValue: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #defaultValue put: aString
]

{ #category : #accessing }
WaColorPicker >> disabled [

	"Disables the color picker.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaColorPicker >> disabled: aBoolean [

	"Disables the color picker.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaColorPicker >> focus [

	"Sets focus on the color picker."

	^ self apply: #focus
]

{ #category : #actions }
WaColorPicker >> focus: anObject [

	"Sets focus on the color picker.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaColorPicker >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaColorPicker >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaColorPicker >> format [

	"The format to use. If opacity is enabled, these will translate to HEXA, RGBA, HSLA, and HSVA respectively. The color
	picker will accept user input in any format (including CSS color names) and convert it to the desired format.
	
	Type: String
	Default: 'hex'
	Allowed: 'hex' | 'rgb' | 'hsl' | 'hsv'"

	^ self propertyAt: #format
]

{ #category : #accessing }
WaColorPicker >> format: aString [

	"The format to use. If opacity is enabled, these will translate to HEXA, RGBA, HSLA, and HSVA respectively. The color
	picker will accept user input in any format (including CSS color names) and convert it to the desired format.
	
	Type: String
	Default: 'hex'
	Allowed: 'hex' | 'rgb' | 'hsl' | 'hsv'"

	self propertyAt: #format put: aString
]

{ #category : #actions }
WaColorPicker >> getFormattedValue [

	"Returns the current value as a string in the specified format."

	^ self apply: #getFormattedValue
]

{ #category : #actions }
WaColorPicker >> getFormattedValue: aString [

	"Returns the current value as a string in the specified format.
	
	Parameter: format (string)"

	^ self apply: #getFormattedValue withArguments: { aString }
]

{ #category : #actions }
WaColorPicker >> getHexStringHue: hueNumber saturation: saturationNumber brightness: aNumber [

	"Generates a hex string from HSV values. Hue must be 0-360. All other arguments must be 0-100.
	
	Parameter: hue (number)
	Parameter: saturation (number)
	Parameter: brightness (number)"

	^ self apply: #getHexString withArguments: { hueNumber . saturationNumber . aNumber }
]

{ #category : #actions }
WaColorPicker >> getHexStringHue: hueNumber saturation: saturationNumber brightness: brightnessNumber alpha: alphaNumber [

	"Generates a hex string from HSV values. Hue must be 0-360. All other arguments must be 0-100.
	
	Parameter: hue (number)
	Parameter: saturation (number)
	Parameter: brightness (number)
	Parameter: alpha (number)"

	^ self apply: #getHexString withArguments: { hueNumber . saturationNumber . brightnessNumber . alphaNumber }
]

{ #category : #actions }
WaColorPicker >> hide [

	"Hides the color picker panel"

	^ self apply: #hide
]

{ #category : #accessing }
WaColorPicker >> hint [

	"The color picker's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaColorPicker >> hint: aString [

	"The color picker's hint. If you need to display HTML, use the `hint` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #'accessing - slots' }
WaColorPicker >> hintElement [

	"The color picker's form hint. Alternatively, you can use the `hint` attribute."

	^ self firstChildAtSlotNamed: #hint
]

{ #category : #'accessing - slots' }
WaColorPicker >> hintElement: anElement [

	"The color picker's form hint. Alternatively, you can use the `hint` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #hint
]

{ #category : #accessing }
WaColorPicker >> label [

	"The color picker's label. This will not be displayed, but it will be announced by assistive devices. If you need to
	display HTML, you can use the `label` slot` instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaColorPicker >> label: aString [

	"The color picker's label. This will not be displayed, but it will be announced by assistive devices. If you need to
	display HTML, you can use the `label` slot` instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaColorPicker >> labelElement [

	"The color picker's form label. Alternatively, you can use the `label` attribute."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #'accessing - slots' }
WaColorPicker >> labelElement: anElement [

	"The color picker's form label. Alternatively, you can use the `label` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #label
]

{ #category : #accessing }
WaColorPicker >> name [

	"The name of the form control, submitted as a name/value pair with form data.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaColorPicker >> name: aString [

	"The name of the form control, submitted as a name/value pair with form data.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaColorPicker >> opacity [

	"Shows the opacity slider. Enabling this will cause the formatted value to be HEXA, RGBA, or HSLA.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #opacity
]

{ #category : #accessing }
WaColorPicker >> opacity: aBoolean [

	"Shows the opacity slider. Enabling this will cause the formatted value to be HEXA, RGBA, or HSLA.
	
	Type: Boolean
	Default: false"

	self propertyAt: #opacity put: aBoolean
]

{ #category : #accessing }
WaColorPicker >> open [

	"Indicates whether or not the popup is open. You can toggle this attribute to show and hide the popup, or you
	can use the `show()` and `hide()` methods and this attribute will reflect the popup's open state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaColorPicker >> open: aBoolean [

	"Indicates whether or not the popup is open. You can toggle this attribute to show and hide the popup, or you
	can use the `show()` and `hide()` methods and this attribute will reflect the popup's open state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaColorPicker >> placement [

	"The preferred placement of the color picker's popup. Note that the actual placement will vary as configured to
	keep the panel inside of the viewport.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaColorPicker >> placement: aString [

	"The preferred placement of the color picker's popup. Note that the actual placement will vary as configured to
	keep the panel inside of the viewport.
	
	Type: String
	Default: 'bottom-start'
	Allowed: 'top' | 'top-start' | 'top-end' | 'bottom' | 'bottom-start' | 'bottom-end' | 'right' | 'right-start' | 'right-end' | 'left' | 'left-start' | 'left-end'"

	self propertyAt: #placement put: aString
]

{ #category : #actions }
WaColorPicker >> reportValidity [

	"Checks for validity and shows the browser's validation message if the control is invalid."

	^ self apply: #reportValidity
]

{ #category : #accessing }
WaColorPicker >> required [

	"Makes the color picker a required field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #required
]

{ #category : #accessing }
WaColorPicker >> required: aBoolean [

	"Makes the color picker a required field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #required put: aBoolean
]

{ #category : #actions }
WaColorPicker >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaColorPicker >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #actions }
WaColorPicker >> show [

	"Shows the color picker panel."

	^ self apply: #show
]

{ #category : #accessing }
WaColorPicker >> size [

	"Determines the size of the color picker's trigger
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaColorPicker >> size: aString [

	"Determines the size of the color picker's trigger
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaColorPicker >> swatches [

	"One or more predefined color swatches to display as presets in the color picker. Can include any format the color
	picker can parse, including HEX(A), RGB(A), HSL(A), HSV(A), and CSS color names. Each color must be separated by a
	semicolon (`;`). Alternatively, you can pass an array of color values or an array of `{ color, label }` objects to
	this property using JavaScript. When using objects with labels, the label will be used for the swatch's accessible
	name instead of the raw color value.
	
	Type: String (string | string[] | WaColorPickerSwatch[])
	Default: ''"

	^ self propertyAt: #swatches
]

{ #category : #accessing }
WaColorPicker >> swatches: aString [

	"One or more predefined color swatches to display as presets in the color picker. Can include any format the color
	picker can parse, including HEX(A), RGB(A), HSL(A), HSV(A), and CSS color names. Each color must be separated by a
	semicolon (`;`). Alternatively, you can pass an array of color values or an array of `{ color, label }` objects to
	this property using JavaScript. When using objects with labels, the label will be used for the swatch's accessible
	name instead of the raw color value.
	
	Type: String (string | string[] | WaColorPickerSwatch[])
	Default: ''"

	self propertyAt: #swatches put: aString
]

{ #category : #accessing }
WaColorPicker >> uppercase [

	"By default, values are lowercase. With this attribute, values will be uppercase instead.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #uppercase
]

{ #category : #accessing }
WaColorPicker >> uppercase: aBoolean [

	"By default, values are lowercase. With this attribute, values will be uppercase instead.
	
	Type: Boolean
	Default: false"

	self propertyAt: #uppercase put: aBoolean
]

{ #category : #accessing }
WaColorPicker >> validationTarget [

	"Override this to change where constraint validation popups are anchored.
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaColorPicker >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaColorPicker >> value: aString [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaColorPicker >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaColorPicker >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaColorPicker >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaColorPicker >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]

{ #category : #accessing }
WaColorPicker >> withoutFormatToggle [

	"Removes the button that lets users toggle between format.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutFormatToggle
]

{ #category : #accessing }
WaColorPicker >> withoutFormatToggle: aBoolean [

	"Removes the button that lets users toggle between format.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutFormatToggle put: aBoolean
]
