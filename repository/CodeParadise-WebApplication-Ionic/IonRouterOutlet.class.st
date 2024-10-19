Class {
	#name : #IonRouterOutlet,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRouterOutlet >> animated [

	"If 'true', the router-outlet should animate the transition of components.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonRouterOutlet >> animated: aBoolean [

	"If 'true', the router-outlet should animate the transition of components.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonRouterOutlet >> animation [

	"This property allows to create custom transition using AnimationBuilder functions.
	
	Type: AnimationBuilder"

	^ self propertyAt: #animation
]

{ #category : #api }
IonRouterOutlet >> animation: anObject [

	"This property allows to create custom transition using AnimationBuilder functions.
	
	Type: AnimationBuilder"

	self propertyAt: #animation put: anObject
]

{ #category : #api }
IonRouterOutlet >> commit: enteringEl leavingEl: leavingEl [

	"Type: (enteringEl: HTMLElement, leavingEl: HTMLElement | undefined, opts?: RouterOutletOptions) => Promise<boolean>"

	^ self apply: #commit withArguments: { enteringEl . leavingEl } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouterOutlet >> commit: enteringEl leavingEl: leavingEl opts: opts [

	"Type: (enteringEl: HTMLElement, leavingEl: HTMLElement | undefined, opts?: RouterOutletOptions) => Promise<boolean>"

	^ self apply: #commit withArguments: { enteringEl . leavingEl . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouterOutlet >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonRouterOutlet >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonRouterOutlet >> getRouteId [

	"Type: Promise<RouteID | undefined>"

	^ self apply: #getRouteId resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouterOutlet >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonRouterOutlet >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonRouterOutlet >> setRouteId: id params: params direction: direction [

	"Type: (id: string, params: ComponentProps | undefined, direction: RouterDirection, animation?: AnimationBuilder) => Promise<RouteWrite>"

	^ self apply: #setRouteId withArguments: { id . params . direction } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouterOutlet >> setRouteId: id params: params direction: direction animation: animation [

	"Type: (id: string, params: ComponentProps | undefined, direction: RouterDirection, animation?: AnimationBuilder) => Promise<RouteWrite>"

	^ self apply: #setRouteId withArguments: { id . params . direction . animation } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRouterOutlet >> swipeHandler [

	"Type: SwipeGestureHandler"

	^ self propertyAt: #swipeHandler
]

{ #category : #api }
IonRouterOutlet >> swipeHandler: anObject [

	"Type: SwipeGestureHandler"

	self propertyAt: #swipeHandler put: anObject
]
