"
I am the Canyon App. I represent the app's main access point and will therefore be referenced
(e.g. from a CynModelView) as the 'app'. I am also the main view in the application (that is,
I'm a WebComponent).
I am responsible for maintaining a number of visual components:
- menu
- pages (through a navigation component)
- loading (showing a message while performing some operation)
- toast (showing a temporary message/notification)
- alert (showing a message requiring confirmation)
- select action (showing a list of actions to choose from)
- select options (showing a list of options to choose from)
- select input (showing a list of input entries to fill in)
I am responsible for navigation, although I delegate most behavior to my pages. Navigation from
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

For a nice tag in the browser, my subclasses could be named something like SpecialApp
resulting in the tag <special-app> which also describes my 'app' role. The prefix-less name
should probably be okay for this Class (you want a unique app name in any case ;-).
"
Class {
	#name : #CynApp,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'main',
		'navigation',
		'menu'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'class initialization' }
CynApp class >> beLoaded [

	"Alphabetically ordered references to the required classes.
	(This is not a complete list, other classes are referenced in the code directly)"

	CpBrowserCustomElementRegistry beLoaded.
	IonButton beLoaded.
	IonButtons beLoaded.
	IonInput beLoaded.
	IonInputPasswordToggle beLoaded.
	IonItem beLoaded.
	IonList beLoaded.
	IonMenuButton beLoaded.
	IonModal beLoaded.
	IonSearchbar beLoaded.
	IonSelect beLoaded.
	IonSelectOption beLoaded.
	IonTab beLoaded.
	IonTabBar beLoaded.
	IonTabs beLoaded.
	IonTextarea beLoaded.
	IonToggle beLoaded.
	IonToolbar beLoaded
]

{ #category : #'accessing - text' }
CynApp class >> constraintTexts [

	"Answer Dictionary with constraint texts"

	<languageResource>

	^ Dictionary new
		at: #'constraint.empty' put: 'Input should not be empty.' ;
		at: #'constraint.required' put: 'Input is required to operate correctly.' ;
		at: #'constraint.email.at' put: 'An email address should match the pattern "name@domain.org".' ;
		at: #'constraint.email.format' put: 'An email address should contain exactly one @-symbol (like "name@domain.org").' ;
		at: #'constraint.email.name' put: 'The name before the @-symbol only allows letters, digits and the following symbols: {1}' ;
		at: #'constraint.email.domain' put: 'The domain name after the @-symbol only allows letters, digits, dots and dashes.' ;
		at: #'constraint.email.domain.dot.missing' put: 'The domain name after the @-symbol should have at least 1 dot (like "name@domain.org").' ;
		at: #'constraint.email.domain.dot.position' put: 'An email address should only have dots between the domain name parts (like "name@first.domain.org").' ;
		at: #'constraint.email.domain.dash' put: 'An email address should only have dashes inside domain name parts (like "name@first-domain.org").' ;
		at: #'constraint.password.length' put: 'The password should be at least {1} characters long.' ;
		at: #'constraint.id.length' put: 'The id should be exactly 36 characters long (formatted xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)' ;
		at: #'constraint.id.dash' put: 'The id should contain dashes at fixed locations (formatted xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)' ;
		at: #'constraint.id.content' put: 'The id should only contain digits, the letters "a" until "f" and dashes (formatted xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)' ;
		at: #'constraint.token.length' put: 'The code should be exactly 32 characters long. Maybe it is not copied correctly from the mail?' ;
		at: #'constraint.token.content' put: 'The code should only contain digits and the letters "a" until "f". Maybe it is not copied correctly from the mail?' ;
		at: #'constraint.length.min' put: 'The input should be at least {1} characters long and is only {2} characters long.' ;
		at: #'constraint.length.min.zero' put: 'The input should be at least {1} characters long and is currently still empty.' ;
		at: #'constraint.length.max' put: 'The input should have at most {1} characters and is {2} characters long.' ;
		at: #'constraint.selection.unknown' put: 'The value "{1}" is not allowed.' ;
		yourself
]

{ #category : #accessing }
CynApp class >> current [

	"Answer the singleton instance of the receiver"

	^ Current ifNil: [ Current := self basicNew initialize ; yourself ]
]

{ #category : #'accessing - text' }
CynApp class >> defaultAppTexts [

	"Answer Dictionary with default app texts"

	<languageResource>

	^ Dictionary new
		at: #'app.ok' put: 'OK' ;
		at: #'app.cancel' put: 'Cancel' ;
		at: #'app.today' put: 'today' ;
		at: #'app.yesterday' put: 'yesterday' ;
		at: #'app.tomorrow' put: 'tomorrow' ;
		at: #'app.date' put: '{month}/{day}/{year}' ;
		at: #'app.month' put: {
			1 -> 'January'.
			2 -> 'February'.
			3 -> 'March'.
			4 -> 'April'.
			5 -> 'May'.
			6 -> 'June'.
			7 -> 'July'.
			8 -> 'August'.
			9 -> 'September'.
			10 -> 'October'.
			11 -> 'November'.
			12 -> 'December' } asDictionary ;
		at: #'app.server.internalError.title' put: 'Oops, something went wrong' ;
		at: #'app.server.internalError.message' put: 'The computer where the entry is stored, is not working correctly. The maintainer is informed. You could try it again shortly, just in case. We''ll try to fix this as soon as possible.' ;
		at: #'app.server.unavailable.title' put: 'Oops, something went wrong' ;
		at: #'app.server.unavailable.message' put: 'The computer where the data is stored, is not available at the moment. It should quickly be up again. Please try again in a minute.' ;
		at: #'app.server.forbidden.title' put: 'Oops, something went wrong' ;
		at: #'app.server.forbidden.message' put: 'The computer where the data is stored, says you''re not allowed to use or update the entry. The maintainer is informed. We''ll try to fix this as soon as possible.' ;
		at: #'app.menu.title' put: 'Menu' ;
		at: #'app.label.account.email' put: 'E-mail' ;
		at: #'app.label.account.password' put: 'Password' ;
		at: #'app.label.account.token' put: 'Code' ;
		at: #'app.selection.loginAccount.expires.usage' put: 'After usage' ;
		at: #'app.selection.loginAccount.expires.day' put: 'The next day' ;
		at: #'app.selection.loginAccount.expires.never' put: 'Never' ;
		at: #'app.loading.generic.new' put: 'Creating new entry...' ;
		at: #'app.loading.generic.update' put: 'Storing changes...' ;
		at: #'app.loading.generic.delete' put: 'Removing entry...' ;
		at: #'app.loading.generic.read' put: 'Reading entry...' ;
		at: #'app.loading.generic.operation' put: 'Performing operation...' ;
		yourself
]

{ #category : #'accessing - text' }
CynApp class >> defaultFallbackLocales [

	"Answer the collection of fallback locales for the app.
	By default there are no fallback locales specified."

	^ #()
]

{ #category : #'accessing - text' }
CynApp class >> defaultLanguage [
	"Answer the app's text language"

	^ CynTextLanguage
		  locale: self defaultLocale
		  fallbackLocales: self defaultFallbackLocales
]

{ #category : #'accessing - text' }
CynApp class >> defaultLocale [

	"Answer the default language locale.
	By default the English language (with no explicit region specified) is answered."

	^ #en
]

{ #category : #'web resources' }
CynApp class >> globalStyle [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
html {
	width: 100%;
	height: 100%;
}
#app {
	height: 100%;
}'
]

{ #category : #testing }
CynApp class >> ifDevelopment: aBlock [

	"Evaluate the specified Block during development"

	(CpClientEnvironment current variableAt: #'CANYON_ENV') = 'dev'
		ifTrue: [ aBlock value ]
]

{ #category : #tags }
CynApp class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'instance creation' }
CynApp class >> new [

	self errorNewReplacedBy: #current
]

{ #category : #'class initialization' }
CynApp class >> postInstall [

	"Install the receiver in the browser.

	Implementation:
	The last MainView class installed will become the registered main view.
	Do not add any subclasses to your MainView (or prevent they get loaded)
	to prevent these from becoming the actual main view."

	super postInstall.

	self hasAbstractTag
		ifTrue: [ ^ self ].

	"Install a named reference to the main view"
	CpClientEnvironment current objectRegistry
		registerObject: self withId: CynApp name
]

{ #category : #'class initialization' }
CynApp class >> postInstallOnce [

	"Reset the default behavior to prevent the context menu.
	This is not relevant for mobile apps where a context menu
	is not present.
	Also replace the default handling of unhandled errors and
	let the receiver be responsible for handling these errors."

	CpSecondaryClickEvent resetDefaultContextMenu.

	"Little hackery to install different #unhandledError: method"
	Process methodDictionary ifNotNil: [ :methodDictionary |
		(methodDictionary includesKey: #specialHandleError:)
			ifTrue: [
				methodDictionary
					at: #handleError: put: (methodDictionary at: #specialHandleError:).

				"Flush the #handleError: method just in case (should not have been called yet ;-)"
				#handleError: flushCache ] ]
]

{ #category : #'class initialization' }
CynApp class >> postSnapshotOnce [

	| appClass |

	appClass := CpClientEnvironment current objectRegistry
		objectWithId: CynApp name.

	self traceCr: 'Starting up ', appClass printString.

	appClass
		ifNotNil: [ appClass start ]
		ifNil: [ self errorCr: 'No app registered!' ]
]

{ #category : #'class initialization' }
CynApp class >> preSnapshotOnce [

	self traceCr: 'Removing current app'.

	Current := nil
]

{ #category : #'class initialization' }
CynApp class >> start [

	"Start an instance of the receiver in the browser"

	CpHtmlElement documentBody
		appendChild: (self current
			load ;
			yourself)
]

{ #category : #'web resources' }
CynApp class >> style [

	<webResource: #css>

	^ '*, *:before, *:after {
	box-sizing: border-box;
}
:host {
	height: 100%;
}'
]

{ #category : #accessing }
CynApp >> activePage [

	"Answer the currently active page.

	During navigation, there is a transition which might make this value unreliable (at that moment)."

	^ navigation lastChild
]

{ #category : #accessing }
CynApp >> apiBaseUrl [

	"Answer the base URL for the REST API"

	^ '/api'
]

{ #category : #actions }
CynApp >> closePage: aPage [

	"Close the specified page"

	aPage isActive
		ifTrue: [

			"Closing the active page, prepare for navigation to previous page (if available)"
			aPage previousPage
				ifNotNil: [ :previousPage |
					previousPage updateBeforeNavigate.
					navigation pop await.
					previousPage updateAfterNavigate ]
				ifNil: [
					self warnCr: 'Trying to close the root page'.
					^ self ] ]
		ifFalse: [

			"Close 'middle' page without animation"
			(navigation
				removeIndex: aPage indexInParent - 1	 "Ion indexing is 0-based, subtract 1 of our index"
				removeCount: 1
				opts: { #animated -> false } asDictionary) await ].

	"Destroy the old page, removing any dependencies"
	aPage isConnected
		ifTrue: [ self warnCr: 'A page is NOT disconnected after closing it?! ', aPage printString ]
		ifFalse: [ aPage destroy ]
]

{ #category : #actions }
CynApp >> confirm: titleString action: actionString [

	^ self
		confirm: titleString
		action: actionString
		cancel: #'app.action.button.cancel' langText
		onConfirm: nil
]

{ #category : #actions }
CynApp >> confirm: titleString action: actionString cancel: cancelString [

	^ self
		confirm: titleString
		action: actionString
		cancel: cancelString
		onConfirm: nil
]

{ #category : #actions }
CynApp >> confirm: titleString action: actionString cancel: cancelString onConfirm: aBlock [

	"Ask the user for confirmation.
	A title, an action and a cancel option are shown.
	An optional confirmation Block can be specified which will be evaluated before answering
	(leaving the confirmation visible)."

	| action |

	action := self
		selectAction: titleString from: {
			IonActionSheetButton new
				text: actionString ;
				yourself.
			IonActionSheetButton new
				text: cancelString ;
				role: #cancel ;
				yourself }.

	"Cancelled by either cancel or backdrop"
	(action isNil or: [ action role = #cancel ])
		ifTrue: [ ^ false ].

	"Evaluate the confirmation Block (if present).
	If an error occurs within the confirmation Block, the confirmation will
	answer false."
	aBlock ifNotNil: [
		[
			[ aBlock value ] on: CynCancelOperation do: [ ^ false ]
		] on: Error do: [ :error |
			self errorCr: 'Failure during confirmation operation: ', error printString.
			^ false
		] ].

	^ true
]

{ #category : #actions }
CynApp >> confirm: titleString action: actionString onConfirm: aBlock [

	^ self
		confirm: titleString
		action: actionString
		cancel: #'app.action.button.cancel' langText
		onConfirm: aBlock
]

{ #category : #accessing }
CynApp >> defaultToastDuration [

	"The default duration in ms that a toast is shown"

	^ 3000
]

{ #category : #'event handling' }
CynApp >> handleOffline [

	"The netwerk is no longer available"

	self addClass: #offline
]

{ #category : #'event handling' }
CynApp >> handleOnline [

	"The netwerk became available (not necessarily actual internet connection)"

	self removeClass: #offline
]

{ #category : #'event handling' }
CynApp >> handleRestApiClientFailed: aRestApiClientFailed [

	self errorCr: 'Failed to perform REST API call. Error: ', aRestApiClientFailed exception printString
]

{ #category : #'event handling' }
CynApp >> handleSessionExpired [

	"The session expired.
	See also class comment with respect to session expiration."

]

{ #category : #'error handling' }
CynApp >> handleUnhandledError: anError [

	"An Error is signaled which is not handled elsewhere. Handle it here.
	Answer a Boolean indicating whether the error is sufficiently handled to
	consider it 'fixed'.

	Unhandled Errors are Errors which have not 'seen' an error handler.
	This can typically happen when using a #when:forkedSend:to or #when:forkedDo:for:
	and an Error is signaled during the forked Process. There is no active context
	anymore to handle the error in a normal flow. The signaling context is available
	to retrieve information from.
	A few special cases can be handled here (in a generic way). Others might indicate
	an issue in the code and proper error handling should be added to the relevant
	piece of code."

	"Check if the receiver is an already handled/processed REST API Client error"
	((anError isKindOf: CynRestResponseError) and: [ anError isHandled ])
		ifTrue: [ ^ true ].

	"Assuming the REST API is behind some proxy (like nginx)"
	anError statusCode = CynRestResponseError codeBadGateway
		ifTrue: [
			self showErrorServerNotAvailable.
			^ false ].

	"Forbidden means an authorization issue, should have been prevented"
	anError statusCode = CynRestResponseError codeForbidden
		ifTrue: [
			self showErrorForbidden.
			^ false ].

	"Ouch...probably programming error"
	anError statusCode = CynRestResponseError codeInternalServerError
		ifTrue: [
			self showErrorInternalServerError: anError.
			^ false ].

	self errorCr: 'Unhandled Error in App'.
	self class ifDevelopment: [
		(self locationFromSignalerContext: anError signalerContext) ifNotNil: [ :origin |
			self traceCr: 'Origin seems to be: ', origin method printString ].
		self traceCr: anError printString.
		self traceCr: anError signalerContext printString.
		^ false ].
	self traceCr: anError description asString.

	^ false
]

{ #category : #testing }
CynApp >> hasInteraction [

	"Answer whether a user interaction element is visible"

	"Find last non-hidden element and see if it is marked as an interaction element"
	^ (self main lastDescendantMatching: ':scope > :not(.overlay-hidden):not(.hidden)')
		ifNotNil: [ :element | element isClassed: #interaction ]
		ifNil: [ false ]
]

{ #category : #accessing }
CynApp >> homePageClass [

	"Answer the page class representing the initial/home page for the app"

	self subclassResponsibility
]

{ #category : #accessing }
CynApp >> homePageModel [

	"Answer the model representing the initial/home page model for the app.
	If a model is not required, answer nil."

	^ nil
]

{ #category : #initialization }
CynApp >> initialize [

	"Initialize the receiver.
	Add the Ionic style separately.
	Initialize language and REST API client.

	Implementation:
	An issue in Ionic sometimes prevents adding styling correctly.
	See https://github.com/ionic-team/ionic-framework/issues/25100"

	| restApiClient shadowRoot ionicStyle |

	super initialize.

	ionicStyle := (CpHtmlElement newWithTag: #style)
		textContent: '@import url("https://cdn.jsdelivr.net/npm/@ionic/core/css/ionic.bundle.css");' ;
		yourself.

	(shadowRoot := self shadowRoot) firstChild
		ifNotNil: [ :firstChild | shadowRoot insertChild: ionicStyle before: firstChild ]
		ifNil: [ shadowRoot appendChild: ionicStyle ].

	"Initialize the language text before anything else"
	self initializeLanguageText.

	"Setup handlers for detecting going online/offline"
	CpBrowserWindow current
		addEventListener: #online handler: [ self handleOnline ] ;
		addEventListener: #offline handler: [ self handleOffline ].

	"Create the REST API client"
	restApiClient := CynRestApiClient baseUrl: self apiBaseUrl.
	restApiClient
		when: CynSessionExpired send: #handleSessionExpired to: self ;
		when: CynRestApiClientFailed send: #handleRestApiClientFailed: to: self.

	"Attach the REST API Client to the models"
	CynPropertyEntity restApiClient: restApiClient
]

{ #category : #initialization }
CynApp >> initializeLanguageText [

	"Initialize the language text by setting the default language, locale and fallback locales"

	CynPropertyEntity
		languageText: (CynMultiLanguageText defaultLanguage: self class defaultLanguage) ;
		addVolume: (CynLanguageVolume fromDictionary: self class defaultAppTexts) locale: self class defaultLocale ;
		addVolume: (CynLanguageVolume fromDictionary: self class constraintTexts) locale: self class defaultLocale
]

{ #category : #testing }
CynApp >> isOnline [

	"Answer whether an Internet connection is available.

	Implementation:
	Some browsers recognize a LAN connection as being online, but it does not mean
	an actual connection with the Internet is available. Being 'offline' means there
	is no LAN and therefore no Internet connection. In other cases a 'ping' is done
	to ensure there is in fact a working internet connection. The ping is only
	performed if there has not been a successful response in the last few seconds."

	| restApiClient |

	(self isClassed: #offline)
		ifTrue: [ ^ false ].

	CpBrowserNavigator current onLine
		ifFalse: [ ^ false ].

	restApiClient := CynPropertyEntity restApiClient.

	"Used REST API successfully within last 5 seconds?"
	restApiClient lastSuccessResponseTimestamp >= (CynRestApiClient timestampNow - 5000)
		ifTrue: [ ^ true ].

	^ restApiClient ping
]

{ #category : #initialization }
CynApp >> load [

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
			IonButtons.
			IonTitle.
			IonContent.
			IonList.
			IonItem.
			IonLoading.
			IonToast.
			IonAlert.
			IonButton.
			IonInput }
		do: [ self loadApp ]
]

{ #category : #initialization }
CynApp >> loadApp [

	"Build the app structure. The app structure lives in the Light DOM and will
	be subject to Light DOM CSS.

	The general structure of the app consists of:
		ion-menu
			ion-header
				ion-toolbar
					ion-title
		div (placeholder for page content)
			ion-nav

	Each page is responsible for deciding whether a header and/or footer should
	be present. Also having tabs and the navigation between these tabs is the
	responsibility of the page. The CpCanyonAppPage does have some default
	behavior for your convenience. For example, placing a back button in a page's
	header or footer will make it behave as expected, it will call the page's
	#navigateBack behavior.

	Content for the menu should be constructed in #loadMenu. To be able to use
	the menu typically a IonMenuButton / <ion-menu-button> should be placed
	visible on the page (in the header for example, and again it will work
	automagically) or some code should explicitly open the menu based on the
	user input/action."

	"Create the visual app structure"
	self
		appendChild: (main := IonApp new

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

			"Add the page content (placeholder, including navigation control)"
			appendChild: ((CpHtmlElement newWithTag: #div)
				id: #app ;
				appendChild: (navigation := IonNav new) ;
				yourself) ;

			yourself).

	"Load the content for the menu"
	self loadMenu.

	"Load any content required for the app"
	self loadInitialContent.

	"Load the first page (aka home page)"
	self showPage: self homePageClass withModel: self homePageModel
]

{ #category : #initialization }
CynApp >> loadInitialContent [

	"Load the initial app content.
	This can also include restoring the session (e.g. using (persisted) variables
	from the client environment)."
]

{ #category : #initialization }
CynApp >> loadMenu [

	"Load the menu for the app.
	Typically this will add an instance of the IonContent to the menu
	instance variable. How the menu is represented and how it interacts
	is up to the subclass to decide."
]

{ #category : #'error handling' }
CynApp >> locationFromSignalerContext: aContext [

	^ self locationFromSignalerContext: aContext startingWith: nil
]

{ #category : #'error handling' }
CynApp >> locationFromSignalerContext: aContext startingWith: anObject [

	"Answer the best outer location (for logging) where the specified Context
	originated, using the specified Object as current best.
	The answer will either be a Context or the specified initial value (if no
	useful Context is found).

	Implementation:
	Since this is a mobile app and this method is used in the context of finding
	an unhandled error (probably originated from an event), find the WebComponent
	deepest down the call chain and use that context."

	^ aContext sender
		ifNotNil: [ :sender |
			self
				locationFromSignalerContext: sender
				startingWith: ((aContext receiver ifNotNil: [ :receiver |
					(receiver isKindOf: CpWebComponent)
						ifTrue: [ aContext ] ])
							ifNil: [ anObject ]) ]
		ifNil: [ anObject ]
]

{ #category : #accessing }
CynApp >> main [

	^ main ifNil: [ self ]
]

{ #category : #actions }
CynApp >> menuClose [

	"Close the menu (do not await the closing)"

	menu close
]

{ #category : #accessing }
CynApp >> menuSide [

	"Answer the side where the menu is shown (either #start or #end)"

	^ #start
]

{ #category : #accessing }
CynApp >> menuTitle [

	"Answer the title of the menu (from the language resource)"

	^ #'app.menu.title' langText
]

{ #category : #actions }
CynApp >> navigateTo: aPageClass [

	"Navigate to another page"

	self navigateTo: aPageClass withModel: nil
]

{ #category : #actions }
CynApp >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page using the (optional) specified Model.
	The currently active page is responsible for deciding whether navigation
	is possible. There might be unsaved changes for example."

	self activePage
		navigateTo: aPageClass withModel: aModel
]

{ #category : #actions }
CynApp >> selectAction: aString from: aCollection [

	"Show the receiver's ActionSheet and answer the action selected.
	The answered value is the element from the specified Collection.

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

	| buttons actionSheet didDismiss result resultIndex |

	"Create collection of input buttons (with their index as data)"
	buttons := Array new: aCollection size.
	aCollection withIndexDo: [ :each :index |
		buttons at: index put: (each asRelaxedJsonObjectValue
			at: #data put: index ;
			yourself) ].

	"Create and show an ActionSheet"
	actionSheet := IonActionSheet new
		header: aString ;
		buttons: buttons ;
		yourself.

	"Register interest in dismiss, present and wait for result"
	self showInteraction: actionSheet.
	didDismiss := actionSheet onDidDismiss.
	actionSheet present.
	result := actionSheet onWillDismiss await.

	"Remove the action sheet (does not happen automagically) once it actually dismissed,
	otherwise it will not be removed correctly (Ionic does some magic with 'portals')."
	CpGlobalThis defer: [
		didDismiss await.
		actionSheet remove ].

	"Extract the selected index (stored in data above) to answer the actual input (not a JS variant)"
	result ifNil: [ ^ nil ].
	resultIndex := result at: #data ifAbsent: [ ^ nil ].
	resultIndex isInteger
		ifFalse: [ ^ nil ].

	^ aCollection at: resultIndex
]

{ #category : #actions }
CynApp >> selectInput: titleString from: aCollection [

	^ self selectInput: titleString message: nil from: aCollection
]

{ #category : #actions }
CynApp >> selectInput: titleString message: messageString from: aCollection [

	"Show an Alert with input options and answer the value of the input selected.
	The options are a Collection of IonAlertInput objects (or a similar Dictionary
	like structure).
	When the user cancelled the selection, nil is answered.

	The message is optional.

	Options are specified using the AlertInput interface:
		```
		interface AlertInput {
			type?: TextFieldTypes | 'checkbox' | 'radio' | 'textarea';
			name?: string;
			placeholder?: string;
			value?: any;
			/**
			 * The label text to display next to the input, if the input type is `radio` or `checkbox`.
			 */
			label?: string;
			checked?: boolean;
			disabled?: boolean;
			id?: string;
			handler?: (input: AlertInput) => void;
			min?: string | number;
			max?: string | number;
			cssClass?: string | string[];
			attributes?: { [key: string]: any };
			tabindex?: number;
		}
		```

	See also:
		https://ionicframework.com/docs/api/alert#alertinput"

	| inputAlert didDismiss result |

	inputAlert := IonAlert new
		header: titleString ;
		buttons: {
			{
				#text -> #'app.cancel' langText.
				#role -> #cancel } asDictionary.
			{
				#text -> #'app.ok' langText.
				#role -> #confirm } asDictionary } ;
		yourself.

	messageString ifNotNil: [ inputAlert message: messageString ].

	"Add the inputs field"
	inputAlert inputs: aCollection asRelaxedJsonObjectValue.

	"Show input and wait on closing (dismissal)"
	self showInteraction: inputAlert.
	didDismiss := inputAlert onDidDismiss.
	inputAlert present.
	result := inputAlert onWillDismiss await.

	"Remove the action sheet (does not happen automagically) once it actually dismissed,
	otherwise it will not be removed correctly (Ionic does some magic with 'portals')."
	CpGlobalThis defer: [
		didDismiss await.
		inputAlert remove ].

	"Validate the user confirmed a selection"
	result ifNil: [ ^ nil ].
	(result at: #role ifAbsent: [ ^ nil ]) = #confirm
		ifFalse: [ ^ nil ].

	"Extract only the values part from the result"
	result := (result at: #data ifAbsent: [ ^ nil ])
		at: #values ifAbsent: [ ^ nil ].

	^ result
]

{ #category : #actions }
CynApp >> selectOption: aString from: aCollection [

	^ self selectOption: aString message: nil from: aCollection
]

{ #category : #actions }
CynApp >> selectOption: titleString message: messageString from: aCollection [

	"Show an Alert with options as radio 'type' and answer the value of the
	option selected. The options are either a Collection of Strings or a
	Collection of IonAlertInput objects (or a similar Dictionary like structure).
	The type of input option is ignored (the option is always shown as 'radio').
	The answered value is either the String selected (if only Strings are supplied)
	or otherwise the value of the input object selected. If no value is present for
	that particular option, the index of the option in its Collection is answered.
	When the user cancelled the selection, nil is answered.
	Please DO NOT use nil as an input value because the distinction can not be
	made by the caller. This method will then answer the selected index.

	The message is optional.

	Options are specified using the AlertInput interface:
		```
		interface AlertInput {
			type?: TextFieldTypes | 'checkbox' | 'radio' | 'textarea';
			name?: string;
			placeholder?: string;
			value?: any;
			/**
			 * The label text to display next to the input, if the input type is `radio` or `checkbox`.
			 */
			label?: string;
			checked?: boolean;
			disabled?: boolean;
			id?: string;
			handler?: (input: AlertInput) => void;
			min?: string | number;
			max?: string | number;
			cssClass?: string | string[];
			attributes?: { [key: string]: any };
			tabindex?: number;
		}
		```

	See also:
		https://ionicframework.com/docs/api/alert#alertinput

	Implementation:
	To allow input values to be different types (even some non-supported by JavaScript) the code
	below replaces the supplied input value with the input's index. After successfully receiving
	a selection, this index is used to retrieve the original input value and answer it. IF no
	specific value is present, the index will be answered of the input.
	Using Symbols for values in the input objects will result in a Symbol being answered, instead
	of a String (since JS can't tell the difference)."

	| optionAlert didDismiss inputs result resultIndex |

	optionAlert := IonAlert new
		header: titleString ;
		buttons: {
			{
				#text -> #'app.cancel' langText.
				#role -> #cancel } asDictionary.
			{
				#text -> #'app.ok' langText.
				#role -> #confirm } asDictionary } ;
		yourself.

	messageString ifNotNil: [ optionAlert message: messageString ].

	"Create correct inputs field"
	inputs := Array new: aCollection size.
	aCollection withIndexDo: [ :each :index |
		inputs at: index put: (each isString
			ifTrue: [
				{
					#label -> each.
					#value -> index.
					#type -> #radio } asDictionary ]
			ifFalse: [
				"Update the input to have a known value (my index)"
				each asRelaxedJsonObjectValue
					at: #value put: index ;
					at: #type put: #radio ;
					yourself ]) ].
	optionAlert inputs: inputs.

	"Show input and wait on closing (dismissal)"
	self showInteraction: optionAlert.
	didDismiss := optionAlert onDidDismiss.
	optionAlert present.
	result := optionAlert onWillDismiss await.

	"Remove the action sheet (does not happen automagically) once it actually dismissed,
	otherwise it will not be removed correctly (Ionic does some magic with 'portals')."
	CpGlobalThis defer: [
		didDismiss await.
		optionAlert remove ].

	"Validate the user confirmed a selection"
	result ifNil: [ ^ nil ].
	(result at: #role ifAbsent: [ ^ nil ]) = #confirm
		ifFalse: [ ^ nil ].

	"Extract the selected input value (the input index)"
	resultIndex := (result at: #data ifAbsent: [ ^ nil ])
		at: #values ifAbsent: [ ^ nil ].
	resultIndex isInteger
		ifFalse: [ ^ nil ].

	"Retrieve the result value (using the index) into the original input value"
	result := aCollection at: resultIndex ifAbsent: [ ^ nil ].

	^ result isString
		ifTrue: [ result ]
		ifFalse: [
			"Result will be an IonAlertInput or something similar"
			(result at: #value ifAbsent: [ nil ])
				ifNil: [ resultIndex ] ]
]

{ #category : #actions }
CynApp >> showAlertTitle: titleString message: messageString [

	"Show alert message and wait for user to confirm it"

	| alert |

	alert := IonAlert new
		header: titleString ;
		message: messageString ;
		buttons: { 'Okay' } ;
		yourself.

	"Present and wait for result"
	self showInteraction: alert.
	alert present.
	alert onDidDismiss await.
	alert remove
]

{ #category : #'error handling' }
CynApp >> showErrorForbidden [

	self
		showAlertTitle: #'app.server.forbidden.title' langText
		message: #'app.server.forbidden.message' langText
]

{ #category : #'error handling' }
CynApp >> showErrorInternalServerError: anError [

	self
		showAlertTitle: #'app.server.internalError.title' langText
		message: #'app.server.internalError.message' langText.

	self class
		ifDevelopment: [ self errorCr: anError printString ]
]

{ #category : #'error handling' }
CynApp >> showErrorServerNotAvailable [

	self
		showAlertTitle: #'app.server.unavailable.title' langText
		message: #'app.server.unavailable.message' langText
]

{ #category : #actions }
CynApp >> showInteraction: anElement [

	"Remove a loading message if present, since it would block the interaction"
	self stopAllLoading.

	^ self main appendChild: (anElement
		addClass: #interaction ;
		yourself)
]

{ #category : #actions }
CynApp >> showLoading: aString [

	"Show a loading message and answer the element's instance.
	If a dialog is already shown, the loading message will NOT be shown
	and nil will be answered. This is done because, otherwise no
	interaction is possible.

	Implementation:
	Do NOT perform an #await here to prevent any delay."

	self hasInteraction
		ifTrue: [ ^ nil ].

	^ self main appendChild: (IonLoading new
		message: aString ;
		present ;
		yourself)
]

{ #category : #actions }
CynApp >> showModal: aViewClass [

	"Show the specified View modal and answer the modal's result"

	^ self showModal: aViewClass withModel: nil
]

{ #category : #actions }
CynApp >> showModal: aViewClass withModel: aModel [

	"Show the specified View modal with the (optional) Model.
	Answer the modal's result (or default true) if confirmed.
	Answer nil if a cancelled."

	| modal view result |

	"Create modal View"
	modal := IonModal new
		component: (IonNav new
			root: (view := aViewClass on: aModel) ;
			yourself) ;
		yourself.

	"Let the view assign dismiss events (after it had time to fully initialize)"
	view openedInModal: modal.

	view updateBeforeNavigate.
	self showInteraction: modal.
	modal present.
	view updateAfterNavigate.

	"Wait for it to close"
	result := modal onDidDismiss await.

	"Explicitly destroy the view (to allow it to release dependencies)"
	view destroy.
	modal remove.

	"Answer data on confirm (role), otherwise nil.
	If no data is present on confirm, answer 'true'."
	result at: #role ifPresent: [ :role |
		role = #confirm
			ifTrue: [ ^ result at: #data ifAbsent: [ true ] ] ].

	^ nil
]

{ #category : #actions }
CynApp >> showModal: aViewClass withModel: aModel onConfirm: aBlock [

	"Show a Modal with the specified Model and perform the specified
	Block (culled with the data from the Modal) on confirmed closing."

	(self showModal: aViewClass withModel: aModel)
		ifNotNil: [ :data | aBlock cull: data ]
]

{ #category : #actions }
CynApp >> showPage: aPageClass withModel: aModel [

	"Show the specified Page with the (optional) Model.
	It is assumed, that all checks have already been performed with respect to navigation."

	| page |

	page := aPageClass on: aModel.

	page updateBeforeNavigate.
	(navigation push: page) await.
	page updateAfterNavigate
]

{ #category : #actions }
CynApp >> showToast: aString [

	"Show the specified toast message with the default duration"

	self showToast: aString duration: self defaultToastDuration
]

{ #category : #actions }
CynApp >> showToast: aString duration: anInteger [

	"Show the specified toast message and dismiss after the specified time (milliseconds).

	Implementation:
	Do NOT perform an #await here to prevent any delay."

	| toast didDismiss |

	toast := self main appendChild: (IonToast new
		message: aString ;
		duration: anInteger ;
		yourself).

	didDismiss := toast onDidDismiss.
	toast present.

	"Remove the toast (does not happen automagically) once it actually dismissed,
	otherwise it will not be removed correctly (Ionic does some magic with 'portals')."
	CpGlobalThis defer: [
		didDismiss await.
		toast remove ]
]

{ #category : #actions }
CynApp >> stopAllLoading [

	"Remove any loading elements"

	(self main allDescendantsMatching: IonLoading asCssSelector) do: [ :each |
		self stopLoading: each ]
]

{ #category : #actions }
CynApp >> stopLoading: aLoading [

	"Stop the specified loading element.

	Do not await the result."

	"Additional check for convenience (see #do:whileShowing:)"
	aLoading ifNil: [ ^ self ].

	aLoading isOpen
		ifTrue: [
			aLoading dismiss
				then: [ aLoading remove ] ]
		ifFalse: [ aLoading remove ]
]
