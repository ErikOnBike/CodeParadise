Class {
	#name : #IonSelect,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSelect >> cancelText [

	"The text to display on the cancel button.
	
	Type: string"

	^ self propertyAt: #cancelText
]

{ #category : #api }
IonSelect >> cancelText: aString [

	"The text to display on the cancel button.
	
	Type: string"

	self propertyAt: #cancelText put: aString
]

{ #category : #api }
IonSelect >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).  This property is only available when using the modern select syntax.
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonSelect >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).  This property is only available when using the modern select syntax.
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonSelect >> compareWith [

	"This property allows developers to specify a custom function or property name for comparing objects when determining the selected option in the ion-select. When not specified, the default behavior will use strict equality (===) for comparison.
	
	Type: string | SelectCompareFn | null"

	^ self propertyAt: #compareWith
]

{ #category : #api }
IonSelect >> compareWith: anObject [

	"This property allows developers to specify a custom function or property name for comparing objects when determining the selected option in the ion-select. When not specified, the default behavior will use strict equality (===) for comparison.
	
	Type: string | SelectCompareFn | null"

	self propertyAt: #compareWith put: anObject
]

{ #category : #api }
IonSelect >> disabled [

	"If 'true', the user cannot interact with the select.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSelect >> disabled: aBoolean [

	"If 'true', the user cannot interact with the select.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSelect >> errorText [

	"Text that is placed under the select and displayed when an error is detected.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonSelect >> errorText: aString [

	"Text that is placed under the select and displayed when an error is detected.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonSelect >> expandedIcon [

	"The toggle icon to show when the select is open. If defined, the icon rotation behavior in 'md' mode will be disabled. If undefined, 'toggleIcon' will be used for when the select is both open and closed.
	
	Type: string"

	^ self propertyAt: #expandedIcon
]

{ #category : #api }
IonSelect >> expandedIcon: aString [

	"The toggle icon to show when the select is open. If defined, the icon rotation behavior in 'md' mode will be disabled. If undefined, 'toggleIcon' will be used for when the select is both open and closed.
	
	Type: string"

	self propertyAt: #expandedIcon put: aString
]

{ #category : #api }
IonSelect >> fill [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	^ self propertyAt: #fill
]

{ #category : #api }
IonSelect >> fill: aString [

	"The fill for the item. If ''solid'' the item will have a background. If ''outline'' the item will be transparent with a border. Only available in 'md' mode.
	
	Type: 'outline' | 'solid'"

	self propertyAt: #fill put: aString
]

{ #category : #api }
IonSelect >> helperText [

	"Text that is placed under the select and displayed when no error is detected.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonSelect >> helperText: aString [

	"Text that is placed under the select and displayed when no error is detected.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonSelect >> interface [

	"The interface the select should use: 'action-sheet', 'popover', 'alert', or 'modal'.
	
	Type: SelectInterface"

	^ self propertyAt: #interface
]

{ #category : #api }
IonSelect >> interface: anObject [

	"The interface the select should use: 'action-sheet', 'popover', 'alert', or 'modal'.
	
	Type: SelectInterface"

	self propertyAt: #interface put: anObject
]

{ #category : #api }
IonSelect >> interfaceOptions [

	"Any additional options that the 'alert', 'action-sheet' or 'popover' interface can take. See the [ion-alert docs](./alert), the [ion-action-sheet docs](./action-sheet), the [ion-popover docs](./popover), and the [ion-modal docs](./modal) for the create options for each interface.  Note: 'interfaceOptions' will not override 'inputs' or 'buttons' with the 'alert' interface.
	
	Type: any"

	^ self propertyAt: #interfaceOptions
]

{ #category : #api }
IonSelect >> interfaceOptions: anObject [

	"Any additional options that the 'alert', 'action-sheet' or 'popover' interface can take. See the [ion-alert docs](./alert), the [ion-action-sheet docs](./action-sheet), the [ion-popover docs](./popover), and the [ion-modal docs](./modal) for the create options for each interface.  Note: 'interfaceOptions' will not override 'inputs' or 'buttons' with the 'alert' interface.
	
	Type: any"

	self propertyAt: #interfaceOptions put: anObject
]

{ #category : #api }
IonSelect >> justify [

	"How to pack the label and select within a line. 'justify' does not apply when the label and select are on different lines when 'labelPlacement' is set to ''floating'' or ''stacked''. ''start'': The label and select will appear on the left in LTR and on the right in RTL. ''end'': The label and select will appear on the right in LTR and on the left in RTL. ''space-between'': The label and select will appear on opposite ends of the line with space between the two elements.
	
	Type: 'start' | 'end' | 'space-between'"

	^ self propertyAt: #justify
]

{ #category : #api }
IonSelect >> justify: aString [

	"How to pack the label and select within a line. 'justify' does not apply when the label and select are on different lines when 'labelPlacement' is set to ''floating'' or ''stacked''. ''start'': The label and select will appear on the left in LTR and on the right in RTL. ''end'': The label and select will appear on the right in LTR and on the left in RTL. ''space-between'': The label and select will appear on opposite ends of the line with space between the two elements.
	
	Type: 'start' | 'end' | 'space-between'"

	self propertyAt: #justify put: aString
]

{ #category : #api }
IonSelect >> label [

	"The visible label associated with the select.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	^ self propertyAt: #label
]

{ #category : #api }
IonSelect >> label: aString [

	"The visible label associated with the select.  Use this if you need to render a plaintext label.  The 'label' property will take priority over the 'label' slot if both are used.
	
	Type: string"

	self propertyAt: #label put: aString
]

{ #category : #api }
IonSelect >> labelPlacement [

	"Where to place the label relative to the select. ''start'': The label will appear to the left of the select in LTR and to the right in RTL. ''end'': The label will appear to the right of the select in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the select when the select is focused or it has a value. Otherwise it will appear on top of the select. ''stacked'': The label will appear smaller and above the select regardless even when the select is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). When using ''floating'' or ''stacked'' we recommend initializing the select with either a 'value' or a 'placeholder'.
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	^ self propertyAt: #labelPlacement
]

{ #category : #api }
IonSelect >> labelPlacement: aString [

	"Where to place the label relative to the select. ''start'': The label will appear to the left of the select in LTR and to the right in RTL. ''end'': The label will appear to the right of the select in LTR and to the left in RTL. ''floating'': The label will appear smaller and above the select when the select is focused or it has a value. Otherwise it will appear on top of the select. ''stacked'': The label will appear smaller and above the select regardless even when the select is blurred or has no value. ''fixed'': The label has the same behavior as ''start'' except it also has a fixed width. Long text will be truncated with ellipses ('...'). When using ''floating'' or ''stacked'' we recommend initializing the select with either a 'value' or a 'placeholder'.
	
	Type: 'start' | 'end' | 'floating' | 'stacked' | 'fixed'"

	self propertyAt: #labelPlacement put: aString
]

{ #category : #api }
IonSelect >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonSelect >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonSelect >> multiple [

	"If 'true', the select can accept multiple values.
	
	Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonSelect >> multiple: aBoolean [

	"If 'true', the select can accept multiple values.
	
	Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonSelect >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonSelect >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonSelect >> okText [

	"The text to display on the ok button.
	
	Type: string"

	^ self propertyAt: #okText
]

{ #category : #api }
IonSelect >> okText: aString [

	"The text to display on the ok button.
	
	Type: string"

	self propertyAt: #okText put: aString
]

{ #category : #api }
IonSelect >> open [

	"Open the select overlay. The overlay is either an alert, action sheet, or popover, depending on the 'interface' property on the 'ion-select'.
	@param event The user interface event that called the open.
	
	Type: (event?: UIEvent) => Promise<any>"

	^ self apply: #open resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSelect >> open: event [

	"Open the select overlay. The overlay is either an alert, action sheet, or popover, depending on the 'interface' property on the 'ion-select'.
	@param event The user interface event that called the open.
	
	Type: (event?: UIEvent) => Promise<any>"

	^ self apply: #open withArguments: { event } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSelect >> placeholder [

	"The text to display when the select is empty.
	
	Type: string"

	^ self propertyAt: #placeholder
]

{ #category : #api }
IonSelect >> placeholder: aString [

	"The text to display when the select is empty.
	
	Type: string"

	self propertyAt: #placeholder put: aString
]

{ #category : #api }
IonSelect >> required [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	^ self propertyAt: #required
]

{ #category : #api }
IonSelect >> required: aBoolean [

	"If true, screen readers will announce it as a required field. This property works only for accessibility purposes, it will not prevent the form from submitting if the value is invalid.
	
	Type: boolean"

	self propertyAt: #required put: aBoolean
]

{ #category : #api }
IonSelect >> selectedText [

	"The text to display instead of the selected option's value.
	
	Type: string | null"

	^ self propertyAt: #selectedText
]

{ #category : #api }
IonSelect >> selectedText: aString [

	"The text to display instead of the selected option's value.
	
	Type: string | null"

	self propertyAt: #selectedText put: aString
]

{ #category : #api }
IonSelect >> shape [

	"The shape of the select. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	^ self propertyAt: #shape
]

{ #category : #api }
IonSelect >> shape: aString [

	"The shape of the select. If 'round' it will have an increased border radius.
	
	Type: 'round'"

	self propertyAt: #shape put: aString
]

{ #category : #api }
IonSelect >> toggleIcon [

	"The toggle icon to use. Defaults to 'chevronExpand' for 'ios' mode, or 'caretDownSharp' for 'md' mode.
	
	Type: string"

	^ self propertyAt: #toggleIcon
]

{ #category : #api }
IonSelect >> toggleIcon: aString [

	"The toggle icon to use. Defaults to 'chevronExpand' for 'ios' mode, or 'caretDownSharp' for 'md' mode.
	
	Type: string"

	self propertyAt: #toggleIcon put: aString
]

{ #category : #api }
IonSelect >> value [

	"The value of the select.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonSelect >> value: anObject [

	"The value of the select.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
