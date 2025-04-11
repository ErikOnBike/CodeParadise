"
I am the Canyon app main view. I also represent the app's main access point and will therefore be
referenced (e.g. from a CpCanyonPage) as the 'app'.
I am responsible for maintaining a number of visual components:
- header
- footer
- menu
- alert
- toast
- loading (showing a message while performing some operation)
- pages
I am also responsible for navigation, although I delegate most behavior to my pages. Navigation from
or to a page might not be acceptable and therefore the page itself should be responsible. For example
there might be unsaved changes in page or the user needs to login first.

There is typically a session active when using the REST API Client. This session is not monitored
in the app itself. In many cases there is no way to alert the user of an expiring session, because
the app does not have focus (and it is very rude to ask foccus just because a session is expiring
while the user is doing more important things). So session expiration is normally only noticed when
performing some read or write operation on the REST API Client.

As mentioned above, I represent the app's access point and therefore represent the app instance.
I keep track of the current instance to allow a single app to be accessed easily and fast
(and not requiring every page to know its app explicitly, for example).

For a nice tag in the browser, my subclasses could be named sonething like TheSpecialAppView
resulting in the tag <the-special-app> which also describes my 'app' role.

"
Class {
	#name : #CpCanyonAppMainView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'navigation',
		'menu',
		'header',
		'footer',
		'actionSheet',
		'loading',
		'toast',
		'alert'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'class initialization' }
CpCanyonAppMainView class >> beLoaded [

	"Alphabetically ordered references to the required classes.
	(This is not a complete list, other classes are referenced in the code directly)"

	CpBrowserCustomElementRegistry beLoaded.
	IonInput beLoaded.
	IonInputPasswordToggle beLoaded.
	IonList beLoaded.
	IonMenuButton beLoaded.
	IonSearchbar beLoaded.
	IonSelect beLoaded.
	IonSelectOption beLoaded.
	IonTab beLoaded.
	IonTabBar beLoaded.
	IonTabs beLoaded.
	IonTextarea beLoaded.
	IonToggle beLoaded
]

