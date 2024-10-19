Class {
	#name : #IonButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonButton >> buttonType [

	"The type of button.
	
	Type: string"

	^ self propertyAt: #buttonType
]

{ #category : #api }
IonButton >> buttonType: aString [

	"The type of button.
	
	Type: string"

	self propertyAt: #buttonType put: aString
]

{ #category : #api }
IonButton >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonButton >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonButton >> disabled [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonButton >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonButton >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonButton >> expand [

	"Set to ''block'' for a full-width button or to ''full'' for a full-width button with square corners and no left or right borders.
	
	Type: 'full' | 'block'"

	^ self propertyAt: #expand
]

{ #category : #api }
IonButton >> expand: aString [

	"Set to ''block'' for a full-width button or to ''full'' for a full-width button with square corners and no left or right borders.
	
	Type: 'full' | 'block'"

	self propertyAt: #expand put: aString
]

{ #category : #api }
IonButton >> fill [

	"Set to ''clear'' for a transparent button that resembles a flat button, to ''outline'' for a transparent button with a border, or to ''solid'' for a button with a filled background. The default fill is ''solid'' except inside of a toolbar, where the default is ''clear''.
	
	Type: 'clear' | 'outline' | 'solid' | 'default'"

	^ self propertyAt: #fill
]

{ #category : #api }
IonButton >> fill: aString [

	"Set to ''clear'' for a transparent button that resembles a flat button, to ''outline'' for a transparent button with a border, or to ''solid'' for a button with a filled background. The default fill is ''solid'' except inside of a toolbar, where the default is ''clear''.
	
	Type: 'clear' | 'outline' | 'solid' | 'default'"

	self propertyAt: #fill put: aString
]

{ #category : #api }
IonButton >> form [

	"The HTML form element or form element id. Used to submit a form when the button is not a child of the form.
	
	Type: string | HTMLFormElement"

	^ self propertyAt: #form
]

{ #category : #api }
IonButton >> form: anObject [

	"The HTML form element or form element id. Used to submit a form when the button is not a child of the form.
	
	Type: string | HTMLFormElement"

	self propertyAt: #form put: anObject
]

{ #category : #api }
IonButton >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonButton >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonButton >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonButton >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonButton >> routerAnimation [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonButton >> routerAnimation: anObject [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonButton >> routerDirection [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	^ self propertyAt: #routerDirection
]

{ #category : #api }
IonButton >> routerDirection: anObject [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	self propertyAt: #routerDirection put: anObject
]

{ #category : #api }
IonButton >> shape [

	"Set to ''round'' for a button with more rounded corners.
	
	Type: 'round'"

	^ self propertyAt: #shape
]

{ #category : #api }
IonButton >> shape: aString [

	"Set to ''round'' for a button with more rounded corners.
	
	Type: 'round'"

	self propertyAt: #shape put: aString
]

{ #category : #api }
IonButton >> size [

	"Set to ''small'' for a button with less height and padding, to ''default'' for a button with the default height and padding, or to ''large'' for a button with more height and padding. By default the size is unset, unless the button is inside of an item, where the size is ''small'' by default. Set the size to ''default'' inside of an item to make it a standard size button.
	
	Type: 'small' | 'default' | 'large'"

	^ self propertyAt: #size
]

{ #category : #api }
IonButton >> size: aString [

	"Set to ''small'' for a button with less height and padding, to ''default'' for a button with the default height and padding, or to ''large'' for a button with more height and padding. By default the size is unset, unless the button is inside of an item, where the size is ''small'' by default. Set the size to ''default'' inside of an item to make it a standard size button.
	
	Type: 'small' | 'default' | 'large'"

	self propertyAt: #size put: aString
]

{ #category : #api }
IonButton >> strong [

	"If 'true', activates a button with a heavier font weight.
	
	Type: boolean"

	^ self propertyAt: #strong
]

{ #category : #api }
IonButton >> strong: aBoolean [

	"If 'true', activates a button with a heavier font weight.
	
	Type: boolean"

	self propertyAt: #strong put: aBoolean
]

{ #category : #api }
IonButton >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonButton >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]

{ #category : #api }
IonButton >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonButton >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
