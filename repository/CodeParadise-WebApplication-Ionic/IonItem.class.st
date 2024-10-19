Class {
	#name : #IonItem,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonItem >> button [

	"If 'true', a button tag will be rendered and the item will be tappable.
	
	Type: boolean"

	^ self propertyAt: #button
]

{ #category : #api }
IonItem >> button: aBoolean [

	"If 'true', a button tag will be rendered and the item will be tappable.
	
	Type: boolean"

	self propertyAt: #button put: aBoolean
]

{ #category : #api }
IonItem >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonItem >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonItem >> detail [

	"If 'true', a detail arrow will appear on the item. Defaults to 'false' unless the 'mode' is 'ios' and an 'href' or 'button' property is present.
	
	Type: boolean"

	^ self propertyAt: #detail
]

{ #category : #api }
IonItem >> detail: aBoolean [

	"If 'true', a detail arrow will appear on the item. Defaults to 'false' unless the 'mode' is 'ios' and an 'href' or 'button' property is present.
	
	Type: boolean"

	self propertyAt: #detail put: aBoolean
]

{ #category : #api }
IonItem >> detailIcon [

	"The icon to use when 'detail' is set to 'true'.
	
	Type: string"

	^ self propertyAt: #detailIcon
]

{ #category : #api }
IonItem >> detailIcon: aString [

	"The icon to use when 'detail' is set to 'true'.
	
	Type: string"

	self propertyAt: #detailIcon put: aString
]

{ #category : #api }
IonItem >> disabled [

	"If 'true', the user cannot interact with the item.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonItem >> disabled: aBoolean [

	"If 'true', the user cannot interact with the item.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonItem >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonItem >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonItem >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonItem >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonItem >> lines [

	"How the bottom border should be displayed on the item.
	
	Type: 'full' | 'inset' | 'none'"

	^ self propertyAt: #lines
]

{ #category : #api }
IonItem >> lines: aString [

	"How the bottom border should be displayed on the item.
	
	Type: 'full' | 'inset' | 'none'"

	self propertyAt: #lines put: aString
]

{ #category : #api }
IonItem >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonItem >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonItem >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonItem >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonItem >> routerAnimation [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonItem >> routerAnimation: anObject [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonItem >> routerDirection [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	^ self propertyAt: #routerDirection
]

{ #category : #api }
IonItem >> routerDirection: anObject [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	self propertyAt: #routerDirection put: anObject
]

{ #category : #api }
IonItem >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonItem >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]

{ #category : #api }
IonItem >> type [

	"The type of the button. Only used when an 'onclick' or 'button' property is present.
	
	Type: 'submit' | 'reset' | 'button'"

	^ self propertyAt: #type
]

{ #category : #api }
IonItem >> type: aString [

	"The type of the button. Only used when an 'onclick' or 'button' property is present.
	
	Type: 'submit' | 'reset' | 'button'"

	self propertyAt: #type put: aString
]
