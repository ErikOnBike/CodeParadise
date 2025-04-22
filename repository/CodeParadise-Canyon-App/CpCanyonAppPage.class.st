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
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #accessing }
CpCanyonAppPage class >> app [

	"Convenience method to access the app (instance)"

	^ CpCanyonAppMainView current
]

{ #category : #'web resources' }
CpCanyonAppPage class >> globalStyle [

	<webResource: #css>

	^ 'ion-nav > * {
	overflow-y: scroll;
}'
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
	background-color: var(--ion-background-color);
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

	^ true
]

{ #category : #initialization }
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

{ #category : #'as yet unclassified' }
CpCanyonAppPage >> hideButton: aString if: aBoolean [

	(self shadowedElementWithId: aString)
		classed: #hide if: aBoolean
]

{ #category : #testing }
CpCanyonAppPage >> initialize [

	super initialize.

	self classed: #public if: self isPublic
]

{ #category : #initialization }
CpCanyonAppPage >> initializeShadowRoot [

	super initializeShadowRoot.

	(self shadowedAllDescendantsMatching: IonBackButton asCssSelector) do: [ :each |
		each when: CpClickEvent forkedSend: #handleNavigateBack: to: self ]
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

	self replaceAllChildrenWith: (childView := aModel inModelView).

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

	self updateTitle: self title.

	"Let the PropertyModelView update itself (if present)"
	self firstChild
		ifNotNil: [ :firstChild | firstChild updateAfterNavigate ]
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
