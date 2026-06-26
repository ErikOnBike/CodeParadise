Class {
	#name : #WaSlider,
	#superclass : #WaFormControl,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaSlider >> autofocus [

	"Tells the browser to focus the slider when the page loads or a dialog is shown.
	
	Type: Boolean"

	^ self propertyAt: #autofocus
]

{ #category : #accessing }
WaSlider >> autofocus: aBoolean [

	"Tells the browser to focus the slider when the page loads or a dialog is shown.
	
	Type: Boolean"

	self propertyAt: #autofocus put: aBoolean
]

{ #category : #convenience }
WaSlider >> beAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: true
]

{ #category : #convenience }
WaSlider >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaSlider >> beIsRange [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self isRange: true
]

{ #category : #convenience }
WaSlider >> beLarge [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #large
]

{ #category : #convenience }
WaSlider >> beMedium [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #medium
]

{ #category : #convenience }
WaSlider >> beNotAutofocus [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autofocus: false
]

{ #category : #convenience }
WaSlider >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaSlider >> beNotIsRange [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self isRange: false
]

{ #category : #convenience }
WaSlider >> beNotRange [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self range: false
]

{ #category : #convenience }
WaSlider >> beNotReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: false
]

{ #category : #convenience }
WaSlider >> beRange [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self range: true
]

{ #category : #convenience }
WaSlider >> beReadonly [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self readonly: true
]

{ #category : #convenience }
WaSlider >> beSizeL [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #l
]

{ #category : #convenience }
WaSlider >> beSizeM [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #m
]

{ #category : #convenience }
WaSlider >> beSizeS [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #s
]

{ #category : #convenience }
WaSlider >> beSizeXl [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xl
]

{ #category : #convenience }
WaSlider >> beSizeXs [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #xs
]

{ #category : #convenience }
WaSlider >> beSmall [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self size: #small
]

{ #category : #convenience }
WaSlider >> beWithHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: true
]

{ #category : #convenience }
WaSlider >> beWithLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: true
]

{ #category : #convenience }
WaSlider >> beWithMarkers [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMarkers: true
]

{ #category : #convenience }
WaSlider >> beWithTooltip [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withTooltip: true
]

{ #category : #convenience }
WaSlider >> beWithoutHint [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHint: false
]

{ #category : #convenience }
WaSlider >> beWithoutLabel [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withLabel: false
]

{ #category : #convenience }
WaSlider >> beWithoutMarkers [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMarkers: false
]

{ #category : #convenience }
WaSlider >> beWithoutTooltip [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withTooltip: false
]

{ #category : #actions }
WaSlider >> blur [

	"Removes focus from the slider."

	^ self apply: #blur
]

{ #category : #accessing }
WaSlider >> defaultValue [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Number"

	^ self propertyAt: #defaultValue
]

{ #category : #accessing }
WaSlider >> defaultValue: aNumber [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Number"

	self propertyAt: #defaultValue put: aNumber
]

{ #category : #accessing }
WaSlider >> disabled [

	"Disables the slider.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaSlider >> disabled: aBoolean [

	"Disables the slider.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaSlider >> focus [

	"Sets focus to the slider."

	^ self apply: #focus
]

{ #category : #accessing }
WaSlider >> form [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	^ self propertyAt: #form
]

{ #category : #accessing }
WaSlider >> form: anHtmlElement [

	"By default, form controls are associated with the nearest containing `<form>` element. This attribute allows you
	to place the form control outside of a form and associate it with the form that has this `id`. The form must be in
	the same document or shadow root for this to work.
	
	Type: HtmlElement (HTMLFormElement | null)"

	self propertyAt: #form put: anHtmlElement
]

{ #category : #accessing }
WaSlider >> hint [

	"The slider hint. If you need to display HTML, use the hint slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #hint
]

{ #category : #accessing }
WaSlider >> hint: aString [

	"The slider hint. If you need to display HTML, use the hint slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #hint put: aString
]

{ #category : #accessing }
WaSlider >> indicatorOffset [

	"The starting value from which to draw the slider's fill, which is based on its current value.
	
	Type: Number"

	^ self propertyAt: #indicatorOffset
]

{ #category : #accessing }
WaSlider >> indicatorOffset: aNumber [

	"The starting value from which to draw the slider's fill, which is based on its current value.
	
	Type: Number"

	self propertyAt: #indicatorOffset put: aNumber
]

{ #category : #accessing }
WaSlider >> isRange [

	"Get if this is a range slider
	
	Type: Boolean
	Read-only: true"

	^ self propertyAt: #isRange
]

{ #category : #accessing }
WaSlider >> label [

	"The slider's label. If you need to provide HTML in the label, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaSlider >> label: aString [

	"The slider's label. If you need to provide HTML in the label, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaSlider >> max [

	"The maximum value allowed.
	
	Type: Number
	Default: 100"

	^ self propertyAt: #max
]

{ #category : #accessing }
WaSlider >> max: aNumber [

	"The maximum value allowed.
	
	Type: Number
	Default: 100"

	self propertyAt: #max put: aNumber
]

{ #category : #accessing }
WaSlider >> maxValue [

	"The maximum value of a range selection. Used only when range attribute is set.
	
	Type: Number
	Default: 50"

	^ self propertyAt: #maxValue
]

{ #category : #accessing }
WaSlider >> maxValue: aNumber [

	"The maximum value of a range selection. Used only when range attribute is set.
	
	Type: Number
	Default: 50"

	self propertyAt: #maxValue put: aNumber
]

{ #category : #accessing }
WaSlider >> min [

	"The minimum value allowed.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #min
]

{ #category : #accessing }
WaSlider >> min: aNumber [

	"The minimum value allowed.
	
	Type: Number
	Default: 0"

	self propertyAt: #min put: aNumber
]

{ #category : #accessing }
WaSlider >> minValue [

	"The minimum value of a range selection. Used only when range attribute is set.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #minValue
]

{ #category : #accessing }
WaSlider >> minValue: aNumber [

	"The minimum value of a range selection. Used only when range attribute is set.
	
	Type: Number
	Default: 0"

	self propertyAt: #minValue put: aNumber
]

{ #category : #accessing }
WaSlider >> name [

	"The name of the slider. This will be submitted with the form as a name/value pair.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaSlider >> name: aString [

	"The name of the slider. This will be submitted with the form as a name/value pair.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaSlider >> orientation [

	"The orientation of the slider.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaSlider >> orientation: aString [

	"The orientation of the slider.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaSlider >> range [

	"Converts the slider to a range slider with two thumbs.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #range
]

{ #category : #accessing }
WaSlider >> range: aBoolean [

	"Converts the slider to a range slider with two thumbs.
	
	Type: Boolean
	Default: false"

	self propertyAt: #range put: aBoolean
]

{ #category : #accessing }
WaSlider >> readonly [

	"Makes the slider a read-only field.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #readonly
]

{ #category : #accessing }
WaSlider >> readonly: aBoolean [

	"Makes the slider a read-only field.
	
	Type: Boolean
	Default: false"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #actions }
WaSlider >> resetValidity [

	"Reset validity is a way of removing manual custom errors and native validation."

	^ self apply: #resetValidity
]

{ #category : #actions }
WaSlider >> setCustomValidity: aString [

	"Do not use this when creating a ""Validator"". This is intended for end users of components.
	We track manually defined custom errors so we don't clear them on accident in our validators.
	
	Parameter: message (string)"

	^ self apply: #setCustomValidity withArguments: { aString }
]

{ #category : #accessing }
WaSlider >> size [

	"The slider's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	^ self propertyAt: #size
]

{ #category : #accessing }
WaSlider >> size: aString [

	"The slider's size.
	
	Type: String
	Default: 'm'
	Allowed: 'xs' | 's' | 'm' | 'l' | 'xl' | 'small' | 'medium' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #accessing }
WaSlider >> step [

	"The granularity the value must adhere to when incrementing and decrementing.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #step
]

{ #category : #accessing }
WaSlider >> step: aNumber [

	"The granularity the value must adhere to when incrementing and decrementing.
	
	Type: Number
	Default: 1"

	self propertyAt: #step put: aNumber
]

{ #category : #actions }
WaSlider >> stepDown [

	"Decreases the slider's value by `step`. This is a programmatic change, so `input` and `change` events will not be
	emitted when this is called."

	^ self apply: #stepDown
]

{ #category : #actions }
WaSlider >> stepUp [

	"Increases the slider's value by `step`. This is a programmatic change, so `input` and `change` events will not be
	emitted when this is called."

	^ self apply: #stepUp
]

{ #category : #accessing }
WaSlider >> tooltipDistance [

	"The distance of the tooltip from the slider's thumb.
	
	Type: Number
	Default: 8"

	^ self propertyAt: #tooltipDistance
]

{ #category : #accessing }
WaSlider >> tooltipDistance: aNumber [

	"The distance of the tooltip from the slider's thumb.
	
	Type: Number
	Default: 8"

	self propertyAt: #tooltipDistance put: aNumber
]

{ #category : #accessing }
WaSlider >> tooltipPlacement [

	"The placement of the tooltip in reference to the slider's thumb.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'right' | 'bottom' | 'left'"

	^ self propertyAt: #tooltipPlacement
]

{ #category : #accessing }
WaSlider >> tooltipPlacement: aString [

	"The placement of the tooltip in reference to the slider's thumb.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'right' | 'bottom' | 'left'"

	self propertyAt: #tooltipPlacement put: aString
]

{ #category : #accessing }
WaSlider >> validationTarget [

	"Override validation target to point to the focusable element
	
	Type: HtmlElement
	Read-only: true"

	^ self propertyAt: #validationTarget
]

{ #category : #accessing }
WaSlider >> value [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Number"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaSlider >> value: aNumber [

	"The default value of the form control. Primarily used for resetting the form control.
	
	Type: Number"

	self propertyAt: #value put: aNumber
]

{ #category : #accessing }
WaSlider >> valueFormatter [

	"A custom formatting function to apply to the value. This will be shown in the tooltip and announced by screen
	readers. Must be set with JavaScript. Property only.
	
	Type: Block ((value: number) => string)"

	^ (self propertyAt: #valueFormatter) ifNotNil: [ :function | function asBlock ifNil: [ function ] ]
]

{ #category : #accessing }
WaSlider >> valueFormatter: aBlock [

	"A custom formatting function to apply to the value. This will be shown in the tooltip and announced by screen
	readers. Must be set with JavaScript. Property only.
	
	Type: Block ((value: number) => string)"

	self propertyAt: #valueFormatter put: aBlock asJavaScriptFunction
]

{ #category : #accessing }
WaSlider >> withHint [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHint
]

{ #category : #accessing }
WaSlider >> withHint: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `hint` element so the server-rendered markup
	includes the hint before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHint put: aBoolean
]

{ #category : #accessing }
WaSlider >> withLabel [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withLabel
]

{ #category : #accessing }
WaSlider >> withLabel: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `label` element so the server-rendered markup
	includes the label before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withLabel put: aBoolean
]

{ #category : #accessing }
WaSlider >> withMarkers [

	"Draws markers at each step along the slider.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withMarkers
]

{ #category : #accessing }
WaSlider >> withMarkers: aBoolean [

	"Draws markers at each step along the slider.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withMarkers put: aBoolean
]

{ #category : #accessing }
WaSlider >> withTooltip [

	"Draws a tooltip above the thumb when the control has focus or is dragged.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withTooltip
]

{ #category : #accessing }
WaSlider >> withTooltip: aBoolean [

	"Draws a tooltip above the thumb when the control has focus or is dragged.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withTooltip put: aBoolean
]