{ #category : #accessing }
CpCanyonAppMainView class >> current [

	"Answer the singleton instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #'accessing - text' }
CpCanyonAppMainView class >> defaultAppTexts [

	"Answer Dictionary with default app texts"

	^ Dictionary new
		at: #'app.menu.title' put: 'Menu' ;
		at: #'constraint.multi.violations' put: 'I''m sorry I don''t understand your input:' ;
		yourself
]

{ #category : #'accessing - text' }
CpCanyonAppMainView class >> defaultFallbackLocales [

	"Answer the collection of fallback locales for the app.
	By default there are no fallback locales specified."

	^ #()
]

{ #category : #'accessing - text' }
CpCanyonAppMainView class >> defaultLanguage [
	"Answer the app's text language"

	^ CpTextLanguage
		  locale: self defaultLocale
		  fallbackLocales: self defaultFallbackLocales
]

{ #category : #'accessing - text' }
CpCanyonAppMainView class >> defaultLocale [

	"Answer the default language locale.
	By default the English language (with no explicit region specified) is answered."

	^ #en
]

{ #category : #'web resources' }
CpCanyonAppMainView class >> globalStyle [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
html {
	width: 100%;
	height: 100%;
}
body {
	width: 100%;
	max-width: 100%;
	height: 100%;
	max-height: 100%;
	transform: translateZ(0);
	margin: 0;
	padding: 0;
	overflow: hidden;
	overscroll-behavior-y: none;
	-webkit-font-smoothing: antialiased;
	text-rendering: optimizeLegibility;
	text-size-adjust: none;
	-webkit-text-size-adjust: none;
	-moz-text-size-adjust: none;
	touch-action: manipulation;
	-webkit-user-drag: none;
	-ms-content-zooming: none;
	word-wrap: break-word;
}'
]

{ #category : #tags }
CpCanyonAppMainView class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'instance creation' }
CpCanyonAppMainView class >> new [

	self errorNewReplacedBy: #current
]

{ #category : #'class initialization' }
CpCanyonAppMainView class >> postInstall [

	"Install the receiver in the browser.

	Implementation:
	Make sure to mark all subclasses using #isAbstractTag if the actual MainView
	is not a direct subclass of the receiver."

	super postInstall.

	self hasAbstractTag
		ifTrue: [ ^ self ].

	"Install an instance of the receiver"
	CpHtmlElement documentBody
		appendChild: (self current
			load ;
			yourself)
]

{ #category : #'web resources' }
CpCanyonAppMainView class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	height: 100%;
}'
]

{ #category : #accessing }
CpCanyonAppMainView >> apiBaseUrl [

	"Answer the base URL for the REST API"

	^ '/api'
]

{ #category : #testing }
CpCanyonAppMainView >> canNavigateBack [

	"Answer a Boolean stating whether navigate back is allowed"

	^ self currentPage canNavigateBack
]

{ #category : #actions }
CpCanyonAppMainView >> closePage [

	"Close the current page"

	"Do not close the home page"
	self isHome
		ifTrue: [ ^ self ].

	"Remove current page and update the new current page"
	navigation pop await.
	self updateAfterNavigate
]

{ #category : #accessing }
CpCanyonAppMainView >> currentPage [

	"Answer the current page.

	During navigation, there is a transition which might make this value unreliable (at that moment)."

	^ navigation lastChild
]

{ #category : #accessing }
CpCanyonAppMainView >> defaultToastDuration [

	"The default duration in ms that a toast is shown"

	^ 3000
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleDidDismissActionSheet [

	"This is an async call, but no use awaiting it, because we're not using the result"

	actionSheet isOpen: false
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleDidDismissAlert [

	"This is an async call, but no use awaiting it, because we're not using the result"

	alert isOpen: false
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleDidDismissLoading [

	"This is an async call, but no use awaiting it, because we're not using the result"

	loading isOpen: false
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleDidDismissToast [

	"This is an async call, but no use awaiting it, because we're not using the result"

	toast isOpen: false
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleOffline [

	"The netwerk is no longer available"

	self addClass: #offline
]

{ #category : #'event handling' }
CpCanyonAppMainView >> handleOnline [

	"The netwerk became available (not necessarily actual internet connection)"

	self removeClass: #offline
]

{ #category : #actions }
CpCanyonAppMainView >> hideLoading [

	loading dismiss await
]

{ #category : #accessing }
CpCanyonAppMainView >> homePageClass [

	"Answer the page class representing the initial/home page for the app"

	self subclassResponsibility
]

{ #category : #accessing }
CpCanyonAppMainView >> homePageModel [

	"Answer the model representing the initial/home page model for the app.
	If a model is not required, answer nil."

	^ nil
]

{ #category : #initialization }
CpCanyonAppMainView >> initialize [

	| restApiClient |

	super initialize.

	"Initialize the language text before anything else"
	self initializeLanguageText.

	"Setup handlers for detecting going online/offline"
	CpBrowserWindow current
		addEventListener: #online handler: [ self handleOnline ] ;
		addEventListener: #offline handler: [ self handleOffline ].

	"Create the REST API client"
	restApiClient := CpRestApiClient baseUrl: self apiBaseUrl.
	restApiClient
		when: CpSessionExpired send: #sessionExpired to: self.

	"Attach the REST API Client to the models"
	CpPropertyEntity restApiClient: restApiClient
]

{ #category : #initialization }
CpCanyonAppMainView >> initializeLanguageText [

	"Initialize the language text by setting the default language, locale and fallback locales"

	CpPropertyEntity
		languageText: (CpMultiLanguageText defaultLanguage: self class defaultLanguage) ;
		addVolume: (CpLanguageVolume fromDictionary: self class defaultAppTexts) locale: self class defaultLocale
]

{ #category : #testing }
CpCanyonAppMainView >> isHome [

	"Answer whether the Home page is showing.

	Implementation:
	If no page is present (yet), assume the home page will be shown."

	^ self currentPage
		ifNotNil: [ :currentPage | currentPage isHome ]
		ifNil: [ true ]
]

{ #category : #testing }
CpCanyonAppMainView >> isOnline [

	"Answer whether an Internet connection is available.
	Do NOT call this method too often, since it needs to ping the server.

	Implementation:
	Some browsers recognize a LAN connection as being online, but it does not mean
	an actual connection with the Internet is available. Being 'offline' means there
	is no LAN and therefore no Internet connection. In other cases a 'ping' is done
	to ensure there is in fact a working internet connection."

	| response |

	(self isClassed: #offline)
		ifTrue: [ ^ false ].

	CpBrowserNavigator current onLine
		ifFalse: [ ^ false ].

	response := [
		CpPropertyEntity restApiClient
			getUri: '/ping/hello' timeoutPeriod: 2000
	] on: Error do: [ :err | ^ false ].

	^ response = 'world'
]

{ #category : #initialization }
CpCanyonAppMainView >> load [

	"Load the app and its content"

	"Make sure the most prominent components are loaded, before loading the app content"
	CpWebComponent
		whenDefinedAll: {
			IonApp.
			IonNav.
			IonHeader.
			IonFooter.
			IonMenu.
			IonToolbar.
			IonTitle.
			IonContent.
			IonItem.
			IonLoading.
			IonToast.
			IonAlert.
			IonButton }
		do: [ self loadApp ]
]

{ #category : #initialization }
CpCanyonAppMainView >> loadApp [

	"Build the app structure. The app structure lives in the Light DOM and will
	be subject to Light DOM CSS.

	The general structure of the app consists of:
		navigation
		menu
		header
		placeholder for page content
		footer
		loading (for showing a message while performing some task)
		toast
		alert

	The order is relevant. Toast and alert should be last, because they should
	overlay the other elements (visually). The alert is considered the most
	important and is therefore added last.

	The structure is chosen so that navigation is on page level and header and
	footer are separate components (so not every page has to implement it).
	IF your app requires different headers/footers per page or does not require
	headers/footers on all pages, consider leaving the app header/footer empty
	and simply add headers/footers to the individual pages. Alternative is to
	hide the header/footer if the (current) page should be without them. This
	should probably be done from the page navigation and not from the
	#updateAfterNavigate operation, because that would be too late and would
	make the update more visible (after any animations have been performed).

	It is not necessary to have actual content in the header or footer. They
	will collapse (and be invisible) if no content is provided. The content for
	the header and footer should be created in #loadHeader and #loadFooter.
	Similarly content for the menu should be constructed in #loadMenu. To be
	able to use the menu typically a IonMenuButton / <ion-menu-button> should
	be placed visible on the page (in the header for example) or some code
	should explicitly open the menu based on the user input/action."

	"Create the visual app structure"
	self
		appendChild: (IonApp new

			"Add the menu"
			appendChild: (menu := IonMenu new
				attributeAt: #side put: self menuSide ;
				attributeAt: #'content-id' put: #app ;
				appendChild: (IonHeader new
					appendChild: (IonToolbar new
						appendChild: (IonTitle new
							textContent: self menuTitle ;
							yourself) ;
						yourself) ;
					yourself) ;
				yourself) ;

			"Add the page header (content added through loadHeader)"
			appendChild: (header := IonHeader new) ;

			"Add the page content (placeholder, including navigation control)"
			appendChild: (IonContent new
				id: #app ;
				appendChild: (navigation := IonNav new) ;
				yourself) ;

			"Add the page footer (content added through loadFooter)"
			appendChild: (footer := IonFooter new) ;

			"Add a (global) action sheet"
			appendChild: (actionSheet := IonActionSheet new
				when: IonActionSheetDidDismissEvent send: #handleDidDismissActionSheet to: self ;
				yourself) ;

			"Add a (global) loading"
			appendChild: (loading := IonLoading new
				when: IonLoadingDidDismissEvent send: #handleDidDismissLoading to: self ;
				yourself) ;

			"Add a (global) toast"
			appendChild: (toast := IonToast new
				attributeAt: #position put: #bottom ;
				attributeAt: #'swipe-gesture' put: #vertical ;
				when: IonToastDidDismissEvent send: #handleDidDismissToast to: self ;
				yourself) ;

			"Add a (global) alert"
			appendChild: (alert := IonAlert new
				when: IonAlertDidDismissEvent send: #handleDidDismissAlert to: self ;
				yourself) ;

			yourself).

	"Load the content for the menu, header and footer"
	self
		loadMenu ;
		loadHeader ;
		loadFooter.

	"Load the first page (aka home page)"
	self showPage: self homePageClass withModel: self homePageModel.

	"Load any content required for the app"
	self loadInitialContent
]

{ #category : #initialization }
CpCanyonAppMainView >> loadFooter [

	"Load the footer (content) for the app.
	If no footer is used, leave the method empty.
	The footer can be used to show some status information or to have
	some navigation/selection mechanism. For larger 'tabs' consider
	using the IonTabs / <ion-tabs> on the page level instead.
	See also: https://ionicframework.com/docs/api/tabs
	Typically one or more IonToolbars are used as footer content.
	IF the header has specific content based on the current page being
	shown, add some update call to #updateAfterNavigate."
]

{ #category : #initialization }
CpCanyonAppMainView >> loadHeader [

	"Load the header (content) for the app.
	If no header is used, leave the method empty.
	The header can be used to show some title or action at the top of the
	app screen. It can also contain a menu button or some 'navigate back'
	button. Add the required components to the header instance variable.
	Typically one or more IonToolbars are used as header content.
	IF the header has specific content based on the current page being
	shown, add some update call to #updateAfterNavigate."
]

{ #category : #initialization }
CpCanyonAppMainView >> loadInitialContent [

	"Load the initial app content.
	This can also include restoring the session (e.g. using (persisted) variables
	from the client environment)."
]

{ #category : #initialization }
CpCanyonAppMainView >> loadMenu [

	"Load the menu for the app.
	Typically this will add an instance of the IonContent to the menu
	instance variable. How the menu is represented and how it interacts
	is up to the subclass to decide."
]

{ #category : #actions }
CpCanyonAppMainView >> menuClose [

	"Close the menu (do not await the closing)"

	menu close
]

{ #category : #accessing }
CpCanyonAppMainView >> menuSide [

	"Answer the side where the menu is shown (either #start or #end)"

	^ #start
]

{ #category : #accessing }
CpCanyonAppMainView >> menuTitle [

	"Answer the title of the menu (from the language resource)"

	^ CpPropertyEntity text: #'app.menu.title'
]

{ #category : #actions }
CpCanyonAppMainView >> navigateBack [

	"Navigate to previous page.

	Let the current page handle this, since it might fail or require
	user input first (when data is not saved yet)."

	self currentPage navigateBack
]

{ #category : #actions }
CpCanyonAppMainView >> navigateTo: aPageClass [

	"Navigate to another page"

	self navigateTo: aPageClass withModel: nil
]

{ #category : #actions }
CpCanyonAppMainView >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page using the (optional) specified Model.
	The current page is responsible for deciding whether navigation
	is possible. There might be unsaved changes for example.
	Or the user needs to login first."

	self currentPage navigateTo: aPageClass withModel: aModel
]

{ #category : #accessing }
CpCanyonAppMainView >> pageCount [

	"Answer the number of pages in the navigation stack.

	During navigation, there is a transition which might make this value unreliable (at that moment)."

	^ navigation children size
]

{ #category : #actions }
CpCanyonAppMainView >> selectAction: aString from: aCollection [

	"Show the receiver's ActionSheet and answer the action selected.
	The answered value is a Dictionary with #data and #role. The field
	#data contains the data of the selected ActionSheetButton (see below).
	Idem for the #role field, unless the ActionSheet is cancelled in which
	case it receives the role 'cancel'.

	Actions are specified using the ActionSheetButton interface:
		```
		interface ActionSheetButton<T = any> {
		  text?: string;
		  role?: 'cancel' | 'destructive' | 'selected' | string;
		  icon?: string;
		  cssClass?: string | string[];
		  id?: string;
		  htmlAttributes?: { [key: string]: any };
		  handler?: () => boolean | void | Promise<boolean | void>;
		  data?: T;
		}
		```

	See also:
		https://ionicframework.com/docs/api/action-sheet#actionsheetbutton
	"

	^ (actionSheet
		header: aString ;
		buttons: aCollection asRelaxedJsonObjectValue ;
		present ;
		onDidDismiss) await
]

{ #category : #'event handling' }
CpCanyonAppMainView >> sessionExpired [

	"The session expired.
	See also class comment with respect to session expiration."

]

{ #category : #actions }
CpCanyonAppMainView >> showAlertTitle: titleString message: messageString [

	"Show alert message and wait for user to confirm it"

	(alert
		header: titleString ;
		message: messageString ;
		buttons: { 'Okay' } ;
		present ;
		onDidDismiss) await
]

{ #category : #actions }
CpCanyonAppMainView >> showLoading: aString [

	"Show a loading message.

	Implementation:
	Do NOT perform an #await here to prevent any delay."

	loading
		message: aString ;
		present
]

{ #category : #actions }
CpCanyonAppMainView >> showModal: aViewClass [

	"Show the specified View modal.
	Evaluate the specified Block with the result from the View."

	^ self showModal: aViewClass withModel: nil
]

{ #category : #actions }
CpCanyonAppMainView >> showModal: aViewClass withModel: aModel [

	"Show the specified View modal with the (optional) Model"

	| modal view result |

	"Create modal View"
	modal := IonModal new
		component: (view := aViewClass on: aModel) ;
		yourself.

	"Let the view assign dismiss events (after it had time to fully initialize)"
	view makeDismissableIn: modal.

	"Let the view update itself"
	view updateAfterNavigate.

	"Present the modal View"
	self appendChild: modal.
	modal present.

	"Wait for it to close"
	result := modal onWillDismiss await.

	"Answer data on confirm (role), otherwise nil.
	If no data is present on confirm, answer 'true'."
	result at: #role ifPresent: [ :role |
		role = #confirm
			ifTrue: [ ^ result at: #data ifAbsent: [ true ] ] ].

	^ nil
]

{ #category : #actions }
CpCanyonAppMainView >> showPage: aPageClass [

	"Show the specified Page"

	self showPage: aPageClass withModel: nil
]

{ #category : #actions }
CpCanyonAppMainView >> showPage: aPageClass withModel: aModel [

	"Show the specified Page with the (optional) Model.
	It is assumed, that all checks have already been performed with respect to navigation."

	(aPageClass isHome and: [ self pageCount > 0 ])
		ifTrue: [ navigation popToRoot await ]
		ifFalse: [ (navigation push: (aPageClass withModel: aModel)) await ].

	"Let the current page update itself"
	self updateAfterNavigate
]

{ #category : #actions }
CpCanyonAppMainView >> showToast: aString [

	"Show the specified toast message with the default duration"

	self showToast: aString duration: self defaultToastDuration
]

{ #category : #actions }
CpCanyonAppMainView >> showToast: aString duration: anInteger [

	"Show the specified toast message and dismiss after the specified time (milliseconds).

	Implementation:
	Do NOT perform an #await here to prevent any delay."

	toast
		message: aString ;
		duration: anInteger ;
		present
]

{ #category : #actions }
CpCanyonAppMainView >> updateAfterNavigate [

	"Update the current page after navigation has taken place.
	Subclasses might also want to update the header, footer or menu if
	this is relevant."

	self currentPage updateAfterNavigate
]
