"
I represent a Page in the Canyon app.
I am responsible for navigation (to another page or back) and deciding if navigation is possible.
My instances can be bound to a Model to allow a user to interact with it. Typically this is
done in collaboration with a CpPropertyModelView.
When bound, the Model in my instances might need to show non-public information. Therefore my
instances need to be defined explicitly for public use. By default they assume an authenticated
user is required. Making a Page public is done by adding a placeholder method/tag #isPublicTag
(see also method #isPublic).
My instances can have a header and/or footer. It is also possible to use tabs within a page.
When tabs are present, be sure to handle the navigation between tabs within the page itself.
It does not become part of the navigation mechanism between pages.
It is also possible to show a page modal. This can be useful when for example during execution
the user session timed out and the user needs to login first. Showing the login modal allows
the existing page to remain available while the user logs in.
"
Class {
	#name : #CynPage,
	#superclass : #CynModelView,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #tags }
CynPage class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CynPage class >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user).

	Implementation:
	The presence of the method #isPublicTag on a subclass indicates that the page is public.
	It therefore has to be set explicitly on all public pages. Everything else is non-public
	by default."

	^ self classSide includesSelector: #isPublicTag
]

{ #category : #'web resources' }
CynPage class >> style [

	<webResource: #css>

	"Hide buttons by transitioning them to a 0 width and 0 opacity. Specificity is important, therefore long CSS selector.
	Icon within buttons keep their original size (assuming default size for now) during the transition."

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	height: 100%;
}'
]

{ #category : #'view - customization' }
CynPage >> canNavigate [

	"Answer whether the receiver allows navigating elsewhere.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	self childViewsDo: [ :each |
		each canNavigate
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'view - customization' }
CynPage >> canNavigateBack [

	"Answer whether the receiver allows navigating back.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	self childViewsDo: [ :each |
		each canNavigateBack
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #accessing }
CynPage >> canyonPage [

	^ self
]

{ #category : #view }
CynPage >> close [

	self app
		closePage: self
]

{ #category : #'view - customization' }
CynPage >> documentTitleFrom: aString [

	"Answer the document title (the title shown in the Browser on desktops) based
	on the specified page title. Since mobile apps have limited space, this method
	might add some pre- or postfix for a more meaningful name."

	^ aString
]

{ #category : #initialization }
CynPage >> initialize [

	super initialize.

	self classed: #public if: self isPublic
]

{ #category : #testing }
CynPage >> isCurrent [

	"Answer whether the receiver is the current (aka top) page"

	^ self nextSibling isNil
]

{ #category : #testing }
CynPage >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user)"

	^ self class isPublic
]

{ #category : #testing }
CynPage >> isWidePreferred [

	"Answer whether the receiver is preferrably shown on a wide screen.
	By default all pages are shown wide in the receiver.
	This is only relevant on wide displays (i.e. laptops or desktops)."

	^ true
]

{ #category : #view }
CynPage >> navigateBack [

	"Navigate to the previous page"

	"Only navigate back from the current/top page (otherwise #close should have been used)"
	self isCurrent
		ifFalse: [ ^ self ].

	self canNavigateBack
		ifFalse: [ ^ self ].

	self close
]

{ #category : #view }
CynPage >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page"

	self canNavigate
		ifFalse: [ ^ self ].

	self app
		showPage: aPageClass withModel: aModel
]

{ #category : #accessing }
CynPage >> previousPage [

	"Answer the page before the receiver (if any)"

	^ self previousSibling
]

{ #category : #accessing }
CynPage >> screenWidth [

	"Answer the screen width setting (as stored in a persistent variable)
	or use default #auto (alternatives are #min and #max)"

	^ (CpClientEnvironment current
			persistentVariableAt: #SCREEN_WIDTH)
				ifNotNil: [ :value | value asSymbol ]
				ifNil: [ #auto ]
]

{ #category : #'view - customization' }
CynPage >> updateBeforeNavigate [

	"Update the receiver just before being shown (again) because of a navigation.
	Be aware the receiver might not be connected to the document yet. If needed
	it can be checked by sending #isConnected"

	super updateBeforeNavigate.

	self
		updateScreenWidth ;
		updateTitle: self title
]

{ #category : #view }
CynPage >> updateScreenWidth [

	"The receiver can be shown using the full width of the device, always use a minimal (thin)
	display or dynamically decide based on the page's behavior. Three different values are
	possible (and stored in the persistent variable #SCREEN_WIDTH, see method #screenWidth):
		- #min (always show thin display)
		- #max (always show full width)
		- #auto (let page decide based on response from #isWidePreferred)

	It is up to the app to decide how the user can select her preference."

	| screenWidth isWidePreferred |

	screenWidth := self screenWidth.
	isWidePreferred := self isWidePreferred.

	CpHtmlElement documentBody
		classed: #thin if: (screenWidth = #min or: [ screenWidth = #auto and: [ isWidePreferred not ] ])
]

{ #category : #view }
CynPage >> updateTitle: aString [

	"Update the title of the receiver and on desktops the browser title as well"

	| titleString |

	titleString := aString.

	"Set the title in the <ion-title> of the <ion-header>, if available and not marked 'readonly'"
	(self shadowedFirstDescendantMatching: IonHeader asCssSelector) ifNotNil: [ :header |
		(header firstDescendantMatching: IonTitle asCssSelector) ifNotNil: [ :title |

			"Only set the title if it is not marked 'readonly' and an actual title is provided"
			(titleString isNil or: [ title isClassed: #readonly ])
				ifTrue: [ titleString := title textContent ]
				ifFalse: [ title textContent: titleString ] ] ].

	"Set the title of the page as the browser title (for desktop)"
	CpBrowserDocument current
		title: (self documentTitleFrom: titleString)
]
