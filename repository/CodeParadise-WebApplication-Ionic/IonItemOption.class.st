Class {
	#name : #IonItemOption,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonItemOption >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonItemOption >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonItemOption >> disabled [

	"If 'true', the user cannot interact with the item option.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonItemOption >> disabled: aBoolean [

	"If 'true', the user cannot interact with the item option.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonItemOption >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonItemOption >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonItemOption >> expandable [

	"If 'true', the option will expand to take up the available width and cover any other options.
	
	Type: boolean"

	^ self propertyAt: #expandable
]

{ #category : #api }
IonItemOption >> expandable: aBoolean [

	"If 'true', the option will expand to take up the available width and cover any other options.
	
	Type: boolean"

	self propertyAt: #expandable put: aBoolean
]

{ #category : #api }
IonItemOption >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonItemOption >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonItemOption >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonItemOption >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonItemOption >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonItemOption >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonItemOption >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonItemOption >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]

{ #category : #api }
IonItemOption >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonItemOption >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
