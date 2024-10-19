Class {
	#name : #IonChip,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonChip >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonChip >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonChip >> disabled [

	"If 'true', the user cannot interact with the chip.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonChip >> disabled: aBoolean [

	"If 'true', the user cannot interact with the chip.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonChip >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonChip >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonChip >> outline [

	"Display an outline style button.
	
	Type: boolean"

	^ self propertyAt: #outline
]

{ #category : #api }
IonChip >> outline: aBoolean [

	"Display an outline style button.
	
	Type: boolean"

	self propertyAt: #outline put: aBoolean
]
