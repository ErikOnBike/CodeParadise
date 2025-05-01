Class {
	#name : #IonRadioGroup,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRadioGroup >> allowEmptySelection [

	"If 'true', the radios can be deselected.
	
	Type: boolean"

	^ self propertyAt: #allowEmptySelection
]

{ #category : #api }
IonRadioGroup >> allowEmptySelection: aBoolean [

	"If 'true', the radios can be deselected.
	
	Type: boolean"

	self propertyAt: #allowEmptySelection put: aBoolean
]

{ #category : #api }
IonRadioGroup >> compareWith [

	"This property allows developers to specify a custom function or property name for comparing objects when determining the selected option in the ion-radio-group. When not specified, the default behavior will use strict equality (===) for comparison.
	
	Type: string | RadioGroupCompareFn | null"

	^ self propertyAt: #compareWith
]

{ #category : #api }
IonRadioGroup >> compareWith: anObject [

	"This property allows developers to specify a custom function or property name for comparing objects when determining the selected option in the ion-radio-group. When not specified, the default behavior will use strict equality (===) for comparison.
	
	Type: string | RadioGroupCompareFn | null"

	self propertyAt: #compareWith put: anObject
]

{ #category : #api }
IonRadioGroup >> errorText [

	"The error text to display at the top of the radio group.
	
	Type: string"

	^ self propertyAt: #errorText
]

{ #category : #api }
IonRadioGroup >> errorText: aString [

	"The error text to display at the top of the radio group.
	
	Type: string"

	self propertyAt: #errorText put: aString
]

{ #category : #api }
IonRadioGroup >> helperText [

	"The helper text to display at the top of the radio group.
	
	Type: string"

	^ self propertyAt: #helperText
]

{ #category : #api }
IonRadioGroup >> helperText: aString [

	"The helper text to display at the top of the radio group.
	
	Type: string"

	self propertyAt: #helperText put: aString
]

{ #category : #api }
IonRadioGroup >> name [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	^ self propertyAt: #name
]

{ #category : #api }
IonRadioGroup >> name: aString [

	"The name of the control, which is submitted with the form data.
	
	Type: string"

	self propertyAt: #name put: aString
]

{ #category : #api }
IonRadioGroup >> setFocus [

	"Type: Promise<void>"

	^ self apply: #setFocus resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRadioGroup >> value [

	"the value of the radio group.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonRadioGroup >> value: anObject [

	"the value of the radio group.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
