Class {
	#name : #IonMenuButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonMenuButton >> autoHide [

	"Automatically hides the menu button when the corresponding menu is not active
	
	Type: boolean"

	^ self propertyAt: #autoHide
]

{ #category : #api }
IonMenuButton >> autoHide: aBoolean [

	"Automatically hides the menu button when the corresponding menu is not active
	
	Type: boolean"

	self propertyAt: #autoHide put: aBoolean
]

{ #category : #api }
IonMenuButton >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonMenuButton >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonMenuButton >> disabled [

	"If 'true', the user cannot interact with the menu button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonMenuButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the menu button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonMenuButton >> menu [

	"Optional property that maps to a Menu's 'menuId' prop. Can also be 'start' or 'end' for the menu side. This is used to find the correct menu to toggle
	
	Type: string"

	^ self propertyAt: #menu
]

{ #category : #api }
IonMenuButton >> menu: aString [

	"Optional property that maps to a Menu's 'menuId' prop. Can also be 'start' or 'end' for the menu side. This is used to find the correct menu to toggle
	
	Type: string"

	self propertyAt: #menu put: aString
]

{ #category : #api }
IonMenuButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonMenuButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonMenuButton >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonMenuButton >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
