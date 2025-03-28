"
I represent a Page in the Canyon app.
I am responsible for navigation (to another page or back) and deciding if navigation is possible.
My instances can be bound to a Model to allow a user to interact with it. Typically this is
done in collaboration with a CpPropertyModelView.
When bound, the Model in my instances might need to show non-public information. Therefore my
instances need to be defined explicitly for public use. By default they assume an authenticated
user is required. Making a Page public is done by adding a placeholder method/tag #isPublicTag
(see also method #isPublic).
Since it is common to want to show some additional Page before going to the Page a user requested,
my instances can keep track of this 'required next page'. An example for this feature is the
situation a user goes to an authenticated page and a login page needs to be shown first, because
the user has not authenticated yet. Alternative for this situation is to show the login as an
overlay onto an existing page, instead of a separate page.
My instances can only keep track of a single required page. More elaborate mechanisms need to
be added in a subclass or extension. In such a case (for example a set of pages representing a
wizard like component) also consider having a single page which has tabs to represent the pages.

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

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");
*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	background-color: var(--ion-background-color);
}
#container {
	height: 100%;
}'
]

{ #category : #'web resources' }
CpCanyonAppPage class >> template [

	<webResource: #html>

	^ '<div id="container"><slot></slot></div>'
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

{ #category : #accessing }
CpCanyonAppPage >> hasModel [

	"Answer whether a model is present in the receiver"

	^ self model isNotNil
]

{ #category : #testing }
CpCanyonAppPage >> initialize [

	super initialize.

	self classed: #public if: self isPublic
]

{ #category : #testing }
CpCanyonAppPage >> isHome [

	"Answer whether the receiver is the home page (should be true for one page)"

	^ self class isHome
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

	"Remove the model from the existing child view"
	self firstChild ifNotNil: [ :firstChild |
		firstChild model: nil ].

	self replaceAllChildrenWith: aModel inModelView
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

	"Set the title of the page as the browser title"
	CpBrowserDocument current title: self title.

	"Let the PropertyModelView update itself (if present)"
	self firstChild
		ifNotNil: [ :firstChild | firstChild updateAfterNavigate ]
]
