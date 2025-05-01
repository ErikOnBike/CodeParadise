Class {
	#name : #IonToggle,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonToggle >> alignment [

	"How to control the alignment of the toggle and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the toggle 'display' to 'block'.
	
	Type: 'start' | 'center'"

	^ self propertyAt: #alignment
]

{ #category : #api }
IonToggle >> alignment: aString [

	"How to control the alignment of the toggle and label on the cross axis. ''start'': The label and control will appear on the left of the cross axis in LTR, and on the right side in RTL. ''center'': The label and control will appear at the center of the cross axis in both LTR and RTL. Setting this property will change the toggle 'display' to 'block'.
	
	Type: 'start' | 'center'"

	self propertyAt: #alignment put: aString
]

{ #category : #api }
IonToggle >> checked [

	"If 'true', the toggle is selected.
	
	Type: boolean"

	^ self propertyAt: #checked
]

{ #category : #api }
IonToggle >> checked: aBoolean [

	"If 'true', the toggle is selected.
	
	Type: boolean"

	self propertyAt: #checked put: aBoolean
]

{ #category : #api }
IonToggle >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonToggle >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonToggle >> disabled [

	"If 'true', the user cannot interact with the toggle.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonToggle >> disabled: aBoolean [

	"If 'true', the user cannot interact with the toggle.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonToggle >> enableOnOffLabels [

	"Enables the on/off accessibility switch labels within the toggle.
	
	Type: boolean | undefined"

	^ self propertyAt: #enableOnOffLabels
]

{ #category : #api }
IonToggle >> enableOnOffLabels: anObject [

	"Enables the on/off accessibility switch labels within the toggle.
	
	Type: boolean | undefined"

	self propertyAt: #enableOnOffLabels put: anObject
]

{ #category : #api }
IonToggle >> errorText [

	"Text that is placed under the toggle label and displayed when an error is detected.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonToggle >> errorText: aString [

	"Text that is placed under the toggle label and displayed when an error is detected.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonToggle >> helperText [

	"Text that is placed under the toggle label and displayed when no error is detected.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonToggle >> helperText: aString [

	"Text that is placed under the toggle label and displayed when no error is detected.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonToggle >> justify [

	"How to pack the label and toggle within a line. ''start'': The label and toggle will appear on the left in LTR and on the right in RTL. ''end'': The label and toggle will appear on the right in LTR and on the left in RTL. ''space-between'': The label and toggle will appear on opposite ends of the line with space between the two elements. Setting this property will change the toggle 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	^ self propertyAt: #justify
]

{ #category : #api }
IonToggle >> justify: aString [

	"How to pack the label and toggle within a line. ''start'': The label and toggle will appear on the left in LTR and on the right in RTL. ''end'': The label and toggle will appear on the right in LTR and on the left in RTL. ''space-between'': The label and toggle will appear on opposite ends of the line with space between the two elements. Setting this property will change the toggle 'display' to 'block'.
	
	Type: 'start' | 'end' | 'space-between'"

	self propertyAt: #justify put: aString
]

{ #category : #api }
IonToggle >> labelPlacement [

	"Where to place the label relative to the input. ''start'': The label will appear to the left of the toggle in LTR and to the right in RTL. ''end'': The label will appear to the right of the toggle in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the toggle regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonToggle >> labelPlacement: aString [

	"Where to place the label relative to the input. ''start'': The label will appear to the left of the toggle in LTR and to the right in RTL. ''end'': The label will appear to the right of the toggle in LTR and to the left in RTL. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). ''stacked'': The label will appear above the toggle regardless of the direction. The alignment of the label can be controlled with the 'alignment' property.
	
	Type: 'start' | 'end' | 'fixed' | 'stacked'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonToggle >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonToggle >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonToggle >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonToggle >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonToggle >> required [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	^ self propertyAt: #required
]

{ #category : #api }
IonToggle >> required: aBoolean [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	self propertyAt: #required put: aBoolean
]

{ #category : #api }
IonToggle >> value [

	"The value of the toggle does not mean if it's checked or not, use the 'checked' property for that.  The value of a toggle is analogous to the value of a '<input type='checkbox'>', it's only used when the toggle participates in a native '<form>'.
	
	Type: string | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonToggle >> value: aString [

	"The value of the toggle does not mean if it's checked or not, use the 'checked' property for that.  The value of a toggle is analogous to the value of a '<input type='checkbox'>', it's only used when the toggle participates in a native '<form>'.
	
	Type: string | null"

	self propertyAt: #value put: aString
]
