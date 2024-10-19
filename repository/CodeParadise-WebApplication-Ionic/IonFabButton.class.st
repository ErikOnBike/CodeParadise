Class {
	#name : #IonFabButton,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonFabButton >> activated [

	"If 'true', the fab button will be show a close icon.
	
	Type: boolean"

	^ self propertyAt: #activated
]

{ #category : #api }
IonFabButton >> activated: aBoolean [

	"If 'true', the fab button will be show a close icon.
	
	Type: boolean"

	self propertyAt: #activated put: aBoolean
]

{ #category : #api }
IonFabButton >> closeIcon [

	"The icon name to use for the close icon. This will appear when the fab button is pressed. Only applies if it is the main button inside of a fab containing a fab list.
	
	Type: string"

	^ self propertyAt: #closeIcon
]

{ #category : #api }
IonFabButton >> closeIcon: aString [

	"The icon name to use for the close icon. This will appear when the fab button is pressed. Only applies if it is the main button inside of a fab containing a fab list.
	
	Type: string"

	self propertyAt: #closeIcon put: aString
]

{ #category : #api }
IonFabButton >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonFabButton >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonFabButton >> disabled [

	"If 'true', the user cannot interact with the fab button.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonFabButton >> disabled: aBoolean [

	"If 'true', the user cannot interact with the fab button.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonFabButton >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonFabButton >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonFabButton >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonFabButton >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonFabButton >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonFabButton >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonFabButton >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonFabButton >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonFabButton >> routerAnimation [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonFabButton >> routerAnimation: anObject [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonFabButton >> routerDirection [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	^ self propertyAt: #routerDirection
]

{ #category : #api }
IonFabButton >> routerDirection: anObject [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	self propertyAt: #routerDirection put: anObject
]

{ #category : #api }
IonFabButton >> show [

	"If 'true', the fab button will show when in a fab-list.
	
	Type: boolean"

	^ self propertyAt: #show
]

{ #category : #api }
IonFabButton >> show: aBoolean [

	"If 'true', the fab button will show when in a fab-list.
	
	Type: boolean"

	self propertyAt: #show put: aBoolean
]

{ #category : #api }
IonFabButton >> size [

	"The size of the button. Set this to 'small' in order to have a mini fab button.
	
	Type: 'small'"

	^ self propertyAt: #size
]

{ #category : #api }
IonFabButton >> size: aString [

	"The size of the button. Set this to 'small' in order to have a mini fab button.
	
	Type: 'small'"

	self propertyAt: #size put: aString
]

{ #category : #api }
IonFabButton >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonFabButton >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]

{ #category : #api }
IonFabButton >> translucent [

	"If 'true', the fab button will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	^ self propertyAt: #translucent
]

{ #category : #api }
IonFabButton >> translucent: aBoolean [

	"If 'true', the fab button will be translucent. Only applies when the mode is ''ios'' and the device supports ['backdrop-filter'](https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter#Browser_compatibility).
	
	Type: boolean"

	self propertyAt: #translucent put: aBoolean
]

{ #category : #api }
IonFabButton >> type [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonFabButton >> type: aString [

	"The type of the button.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
