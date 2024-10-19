Class {
	#name : #IonPickerColumn,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonPickerColumn >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonPickerColumn >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonPickerColumn >> disabled [

	"If 'true', the user cannot interact with the picker.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonPickerColumn >> disabled: aBoolean [

	"If 'true', the user cannot interact with the picker.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonPickerColumn >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonPickerColumn >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonPickerColumn >> numericInput [

	"If 'true', tapping the picker will reveal a number input keyboard that lets the user type in values for each picker column. This is useful when working with time pickers.
	
	Type: boolean"

	^ self propertyAt: #numericInput
]

{ #category : #api }
IonPickerColumn >> numericInput: aBoolean [

	"If 'true', tapping the picker will reveal a number input keyboard that lets the user type in values for each picker column. This is useful when working with time pickers.
	
	Type: boolean"

	self propertyAt: #numericInput put: aBoolean
]

{ #category : #api }
IonPickerColumn >> scrollActiveItemIntoView [

	"Type: (smooth?: boolean) => Promise<void>"

	^ self apply: #scrollActiveItemIntoView resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPickerColumn >> scrollActiveItemIntoView: smooth [

	"Type: (smooth?: boolean) => Promise<void>"

	^ self apply: #scrollActiveItemIntoView withArguments: { smooth } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPickerColumn >> setFocus [

	"Sets focus on the scrollable container within the picker column. Use this method instead of the global 'pickerColumn.focus()'.
	
	Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPickerColumn >> setValue: value [

	"Sets the value prop and fires the ionChange event. This is used when we need to fire ionChange from user-generated events that cannot be caught with normal input/change event listeners.
	
	Type: (value: PickerColumnValue) => Promise<void>"

	^ self apply: #setValue withArguments: { value } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonPickerColumn >> value [

	"The selected option in the picker.
	
	Type: string | number"

	^ self propertyAt: #value
]

{ #category : #api }
IonPickerColumn >> value: anObject [

	"The selected option in the picker.
	
	Type: string | number"

	self propertyAt: #value put: anObject
]
