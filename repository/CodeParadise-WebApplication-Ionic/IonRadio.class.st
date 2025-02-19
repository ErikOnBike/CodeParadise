Class {
	#name : #IonRadio,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRadio >> alignment [

	"How to control the alignment of the radio and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the radio 'display' to 'block'.
	
	Type: 'start' | 'center'"

	^ self propertyAt: #alignment
]

{ #category : #api }
IonRadio >> alignment: aString [

	"How to control the alignment of the radio and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the radio 'display' to 'block'.
	
	Type: 'start' | 'center'"

	self propertyAt: #alignment put: aString
]

{ #category : #api }
IonRadio >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonRadio >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonRadio >> disabled [

	"If 'true', the user cannot interact with the radio.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonRadio >> disabled: aBoolean [

	"If 'true', the user cannot interact with the radio.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonRadio >> justify [

	"How to pack the label and radio within a line. ''start'': The label and radio will appear on the left in LTR and on the right in RTL. ''end'': The label and radio will appear on the right in LTR and on the left in RTL. ''space-between'': The label and radio will appear on opposite ends of the line with space between the two elements. Setting this property will change the radio 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	^ self propertyAt: #justify
]

{ #category : #api }
IonRadio >> justify: aString [

	"How to pack the label and radio within a line. ''start'': The label and radio will appear on the left in LTR and on the right in RTL. ''end'': The label and radio will appear on the right in LTR and on the left in RTL. ''space-between'': The label and radio will appear on opposite ends of the line with space between the two elements. Setting this property will change the radio 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	self propertyAt: #justify put: aString
]

{ #category : #api }
IonRadio >> labelPlacement [

	"Where to place the label relative to the radio. ''start'': The label will appear to the left of the radio in LTR and to the right in RTL. ''end'': The label will appear to the right of the radio in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the radio regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonRadio >> labelPlacement: aString [

	"Where to place the label relative to the radio. ''start'': The label will appear to the left of the radio in LTR and to the right in RTL. ''end'': The label will appear to the right of the radio in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the radio regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonRadio >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonRadio >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonRadio >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonRadio >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonRadio >> setButtonTabindex: value [

	"Type: (value: number) => Promise<void>"

	^ self apply: #setButtonTabindex withArguments: { value } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRadio >> setFocus [

	"Type: (ev?: globalThis.Event) => Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRadio >> setFocus: ev [

	"Type: (ev?: globalThis.Event) => Promise<void>"

	^ self apply: #setFocus withArguments: { ev } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRadio >> value [

	"the value of the radio.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonRadio >> value: anObject [

	"the value of the radio.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
