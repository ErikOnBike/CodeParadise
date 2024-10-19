Class {
	#name : #IonBreadcrumb,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonBreadcrumb >> active [

	"If 'true', the breadcrumb will take on a different look to show that it is the currently active breadcrumb. Defaults to 'true' for the last breadcrumb if it is not set on any.
	
	Type: boolean"

	^ self propertyAt: #active
]

{ #category : #api }
IonBreadcrumb >> active: aBoolean [

	"If 'true', the breadcrumb will take on a different look to show that it is the currently active breadcrumb. Defaults to 'true' for the last breadcrumb if it is not set on any.
	
	Type: boolean"

	self propertyAt: #active put: aBoolean
]

{ #category : #api }
IonBreadcrumb >> collapsed [

	"Type: boolean"

	^ self propertyAt: #collapsed
]

{ #category : #api }
IonBreadcrumb >> collapsed: aBoolean [

	"Type: boolean"

	self propertyAt: #collapsed put: aBoolean
]

{ #category : #api }
IonBreadcrumb >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonBreadcrumb >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonBreadcrumb >> disabled [

	"If 'true', the user cannot interact with the breadcrumb.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonBreadcrumb >> disabled: aBoolean [

	"If 'true', the user cannot interact with the breadcrumb.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonBreadcrumb >> download [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	^ self propertyAt: #download
]

{ #category : #api }
IonBreadcrumb >> download: aString [

	"This attribute instructs browsers to download a URL instead of navigating to it, so the user will be prompted to save it as a local file. If the attribute has a value, it is used as the pre-filled file name in the Save prompt (the user can still change the file name if they want).
	
	Type: string | undefined"

	self propertyAt: #download put: aString
]

{ #category : #api }
IonBreadcrumb >> href [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	^ self propertyAt: #href
]

{ #category : #api }
IonBreadcrumb >> href: aString [

	"Contains a URL or a URL fragment that the hyperlink points to. If this property is set, an anchor tag will be rendered.
	
	Type: string | undefined"

	self propertyAt: #href put: aString
]

{ #category : #api }
IonBreadcrumb >> last [

	"Type: boolean"

	^ self propertyAt: #last
]

{ #category : #api }
IonBreadcrumb >> last: aBoolean [

	"Type: boolean"

	self propertyAt: #last put: aBoolean
]

{ #category : #api }
IonBreadcrumb >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonBreadcrumb >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonBreadcrumb >> rel [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	^ self propertyAt: #rel
]

{ #category : #api }
IonBreadcrumb >> rel: aString [

	"Specifies the relationship of the target object to the link object. The value is a space-separated list of [link types](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types).
	
	Type: string | undefined"

	self propertyAt: #rel put: aString
]

{ #category : #api }
IonBreadcrumb >> routerAnimation [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonBreadcrumb >> routerAnimation: anObject [

	"When using a router, it specifies the transition animation when navigating to another page using 'href'.
	
	Type: AnimationBuilder | undefined"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonBreadcrumb >> routerDirection [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	^ self propertyAt: #routerDirection
]

{ #category : #api }
IonBreadcrumb >> routerDirection: anObject [

	"When using a router, it specifies the transition direction when navigating to another page using 'href'.
	
	Type: RouterDirection"

	self propertyAt: #routerDirection put: anObject
]

{ #category : #api }
IonBreadcrumb >> separator [

	"If true, show a separator between this breadcrumb and the next. Defaults to 'true' for all breadcrumbs except the last.
	
	Type: boolean | undefined"

	^ self propertyAt: #separator
]

{ #category : #api }
IonBreadcrumb >> separator: anObject [

	"If true, show a separator between this breadcrumb and the next. Defaults to 'true' for all breadcrumbs except the last.
	
	Type: boolean | undefined"

	self propertyAt: #separator put: anObject
]

{ #category : #api }
IonBreadcrumb >> showCollapsedIndicator [

	"Type: boolean"

	^ self propertyAt: #showCollapsedIndicator
]

{ #category : #api }
IonBreadcrumb >> showCollapsedIndicator: aBoolean [

	"Type: boolean"

	self propertyAt: #showCollapsedIndicator put: aBoolean
]

{ #category : #api }
IonBreadcrumb >> target [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	^ self propertyAt: #target
]

{ #category : #api }
IonBreadcrumb >> target: aString [

	"Specifies where to display the linked URL. Only applies when an 'href' is provided. Special keywords: ''_blank'', ''_self'', ''_parent'', ''_top''.
	
	Type: string | undefined"

	self propertyAt: #target put: aString
]
