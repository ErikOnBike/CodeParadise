Class {
	#name : #IonSpinner,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSpinner >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonSpinner >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonSpinner >> duration [

	"Duration of the spinner animation in milliseconds. The default varies based on the spinner.
	
	Type: number"

	^ self propertyAt: #duration
]

{ #category : #api }
IonSpinner >> duration: aNumber [

	"Duration of the spinner animation in milliseconds. The default varies based on the spinner.
	
	Type: number"

	self propertyAt: #duration put: aNumber
]

{ #category : #api }
IonSpinner >> name [

	"The name of the SVG spinner to use. If a name is not provided, the platform's default spinner will be used.
	
	Type: SpinnerTypes"

	^ self propertyAt: #name
]

{ #category : #api }
IonSpinner >> name: anObject [

	"The name of the SVG spinner to use. If a name is not provided, the platform's default spinner will be used.
	
	Type: SpinnerTypes"

	self propertyAt: #name put: anObject
]

{ #category : #api }
IonSpinner >> paused [

	"If 'true', the spinner's animation will be paused.
	
	Type: boolean"

	^ self propertyAt: #paused
]

{ #category : #api }
IonSpinner >> paused: aBoolean [

	"If 'true', the spinner's animation will be paused.
	
	Type: boolean"

	self propertyAt: #paused put: aBoolean
]
