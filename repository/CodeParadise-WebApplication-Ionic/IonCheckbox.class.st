Class {
	#name : #IonCheckbox,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonCheckbox >> alignment [

	"How to control the alignment of the checkbox and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the checkbox 'display' to 'block'.
	
	Type: 'start' | 'center'"

	^ self propertyAt: #alignment
]

{ #category : #api }
IonCheckbox >> alignment: aString [

	"How to control the alignment of the checkbox and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the checkbox 'display' to 'block'.
	
	Type: 'start' | 'center'"

	self propertyAt: #alignment put: aString
]

{ #category : #api }
IonCheckbox >> checked [

	"If 'true', the checkbox is selected.
	
	Type: boolean"

	^ self propertyAt: #checked
]

{ #category : #api }
IonCheckbox >> checked: aBoolean [

	"If 'true', the checkbox is selected.
	
	Type: boolean"

	self propertyAt: #checked put: aBoolean
]

{ #category : #api }
IonCheckbox >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonCheckbox >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonCheckbox >> disabled [

	"If 'true', the user cannot interact with the checkbox.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonCheckbox >> disabled: aBoolean [

	"If 'true', the user cannot interact with the checkbox.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonCheckbox >> errorText [

	"Text that is placed under the checkbox label and displayed when an error is detected.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonCheckbox >> errorText: aString [

	"Text that is placed under the checkbox label and displayed when an error is detected.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonCheckbox >> helperText [

	"Text that is placed under the checkbox label and displayed when no error is detected.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonCheckbox >> helperText: aString [

	"Text that is placed under the checkbox label and displayed when no error is detected.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonCheckbox >> indeterminate [

	"If 'true', the checkbox will visually appear as indeterminate.
	
	Type: boolean"

	^ self propertyAt: #indeterminate
]

{ #category : #api }
IonCheckbox >> indeterminate: aBoolean [

	"If 'true', the checkbox will visually appear as indeterminate.
	
	Type: boolean"

	self propertyAt: #indeterminate put: aBoolean
]

{ #category : #api }
IonCheckbox >> justify [

	"How to pack the label and checkbox within a line. ''start'': The label and checkbox will appear on the left in LTR and on the right in RTL. ''end'': The label and checkbox will appear on the right in LTR and on the left in RTL. ''space-between'': The label and checkbox will appear on opposite ends of the line with space between the two elements. Setting this property will change the checkbox 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	^ self propertyAt: #justify
]

{ #category : #api }
IonCheckbox >> justify: aString [

	"How to pack the label and checkbox within a line. ''start'': The label and checkbox will appear on the left in LTR and on the right in RTL. ''end'': The label and checkbox will appear on the right in LTR and on the left in RTL. ''space-between'': The label and checkbox will appear on opposite ends of the line with space between the two elements. Setting this property will change the checkbox 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	self propertyAt: #justify put: aString
]

{ #category : #api }
IonCheckbox >> labelPlacement [

	"Where to place the label relative to the checkbox. ''start'': The label will appear to the left of the checkbox in LTR and to the right in RTL. ''end'': The label will appear to the right of the checkbox in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the checkbox regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonCheckbox >> labelPlacement: aString [

	"Where to place the label relative to the checkbox. ''start'': The label will appear to the left of the checkbox in LTR and to the right in RTL. ''end'': The label will appear to the right of the checkbox in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the checkbox regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonCheckbox >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonCheckbox >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonCheckbox >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonCheckbox >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonCheckbox >> required [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	^ self propertyAt: #required
]

{ #category : #api }
IonCheckbox >> required: aBoolean [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	self propertyAt: #required put: aBoolean
]

{ #category : #api }
IonCheckbox >> setFocus [

	"Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonCheckbox >> value [

	"The value of the checkbox does not mean if it's checked or not, use the 'checked' property for that.  The value of a checkbox is analogous to the value of an '<input type='checkbox'>', it's only used when the checkbox participates in a native '<form>'.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonCheckbox >> value: anObject [

	"The value of the checkbox does not mean if it's checked or not, use the 'checked' property for that.  The value of a checkbox is analogous to the value of an '<input type='checkbox'>', it's only used when the checkbox participates in a native '<form>'.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
