Class {
	#name : #IonBackButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonBackButton >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonBackButton >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonBackButton >> defaultHref [

	"The url to navigate back to by default when there is no history.
	
	Type: string"

	^ self propertyAt: #defaultHref
]

{ #category : #api }
IonBackButton >> defaultHref: aString [

	"The url to navigate back to by default when there is no history.
	
	Type: string"

	self propertyAt: #defaultHref put: aString
]

{ #category : #api }
IonBackButton >> disabled [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonBackButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonBackButton >> icon [

	"The built-in named SVG icon name or the exact 'src' of an SVG file to use for the back button.
	
	Type: string | null"

	^ self propertyAt: #icon
]

{ #category : #api }
IonBackButton >> icon: aString [

	"The built-in named SVG icon name or the exact 'src' of an SVG file to use for the back button.
	
	Type: string | null"

	self propertyAt: #icon put: aString
]

{ #category : #api }
IonBackButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonBackButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonBackButton >> routerAnimation [

	"When using a router, it specifies the transition animation when navigating to another page.
	
	Type: AnimationBuilder | undefined"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonBackButton >> routerAnimation: anObject [

	"When using a router, it specifies the transition animation when navigating to another page.
	
	Type: AnimationBuilder | undefined"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonBackButton >> text [

	"The text to display in the back button.
	
	Type: string | null"

	^ self propertyAt: #text
]

{ #category : #api }
IonBackButton >> text: aString [

	"The text to display in the back button.
	
	Type: string | null"

	self propertyAt: #text put: aString
]

{ #category : #api }
IonBackButton >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonBackButton >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
