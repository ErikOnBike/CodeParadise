Class {
	#name : #IonItemDivider,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonItemDivider >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonItemDivider >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonItemDivider >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonItemDivider >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonItemDivider >> sticky [

	"When it's set to 'true', the item-divider will stay visible when it reaches the top of the viewport until the next 'ion-item-divider' replaces it.  This feature relies in 'position:sticky': https://caniuse.com/#feat=css-sticky
	
	Type: boolean"

	^ self propertyAt: #sticky
]

{ #category : #api }
IonItemDivider >> sticky: aBoolean [

	"When it's set to 'true', the item-divider will stay visible when it reaches the top of the viewport until the next 'ion-item-divider' replaces it.  This feature relies in 'position:sticky': https://caniuse.com/#feat=css-sticky
	
	Type: boolean"

	self propertyAt: #sticky put: aBoolean
]
