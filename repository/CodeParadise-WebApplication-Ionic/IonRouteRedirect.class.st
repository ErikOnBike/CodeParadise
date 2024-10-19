Class {
	#name : #IonRouteRedirect,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRouteRedirect >> from [

	"A redirect route, redirects 'from' a URL 'to' another URL. This property is that 'from' URL. It needs to be an exact match of the navigated URL in order to apply.  The path specified in this value is always an absolute path, even if the initial '/' slash is not specified.
	
	Type: string"

	^ self propertyAt: #from
]

{ #category : #api }
IonRouteRedirect >> from: aString [

	"A redirect route, redirects 'from' a URL 'to' another URL. This property is that 'from' URL. It needs to be an exact match of the navigated URL in order to apply.  The path specified in this value is always an absolute path, even if the initial '/' slash is not specified.
	
	Type: string"

	self propertyAt: #from put: aString
]

{ #category : #api }
IonRouteRedirect >> to [

	"A redirect route, redirects 'from' a URL 'to' another URL. This property is that 'to' URL. When the defined 'ion-route-redirect' rule matches, the router will redirect to the path specified in this property.  The value of this property is always an absolute path inside the scope of routes defined in 'ion-router' it can't be used with another router or to perform a redirection to a different domain.  Note that this is a virtual redirect, it will not cause a real browser refresh, again, it's a redirect inside the context of ion-router.  When this property is not specified or his value is 'undefined' the whole redirect route is noop, even if the 'from' value matches.
	
	Type: string | undefined | null"

	^ self propertyAt: #to
]

{ #category : #api }
IonRouteRedirect >> to: aString [

	"A redirect route, redirects 'from' a URL 'to' another URL. This property is that 'to' URL. When the defined 'ion-route-redirect' rule matches, the router will redirect to the path specified in this property.  The value of this property is always an absolute path inside the scope of routes defined in 'ion-router' it can't be used with another router or to perform a redirection to a different domain.  Note that this is a virtual redirect, it will not cause a real browser refresh, again, it's a redirect inside the context of ion-router.  When this property is not specified or his value is 'undefined' the whole redirect route is noop, even if the 'from' value matches.
	
	Type: string | undefined | null"

	self propertyAt: #to put: aString
]
