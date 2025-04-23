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
	#name : #CpCanyonAppPage,
	#superclass : #CpTemplateComponent,
	#classVars : [
		'Mapping'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #accessing }
CpCanyonAppPage class >> app [

	"Convenience method to access the app (instance)"

	^ CpCanyonAppMainView current
]

{ #category : #accessing }
CpCanyonAppPage class >> classForModel: aModel [

	"Answer the most appropriate/specific class for the specified Model"

	| modelClass |

	modelClass := aModel class.

	"Use explicitly mapped Class first"
	Mapping at: modelClass ifPresent: [ :pageClass | ^ pageClass ].

	"Use class with same/similar name second"
	(Smalltalk classNamed: modelClass name, #Page) ifNotNil: [ :pageClass |
		^ pageClass ].

	self error: 'No Page class found for Model ', modelClass name
]

{ #category : #tags }
CpCanyonAppPage class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
CpCanyonAppPage class >> isHome [

	"Answer whether the receiver is the home page (should be true for one page)"

	^ false
]

{ #category : #testing }
CpCanyonAppPage class >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user).

	Implementation:
	The presence of the method #isPublicTag on a subclass indicates that the page is public.
	It therefore has to be set explicitly on all public pages. Everything else is non-public
	by default."

	^ self classSide includesSelector: #isPublicTag
]

{ #category : #accessing }
CpCanyonAppPage class >> pageClassNamed: aString [

	"Answer the Page class for the specified name.
	Convenience method if there is need to refer to pages by name."

	self allSubclassesDo: [ :each |
		each pageName = aString
			ifTrue: [ ^ each ] ].

	^ nil
]

{ #category : #accessing }
CpCanyonAppPage class >> pageName [

	"Answer the name of the receiver"

	^ self nameWithoutPrefix withoutSuffix: #Page
]

{ #category : #'class initialization' }
CpCanyonAppPage class >> postInstall [

	super postInstall.

	self registerClassMapping
]

{ #category : #'class initialization' }
CpCanyonAppPage class >> postInstallOnce [

	Mapping := Dictionary new
]

{ #category : #'class initialization' }
CpCanyonAppPage class >> registerClass: aModelClass for: aPageClass [

	Mapping at: aModelClass ifPresent: [ :pageClass |
		self warnCr: 'Page class ', pageClass name, ' already registered for handling ', aModelClass name, ', overriding with ', aPageClass name ].

	Mapping at: aModelClass put: aPageClass
]

{ #category : #'class initialization' }
CpCanyonAppPage class >> registerClassMapping [

	"Add class mappings to the receiver.
	Subclasses should override but NOT call the super implementation.
	Otherwise additional mappings will be created."
]

{ #category : #'web resources' }
CpCanyonAppPage class >> style [

	<webResource: #css>

	"Hide buttons by transitioning them to a 0 width and 0 opacity. Specificity is important, therefore long CSS selector.
	Icon within buttons keep their original size (assuming default size for now) during the transition."

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	height: 100%;
}
:host ion-buttons ion-button {
	transition: width .2s, min-width .2s, opacity .2s;
}
:host ion-buttons ion-button[slot="icon-only"]::part(native) {
	width: 3rem;
	height: 3rem;
}
:host ion-buttons[slot="end"] ion-button.hide {
	width: 0;
	min-width: 0;
	opacity: 0;
	overflow: hidden;
	pointer-events: none;
}'
]

{ #category : #'instance creation' }
CpCanyonAppPage class >> withModel: aModel [

	"Answer a new instance of the receiver with the specified Model.
	Only some subclasses support Models. If a Model is provided while
	not supported it will fail (which is expected)."

	| instance |

	instance := self new.
	aModel ifNotNil: [
		instance model: aModel ].

	^ instance
]

{ #category : #accessing }
CpCanyonAppPage >> app [

	"Convenience method to access the app (instance) which is represented by the main view"

	^ CpCanyonAppMainView current
]

{ #category : #testing }
CpCanyonAppPage >> canNavigate [

	"Answer whether the receiver allows navigating elsewhere.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	^ true
]

{ #category : #testing }
CpCanyonAppPage >> canNavigateBack [

	"Answer whether the receiver allows navigating back.
	It is adviced to show the user a message when navigation is not possible.
	This can be an alert or a toast, accessible through the #app accessor.
	This method is only called when the user herself tries to navigate."

	self firstChild ifNotNil: [ :firstChild |
		^ firstChild canNavigateBack ].

	^ true
]

{ #category : #'event handling' }
CpCanyonAppPage >> handleNavigateBack: aClickEvent [

	"Handle the 'back' button click"

	"Prevent default handling"
	aClickEvent
		stopPropagation ;
		preventDefault.

	self app navigateBack
]

{ #category : #accessing }
CpCanyonAppPage >> hasModel [

	"Answer whether a model is present in the receiver"

	^ self model isNotNil
]

{ #category : #view }
CpCanyonAppPage >> hideButton: aString if: aBoolean [

	(self shadowedElementWithId: aString)
		classed: #hide if: aBoolean
]

{ #category : #initialization }
CpCanyonAppPage >> initialize [

	super initialize.

	self classed: #public if: self isPublic
]

{ #category : #initialization }
CpCanyonAppPage >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedAllDescendantsMatching: IonBackButton asCssSelector) do: [ :each |
		each when: CpClickEvent forkedSend: #handleNavigateBack: to: self ].

	self restoreButtonLabels
]

{ #category : #testing }
CpCanyonAppPage >> isHome [

	"Answer whether the receiver is the home page (should be true for one page)"

	^ self class isHome
]

{ #category : #testing }
CpCanyonAppPage >> isPage [

	^ true
]

{ #category : #testing }
CpCanyonAppPage >> isPublic [

	"Answer whether the receiver is a public page (i.e. does not require an authenticated user)"

	^ self class isPublic
]

{ #category : #testing }
CpCanyonAppPage >> isWidePreferred [

	"Answer whether the receiver is preferrably shown on a wide screen.
	By default all pages are shown wide in the receiver."

	^ true
]

{ #category : #accessing }
CpCanyonAppPage >> model [

	"Answer the model of the receiver (or nil if none is present).

	Implementation:
	It is assumed the receiver has a single child view containing the actual model.
	This child view is typically a CpPropertyModelView or subclass."

	^ self firstChild
		ifNotNil: [ :firstChild | firstChild model ]
]

{ #category : #accessing }
CpCanyonAppPage >> model: aModel [

	"Replace the receiver's child view with a new ModelView on the specified model"

	| childView |

	"Remove the model from the existing child view"
	self firstChild ifNotNil: [ :firstChild |
		firstChild model: nil ].

	"Create a child view and replace the previous child in the receiver"
	childView := self viewForModel: aModel.
	self replaceAllChildrenWith: childView.

	childView initializeInPage
]

{ #category : #actions }
CpCanyonAppPage >> navigateBack [

	"Navigate to the previous page"

	self canNavigateBack
		ifFalse: [ ^ self ].

	"Ignore on the home page (safety measure)"
	self isHome
		ifTrue: [ ^ self ].

	self app closePage
]

{ #category : #actions }
CpCanyonAppPage >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page"

	self canNavigate
		ifFalse: [ ^ self ].

	self app
		showPage: aPageClass withModel: aModel
]

{ #category : #accessing }
CpCanyonAppPage >> previousPage [

	"Answer the page before the receiver (if any)"

	^ self previousSibling
]

{ #category : #view }
CpCanyonAppPage >> restoreButtonLabels [

	"Restore the button labels (see #setButton:label:)"

	(self shadowedAllDescendantsMatching: IonButton asCssSelector) do: [ :each |
		(self attributeAt: 'button-', each id) ifNotNil: [ :label |
self traceCr: 'Restore label ', label.
			each textContent: label ] ]
]

{ #category : #accessing }
CpCanyonAppPage >> screenWidth [

	"Answer the screen width setting (as stored in a persistent variable)
	or use default #auto (alternatives are #min and #max)"

	^ (CpClientEnvironment current
			persistentVariableAt: #SCREEN_WIDTH)
				ifNil: [ #auto ]
]

{ #category : #view }
CpCanyonAppPage >> setButton: idString label: labelString [

	(self shadowedElementWithId: idString)
		textContent: labelString.

	"Store the label in the host so it survives updates"
	self attributeAt: 'button-', idString put: labelString
]

{ #category : #accessing }
CpCanyonAppPage >> title [

	"Answer the title for the receiver.
	This is a convenience method allowing the browser title to be set (when app is running as webapp)
	or for example setting the app header title.

	See also current implementation of #updateAfterNavigate"

	^ self firstChild
		ifNotNil: [ :firstChild | firstChild title ]
]

{ #category : #actions }
CpCanyonAppPage >> updateAfterNavigate [

	"Update the receiver when being shown again after a navigation"
self traceCr: 'Update after in ', self printString.
	"Let the PropertyModelView update itself (if present)"
	self firstChild
		ifNotNil: [ :firstChild | firstChild updateAfterNavigate ]
]

{ #category : #actions }
CpCanyonAppPage >> updateBeforeNavigate [

	"Update the receiver just before being shown again because of a navigation"
self traceCr: 'Update before in ', self printString.
	self updateScreenWidth.

	self title ifNotNil: [ :title |
		self updateTitle: title ].

	"Let the PropertyModelView update itself (if present)"
	self firstChild
		ifNotNil: [ :firstChild | firstChild updateBeforeNavigate ]
]

{ #category : #view }
CpCanyonAppPage >> updateScreenWidth [

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

{ #category : #accessing }
CpCanyonAppPage >> updateTitle: aString [

	"Update the title of the receiver"

	"Set the title in the <ion-title> of the <ion-header>, if available and not marked 'readonly'"
	(self shadowedFirstDescendantMatching: IonHeader asCssSelector) ifNotNil: [ :header |
		(header firstDescendantMatching: IonTitle asCssSelector) ifNotNil: [ :title |

			"Only set the title if it is not marked 'readonly'"
			(title isClassed: #readonly)
				ifFalse: [ title textContent: aString ] ] ].

	"Set the title of the page as the browser title (for desktop)"
	CpBrowserDocument current
		title: aString
]

{ #category : #accessing }
CpCanyonAppPage >> viewClassForModel: aModel [

	"Answer a the preferred View class for the specified Model"

	^ aModel preferredViewClass
]

{ #category : #accessing }
CpCanyonAppPage >> viewForModel: aModel [

	"Answer a new View instance for (and on) the specified Model"

	^ (self viewClassForModel: aModel) on: aModel
]
