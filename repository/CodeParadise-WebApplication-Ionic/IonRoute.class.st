Class {
	#name : #IonRoute,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #support }
IonRoute class >> redirect: aString [

	"Answer a NavigationHookOptions compatible instance representing a redirect
	to the specified URL (a String)"

	^ Dictionary new
		at: #redirect put: aString ;
		yourself
]

{ #category : #api }
IonRoute >> beforeEnter [

	"A navigation hook that is fired when the route tries to enter. Returning 'true' allows the navigation to proceed, while returning 'false' causes it to be cancelled. Returning a 'NavigationHookOptions' object causes the router to redirect to the path specified.
	
	Type: NavigationHookCallback"

	^ self propertyAt: #beforeEnter
]

{ #category : #api }
IonRoute >> beforeEnter: anObject [

	"A navigation hook that is fired when the route tries to enter. Returning 'true' allows the navigation to proceed, while returning 'false' causes it to be cancelled. Returning a 'NavigationHookOptions' object causes the router to redirect to the path specified.
	
	Type: NavigationHookCallback"

	self propertyAt: #beforeEnter put: anObject
]

{ #category : #api }
IonRoute >> beforeLeave [

	"A navigation hook that is fired when the route tries to leave. Returning 'true' allows the navigation to proceed, while returning 'false' causes it to be cancelled. Returning a 'NavigationHookOptions' object causes the router to redirect to the path specified.
	
	Type: NavigationHookCallback"

	^ self propertyAt: #beforeLeave
]

{ #category : #api }
IonRoute >> beforeLeave: anObject [

	"A navigation hook that is fired when the route tries to leave. Returning 'true' allows the navigation to proceed, while returning 'false' causes it to be cancelled. Returning a 'NavigationHookOptions' object causes the router to redirect to the path specified.
	
	Type: NavigationHookCallback"

	self propertyAt: #beforeLeave put: anObject
]

{ #category : #api }
IonRoute >> component [

	"Name of the component to load/select in the navigation outlet ('ion-tabs', 'ion-nav') when the route matches.  The value of this property is not always the tagname of the component to load, in 'ion-tabs' it actually refers to the name of the 'ion-tab' to select.
	
	Type: string"

	^ self propertyAt: #component
]

{ #category : #api }
IonRoute >> component: aString [

	"Name of the component to load/select in the navigation outlet ('ion-tabs', 'ion-nav') when the route matches.  The value of this property is not always the tagname of the component to load, in 'ion-tabs' it actually refers to the name of the 'ion-tab' to select.
	
	Type: string"

	self propertyAt: #component put: aString
]

{ #category : #api }
IonRoute >> componentProps [

	"A key value '{ 'red': true, 'blue': 'white'}' containing props that should be passed to the defined component when rendered.
	
	Type: { [key: string]: any }"

	^ self propertyAt: #componentProps
]

{ #category : #api }
IonRoute >> componentProps: anObject [

	"A key value '{ 'red': true, 'blue': 'white'}' containing props that should be passed to the defined component when rendered.
	
	Type: { [key: string]: any }"

	self propertyAt: #componentProps put: anObject
]

{ #category : #api }
IonRoute >> url [

	"Relative path that needs to match in order for this route to apply.  Accepts paths similar to expressjs so that you can define parameters in the url /foo/:bar where bar would be available in incoming props.
	
	Type: string"

	^ self propertyAt: #url
]

{ #category : #api }
IonRoute >> url: aString [

	"Relative path that needs to match in order for this route to apply.  Accepts paths similar to expressjs so that you can define parameters in the url /foo/:bar where bar would be available in incoming props.
	
	Type: string"

	self propertyAt: #url put: aString
]
