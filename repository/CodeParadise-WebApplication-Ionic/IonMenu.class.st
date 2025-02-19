Class {
	#name : #IonMenu,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonMenu >> close [

	"Closes the menu. If the menu is already closed or it can't be closed, it returns 'false'.
	
	Type: (animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> close: animated [

	"Closes the menu. If the menu is already closed or it can't be closed, it returns 'false'.
	
	Type: (animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #close withArguments: { animated } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> close: animated role: role [

	"Closes the menu. If the menu is already closed or it can't be closed, it returns 'false'.
	
	Type: (animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #close withArguments: { animated . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> contentId [

	"The 'id' of the main content. When using a router this is typically 'ion-router-outlet'. When not using a router, this is typically your main view's 'ion-content'. This is not the id of the 'ion-content' inside of your 'ion-menu'.
	
	Type: string"

	^ self propertyAt: #contentId
]

{ #category : #api }
IonMenu >> contentId: aString [

	"The 'id' of the main content. When using a router this is typically 'ion-router-outlet'. When not using a router, this is typically your main view's 'ion-content'. This is not the id of the 'ion-content' inside of your 'ion-menu'.
	
	Type: string"

	self propertyAt: #contentId put: aString
]

{ #category : #api }
IonMenu >> disabled [

	"If 'true', the menu is disabled.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonMenu >> disabled: aBoolean [

	"If 'true', the menu is disabled.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonMenu >> isActive [

	"Returns 'true' is the menu is active.  A menu is active when it can be opened or closed, meaning it's enabled and it's not part of a 'ion-split-pane'.
	
	Type: Promise<boolean>"

	^ self apply: #isActive resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> isOpen [

	"Returns 'true' is the menu is open.
	
	Type: Promise<boolean>"

	^ self apply: #isOpen resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> maxEdgeStart [

	"The edge threshold for dragging the menu open. If a drag/swipe happens over this value, the menu is not triggered.
	
	Type: number"

	^ self propertyAt: #maxEdgeStart
]

{ #category : #api }
IonMenu >> maxEdgeStart: aNumber [

	"The edge threshold for dragging the menu open. If a drag/swipe happens over this value, the menu is not triggered.
	
	Type: number"

	self propertyAt: #maxEdgeStart put: aNumber
]

{ #category : #api }
IonMenu >> menuId [

	"An id for the menu.
	
	Type: string"

	^ self propertyAt: #menuId
]

{ #category : #api }
IonMenu >> menuId: aString [

	"An id for the menu.
	
	Type: string"

	self propertyAt: #menuId put: aString
]

{ #category : #api }
IonMenu >> open [

	"Opens the menu. If the menu is already open or it can't be opened, it returns 'false'.
	
	Type: (animated?: boolean) => Promise<boolean>"

	^ self apply: #open resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> open: animated [

	"Opens the menu. If the menu is already open or it can't be opened, it returns 'false'.
	
	Type: (animated?: boolean) => Promise<boolean>"

	^ self apply: #open withArguments: { animated } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> setOpen: shouldOpen [

	"Opens or closes the button. If the operation can't be completed successfully, it returns 'false'.
	
	Type: (shouldOpen: boolean, animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #setOpen withArguments: { shouldOpen } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> setOpen: shouldOpen animated: animated [

	"Opens or closes the button. If the operation can't be completed successfully, it returns 'false'.
	
	Type: (shouldOpen: boolean, animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #setOpen withArguments: { shouldOpen . animated } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> setOpen: shouldOpen animated: animated role: role [

	"Opens or closes the button. If the operation can't be completed successfully, it returns 'false'.
	
	Type: (shouldOpen: boolean, animated?: boolean, role?: string) => Promise<boolean>"

	^ self apply: #setOpen withArguments: { shouldOpen . animated . role } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> side [

	"Which side of the view the menu should be placed.
	
	Type: Side"

	^ self propertyAt: #side
]

{ #category : #api }
IonMenu >> side: anObject [

	"Which side of the view the menu should be placed.
	
	Type: Side"

	self propertyAt: #side put: anObject
]

{ #category : #api }
IonMenu >> swipeGesture [

	"If 'true', swiping the menu is enabled.
	
	Type: boolean"

	^ self propertyAt: #swipeGesture
]

{ #category : #api }
IonMenu >> swipeGesture: aBoolean [

	"If 'true', swiping the menu is enabled.
	
	Type: boolean"

	self propertyAt: #swipeGesture put: aBoolean
]

{ #category : #api }
IonMenu >> toggle [

	"Toggles the menu. If the menu is already open, it will try to close, otherwise it will try to open it. If the operation can't be completed successfully, it returns 'false'.
	
	Type: (animated?: boolean) => Promise<boolean>"

	^ self apply: #toggle resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> toggle: animated [

	"Toggles the menu. If the menu is already open, it will try to close, otherwise it will try to open it. If the operation can't be completed successfully, it returns 'false'.
	
	Type: (animated?: boolean) => Promise<boolean>"

	^ self apply: #toggle withArguments: { animated } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonMenu >> type [

	"The display type of the menu. Available options: ''overlay'', ''reveal'', ''push''.
	
	Type: MenuType"

	^ self propertyAt: #type
]

{ #category : #api }
IonMenu >> type: anObject [

	"The display type of the menu. Available options: ''overlay'', ''reveal'', ''push''.
	
	Type: MenuType"

	self propertyAt: #type put: anObject
]
