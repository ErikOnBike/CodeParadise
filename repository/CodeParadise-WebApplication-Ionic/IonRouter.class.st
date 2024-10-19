Class {
	#name : #IonRouter,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRouter >> back [

	"Go back to previous page in the window.history.
	
	Type: Promise<void>"

	^ self apply: #back resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> canTransition [

	"Type: Promise<string | boolean>"

	^ self apply: #canTransition resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> navChanged: direction [

	"Type: (direction: RouterDirection) => Promise<boolean>"

	^ self apply: #navChanged withArguments: { direction } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> printDebug [

	"Type: Promise<void>"

	^ self apply: #printDebug resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> push: path [

	"Navigate to the specified path.
	@param path The path to navigate to.
	@param direction The direction of the animation. Defaults to ''forward''.
	
	Type: (path: string, direction?: RouterDirection, animation?: AnimationBuilder) => Promise<boolean>"

	^ self apply: #push withArguments: { path } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> push: path direction: direction [

	"Navigate to the specified path.
	@param path The path to navigate to.
	@param direction The direction of the animation. Defaults to ''forward''.
	
	Type: (path: string, direction?: RouterDirection, animation?: AnimationBuilder) => Promise<boolean>"

	^ self apply: #push withArguments: { path . direction } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> push: path direction: direction animation: animation [

	"Navigate to the specified path.
	@param path The path to navigate to.
	@param direction The direction of the animation. Defaults to ''forward''.
	
	Type: (path: string, direction?: RouterDirection, animation?: AnimationBuilder) => Promise<boolean>"

	^ self apply: #push withArguments: { path . direction . animation } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouter >> root [

	"The root path to use when matching URLs. By default, this is set to '/', but you can specify an alternate prefix for all URL paths.
	
	Type: string"

	^ self propertyAt: #root
]

{ #category : #api }
IonRouter >> root: aString [

	"The root path to use when matching URLs. By default, this is set to '/', but you can specify an alternate prefix for all URL paths.
	
	Type: string"

	self propertyAt: #root put: aString
]

{ #category : #api }
IonRouter >> useHash [

	"The router can work in two 'modes': - With hash: '/index.html#/path/to/page' - Without hash: '/path/to/page'  Using one or another might depend in the requirements of your app and/or where it's deployed.  Usually 'hash-less' navigation works better for SEO and it's more user friendly too, but it might requires additional server-side configuration in order to properly work.  On the other side hash-navigation is much easier to deploy, it even works over the file protocol.  By default, this property is 'true', change to 'false' to allow hash-less URLs.
	
	Type: boolean"

	^ self propertyAt: #useHash
]

{ #category : #api }
IonRouter >> useHash: aBoolean [

	"The router can work in two 'modes': - With hash: '/index.html#/path/to/page' - Without hash: '/path/to/page'  Using one or another might depend in the requirements of your app and/or where it's deployed.  Usually 'hash-less' navigation works better for SEO and it's more user friendly too, but it might requires additional server-side configuration in order to properly work.  On the other side hash-navigation is much easier to deploy, it even works over the file protocol.  By default, this property is 'true', change to 'false' to allow hash-less URLs.
	
	Type: boolean"

	self propertyAt: #useHash put: aBoolean
]
