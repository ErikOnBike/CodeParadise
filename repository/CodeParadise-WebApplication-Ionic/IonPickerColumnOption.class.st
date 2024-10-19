Class {
	#name : #IonPickerColumnOption,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonPickerColumnOption >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonPickerColumnOption >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonPickerColumnOption >> disabled [

	"If 'true', the user cannot interact with the picker column option.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonPickerColumnOption >> disabled: aBoolean [

	"If 'true', the user cannot interact with the picker column option.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonPickerColumnOption >> value [

	"The text value of the option.
	
	Type: any | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonPickerColumnOption >> value: anObject [

	"The text value of the option.
	
	Type: any | null"

	self propertyAt: #value put: anObject
]
