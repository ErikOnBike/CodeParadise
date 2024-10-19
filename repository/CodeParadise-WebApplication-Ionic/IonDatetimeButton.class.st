Class {
	#name : #IonDatetimeButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonDatetimeButton >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonDatetimeButton >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonDatetimeButton >> datetime [

	"The ID of the 'ion-datetime' instance associated with the datetime button.
	
	Type: string"

	^ self propertyAt: #datetime
]

{ #category : #api }
IonDatetimeButton >> datetime: aString [

	"The ID of the 'ion-datetime' instance associated with the datetime button.
	
	Type: string"

	self propertyAt: #datetime put: aString
]

{ #category : #api }
IonDatetimeButton >> disabled [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonDatetimeButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonDatetimeButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonDatetimeButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]
