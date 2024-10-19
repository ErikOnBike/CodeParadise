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
