Class {
	#name : #IonRange,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRange >> activeBarStart [

	"The start position of the range active bar. This feature is only available with a single knob (dualKnobs='false'). Valid values are greater than or equal to the min value and less than or equal to the max value.
	
	Type: number"

	^ self propertyAt: #activeBarStart
]

{ #category : #api }
IonRange >> activeBarStart: aNumber [

	"The start position of the range active bar. This feature is only available with a single knob (dualKnobs='false'). Valid values are greater than or equal to the min value and less than or equal to the max value.
	
	Type: number"

	self propertyAt: #activeBarStart put: aNumber
]

{ #category : #api }
IonRange >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonRange >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonRange >> debounce [

	"How long, in milliseconds, to wait to trigger the 'ionInput' event after each change in the range value.
	
	Type: number"

	^ self propertyAt: #debounce
]

{ #category : #api }
IonRange >> debounce: aNumber [

	"How long, in milliseconds, to wait to trigger the 'ionInput' event after each change in the range value.
	
	Type: number"

	self propertyAt: #debounce put: aNumber
]

{ #category : #api }
IonRange >> disabled [

	"If 'true', the user cannot interact with the range.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonRange >> disabled: aBoolean [

	"If 'true', the user cannot interact with the range.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonRange >> dualKnobs [

	"Show two knobs.
	
	Type: boolean"

	^ self propertyAt: #dualKnobs
]

{ #category : #api }
IonRange >> dualKnobs: aBoolean [

	"Show two knobs.
	
	Type: boolean"

	self propertyAt: #dualKnobs put: aBoolean
]

{ #category : #api }
IonRange >> label [

	"The text to display as the control's label. Use this over the 'label' slot if you only need plain text. The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	^ self propertyAt: #label
]

{ #category : #api }
IonRange >> label: aString [

	"The text to display as the control's label. Use this over the 'label' slot if you only need plain text. The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	self propertyAt: #label put: aString
]

{ #category : #api }
IonRange >> labelPlacement [

	"Where to place the label relative to the range. ''start'': The label will appear to the left of the range in LTR and to the right in RTL. ''end'': The label will appear to the right of the range in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the range regardless of the direction.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonRange >> labelPlacement: aString [

	"Where to place the label relative to the range. ''start'': The label will appear to the left of the range in LTR and to the right in RTL. ''end'': The label will appear to the right of the range in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the range regardless of the direction.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonRange >> max [

	"Maximum integer value of the range.
	
	Type: number"

	^ self propertyAt: #max
]

{ #category : #api }
IonRange >> max: aNumber [

	"Maximum integer value of the range.
	
	Type: number"

	self propertyAt: #max put: aNumber
]

{ #category : #api }
IonRange >> min [

	"Minimum integer value of the range.
	
	Type: number"

	^ self propertyAt: #min
]

{ #category : #api }
IonRange >> min: aNumber [

	"Minimum integer value of the range.
	
	Type: number"

	self propertyAt: #min put: aNumber
]

{ #category : #api }
IonRange >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonRange >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonRange >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonRange >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonRange >> pin [

	"If 'true', a pin with integer value is shown when the knob is pressed.
	
	Type: boolean"

	^ self propertyAt: #pin
]

{ #category : #api }
IonRange >> pin: aBoolean [

	"If 'true', a pin with integer value is shown when the knob is pressed.
	
	Type: boolean"

	self propertyAt: #pin put: aBoolean
]

{ #category : #api }
IonRange >> pinFormatter [

	"A callback used to format the pin text. By default the pin text is set to 'Math.round(value)'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: PinFormatter"

	^ self propertyAt: #pinFormatter
]

{ #category : #api }
IonRange >> pinFormatter: aBlock [

	"A callback used to format the pin text. By default the pin text is set to 'Math.round(value)'.  See https://ionicframework.com/docs/troubleshooting/runtime#accessing-this if you need to access 'this' from within the callback.
	
	Type: PinFormatter"

	self propertyAt: #pinFormatter put: aBlock asJavaScriptFunction
]

{ #category : #api }
IonRange >> snaps [

	"If 'true', the knob snaps to tick marks evenly spaced based on the step property value.
	
	Type: boolean"

	^ self propertyAt: #snaps
]

{ #category : #api }
IonRange >> snaps: aBoolean [

	"If 'true', the knob snaps to tick marks evenly spaced based on the step property value.
	
	Type: boolean"

	self propertyAt: #snaps put: aBoolean
]

{ #category : #api }
IonRange >> step [

	"Specifies the value granularity.
	
	Type: number"

	^ self propertyAt: #step
]

{ #category : #api }
IonRange >> step: aNumber [

	"Specifies the value granularity.
	
	Type: number"

	self propertyAt: #step put: aNumber
]

{ #category : #api }
IonRange >> ticks [

	"If 'true', tick marks are displayed based on the step value. Only applies when 'snaps' is 'true'.
	
	Type: boolean"

	^ self propertyAt: #ticks
]

{ #category : #api }
IonRange >> ticks: aBoolean [

	"If 'true', tick marks are displayed based on the step value. Only applies when 'snaps' is 'true'.
	
	Type: boolean"

	self propertyAt: #ticks put: aBoolean
]

{ #category : #api }
IonRange >> value [

	"the value of the range.
	
	Type: RangeValue"

	^ self propertyAt: #value
]

{ #category : #api }
IonRange >> value: anObject [

	"the value of the range.
	
	Type: RangeValue"

	self propertyAt: #value put: anObject
]
