Class {
	#name : #IonInputPasswordToggle,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonInputPasswordToggle >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonInputPasswordToggle >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonInputPasswordToggle >> hideIcon [

	"The icon that can be used to represent hiding a password. If not set, the 'eyeOff' Ionicon will be used.
	
	Type: string"

	^ self propertyAt: #hideIcon
]

{ #category : #api }
IonInputPasswordToggle >> hideIcon: aString [

	"The icon that can be used to represent hiding a password. If not set, the 'eyeOff' Ionicon will be used.
	
	Type: string"

	self propertyAt: #hideIcon put: aString
]

{ #category : #api }
IonInputPasswordToggle >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonInputPasswordToggle >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonInputPasswordToggle >> showIcon [

	"The icon that can be used to represent showing a password. If not set, the 'eye' Ionicon will be used.
	
	Type: string"

	^ self propertyAt: #showIcon
]

{ #category : #api }
IonInputPasswordToggle >> showIcon: aString [

	"The icon that can be used to represent showing a password. If not set, the 'eye' Ionicon will be used.
	
	Type: string"

	self propertyAt: #showIcon put: aString
]

{ #category : #api }
IonInputPasswordToggle >> type [

	"Type: TextFieldTypes"

	^ self propertyAt: #type
]

{ #category : #api }
IonInputPasswordToggle >> type: anObject [

	"Type: TextFieldTypes"

	self propertyAt: #type put: anObject
]
