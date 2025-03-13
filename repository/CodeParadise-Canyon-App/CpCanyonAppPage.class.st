"
I represent a Page in the Canyon app.
I am responsible for navigation (to another page or back) and deciding if navigation is possible.

"
Class {
	#name : #CpCanyonAppPage,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

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

	^ '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");'
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

	"Answer whether the receiver allows navigating elsewhere"

	^ true
]

{ #category : #testing }
CpCanyonAppPage >> canNavigateBack [

	"Answer whether the receiver allows navigating back"

	^ true
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

	^ nil
]

{ #category : #'event handling' }
CpCanyonAppPage >> updateAfterNavigate [

	"Update the receiver when being shown again after a navigation"

	"Set the title of the page as the browser title"
	CpBrowserDocument current title: self title
]
