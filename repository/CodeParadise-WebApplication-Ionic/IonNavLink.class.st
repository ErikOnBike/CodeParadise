Class {
	#name : #IonNavLink,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonNavLink >> component [

	"Component to navigate to. Only used if the 'routerDirection' is ''forward'' or ''root''.
	
	Type: NavComponent"

	^ self propertyAt: #component
]

{ #category : #api }
IonNavLink >> component: anObject [

	"Component to navigate to. Only used if the 'routerDirection' is ''forward'' or ''root''.
	
	Type: NavComponent"

	self propertyAt: #component put: anObject
]

{ #category : #api }
IonNavLink >> componentProps [

	"Data you want to pass to the component as props. Only used if the ''routerDirection'' is ''forward'' or ''root''.
	
	Type: ComponentProps"

	^ self propertyAt: #componentProps
]

{ #category : #api }
IonNavLink >> componentProps: anObject [

	"Data you want to pass to the component as props. Only used if the ''routerDirection'' is ''forward'' or ''root''.
	
	Type: ComponentProps"

	self propertyAt: #componentProps put: anObject
]

{ #category : #api }
IonNavLink >> routerAnimation [

	"The transition animation when navigating to another page.
	
	Type: AnimationBuilder"

	^ self propertyAt: #routerAnimation
]

{ #category : #api }
IonNavLink >> routerAnimation: anObject [

	"The transition animation when navigating to another page.
	
	Type: AnimationBuilder"

	self propertyAt: #routerAnimation put: anObject
]

{ #category : #api }
IonNavLink >> routerDirection [

	"The transition direction when navigating to another page.
	
	Type: RouterDirection"

	^ self propertyAt: #routerDirection
]

{ #category : #api }
IonNavLink >> routerDirection: anObject [

	"The transition direction when navigating to another page.
	
	Type: RouterDirection"

	self propertyAt: #routerDirection put: anObject
]
