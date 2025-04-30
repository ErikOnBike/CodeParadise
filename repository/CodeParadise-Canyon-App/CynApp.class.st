"
I am the Canyon app main view. I also represent the app's main access point and will therefore be
referenced (e.g. from a CpCanyonAppPage) as the 'app'.
I am responsible for maintaining a number of visual components (in order):
- menu
- pages (through a navigation component)
- action sheet (allowing the user to selection some action)
- loading (showing a message while performing some operation)
- toast
- alert
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

For a nice tag in the browser, my subclasses could be named something like SpecialAppView
resulting in the tag <special-app> which also describes my 'app' role. The prefix-less name
should probably be okay for this name (you want a unique app name in any case ;-).
"
Class {
	#name : #CynApp,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'navigation',
		'menu',
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
CynApp class >> beLoaded [

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

{ #category : #'accessing - text' }
CynApp class >> constraintTexts [

	"Answer Dictionary with constraint texts"

	^ Dictionary new
		at: #'constraint.multi.violations' put: 'I''m sorry, I don''t understand your input:' ;
		at: #'constraint.empty' put: 'Please provide some input for ''{label}''.' ;
		at: #'constraint.required' put: 'Please provide some input for ''{label}'', so I can operate correctly.' ;
		at: #'constraint.email.name' put: 'I don''t understand this email address. For the @-symbol only letters, digits and the following symbols are allowed: {1}' ;
		at: #'constraint.email.domain' put: 'I don''t understand this email address. After the @-symbol only letters, digits and dashes are allowed.' ;
		at: #'constraint.email.format' put: 'I don''t understand this email address, it should contain exactly one @-symbol.' ;
		at: #'constraint.email.at' put: 'I don''t understand this email address, it should match the pattern "name@example.org".' ;
		at: #'constraint.email.dot' put: 'I don''t understand this email address, it should only have dots between the domain name parts (like "name@some.example.org").' ;
		at: #'constraint.email.dash' put: 'I don''t understand this email address, it should only have dashes inside domain name parts (like "name@some.sub-example.org").' ;
		at: #'constraint.password.length' put: 'The password should be at least {1} characters long.' ;
		at: #'constraint.token.length' put: 'The code should be exactly 32 characters long. Maybe it is not copied correctly from the mail?' ;
		at: #'constraint.token.content' put: 'The code should only contain digits and the letters ''a'' until ''f''. Maybe it is not copied correctly from the mail?' ;
		at: #'constraint.length.min' put: 'The input for ''{label}'' should be at least {1} characters long and is only {2} characters long.' ;
		at: #'constraint.length.min.zero' put: 'The input for ''{label}'' should be at least {1} characters long and is currently still empty.' ;
		at: #'constraint.length.max' put: 'The input for ''{label}'' should have at most {1} characters and is {2} characters long.' ;
		at: #'constraint.selection.unknown' put: 'The value ''{1}'' is not allowed at the input for ''{label}''.' ;
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

	^ Dictionary new
		at: #'app.ok' put: 'OK' ;
		at: #'app.cancel' put: 'Cancel' ;
		at: #'app.menu.title' put: 'Menu' ;
		at: #'app.label.account.email' put: 'email' ;
		at: #'app.label.account.password' put: 'password' ;
		at: #'app.label.account.token' put: 'code' ;
		at: #'app.selection.loginAccount.expires.usage' put: 'After usage' ;
		at: #'app.selection.loginAccount.expires.day' put: 'The next day' ;
		at: #'app.selection.loginAccount.expires.never' put: 'Never' ;
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
}
#app {
	height: 100%;
}
@media screen and (min-width: 940px) {
	body {
		transition: background-color 1s;
		background-color: var(--ion-background-color);
	}
	body.thin {
		background-color: #999;
	}
	ion-app {
		transition: left 1s, right 1s, background-color 1s;
	}
	html body.thin ion-app {
		left: calc((100% - 940px) / 2);
		right: calc((100% - 940px) / 2);
	}
}'
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
	is not present."

	CpSecondaryClickEvent resetDefaultContextMenu.
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
CynApp >> apiBaseUrl [

	"Answer the base URL for the REST API"

	^ '/api'
]

{ #category : #actions }
CynApp >> closePage: aPage [

	"Close the specified page"

	aPage isCurrent
		ifTrue: [

			"Closing the current page, prepare for navigation to previous page (if available)"
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

{ #category : #accessing }
CynApp >> currentPage [

	"Answer the current page.

	During navigation, there is a transition which might make this value unreliable (at that moment)."

	^ navigation lastChild
]

{ #category : #accessing }
CynApp >> defaultToastDuration [

	"The default duration in ms that a toast is shown"

	^ 3000
]

{ #category : #'event handling' }
CynApp >> handleDidDismissActionSheet [

	"This is an async call, but no use awaiting it, because we're not using the result"

	actionSheet isOpen: false
]

{ #category : #'event handling' }
CynApp >> handleDidDismissAlert [

	"This is an async call, but no use awaiting it, because we're not using the result"

	alert isOpen: false
]

{ #category : #'event handling' }
CynApp >> handleDidDismissLoading [

	"This is an async call, but no use awaiting it, because we're not using the result"

	loading isOpen: false
]

{ #category : #'event handling' }
CynApp >> handleDidDismissToast [

	"This is an async call, but no use awaiting it, because we're not using the result"

	toast isOpen: false
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

{ #category : #actions }
CynApp >> hideLoading [

	loading dismiss await
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

	| restApiClient |

	super initialize.

	"Initialize the language text before anything else"
	self initializeLanguageText.

	"Setup handlers for detecting going online/offline"
	CpBrowserWindow current
		addEventListener: #online handler: [ self handleOnline ] ;
		addEventListener: #offline handler: [ self handleOffline ].

	"Create the REST API client"
	restApiClient := CynRestApiClient baseUrl: self apiBaseUrl.
	restApiClient
		when: CynSessionExpired send: #sessionExpired to: self ;
		when: CynRestApiClientFailed send: #restApiClientFailed: to: self.

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
CynApp >> isLoading [

	^ loading isOpen
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

	| restApiClient response |

	(self isClassed: #offline)
		ifTrue: [ ^ false ].

	CpBrowserNavigator current onLine
		ifFalse: [ ^ false ].

	restApiClient := CynPropertyEntity restApiClient.

	"Used REST API successfully within last 5 seconds"
	restApiClient lastSuccessResponseTimestamp >= (CynRestApiClient timestampNow - 5000)
		ifTrue: [ ^ true ].

	response := [
		restApiClient getUri: '/ping/hello' timeoutPeriod: 2000
	] on: Error do: [ :err | ^ false ].

	^ response = 'world'
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
CynApp >> loadApp [

	"Build the app structure. The app structure lives in the Light DOM and will
	be subject to Light DOM CSS.

	The general structure of the app consists of:
		menu
		placeholder for page content (incl. navigation control)
		action sheet (for allowing the user to select an action)
		loading (for showing a message while performing some task)
		toast
		alert

	The order is relevant. Toast and alert should be last, because they should
	overlay the other elements (visually). The alert is considered the most
	important and is therefore added last.

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

			"Add the page content (placeholder, including navigation control)"
			appendChild: ((CpHtmlElement newWithTag: #div)
				id: #app ;
				appendChild: (navigation := IonNav new) ;
				yourself) ;

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

	^ CynPropertyEntity text: #'app.menu.title'
]

{ #category : #actions }
CynApp >> navigateTo: aPageClass [

	"Navigate to another page"

	self navigateTo: aPageClass withModel: nil
]

{ #category : #actions }
CynApp >> navigateTo: aPageClass withModel: aModel [

	"Navigate to another page using the (optional) specified Model.
	The current page is responsible for deciding whether navigation
	is possible. There might be unsaved changes for example.
	Or the user needs to login first."

	self currentPage
		navigateTo: aPageClass withModel: aModel
]

{ #category : #'event handling' }
CynApp >> restApiClientFailed: aRestApiClientFailed [

	self errorCr: 'Failed to perform REST API call. Error: ', aRestApiClientFailed exception printString
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

	| buttons result resultIndex |

	buttons := Array new: aCollection size.
	aCollection withIndexDo: [ :each :index |
		buttons at: index put: (each asRelaxedJsonObjectValue
			at: #data put: index ;
			yourself) ].

	result := (actionSheet
		header: aString ;
		buttons: buttons ;
		present ;
		onDidDismiss) await.

	result ifNil: [ ^ nil ].
	resultIndex := result at: #data ifAbsent: [ ^ nil ].
	resultIndex isInteger
		ifFalse: [ ^ nil ].

	^ aCollection at: resultIndex
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

	| optionAlert inputs result resultIndex |

	optionAlert := self appendChild: (IonAlert new
		header: titleString ;
		buttons: {
			{
				#text -> (CynPropertyEntity text: #'app.cancel').
				#role -> #cancel } asDictionary.
			{
				#text -> (CynPropertyEntity text: #'app.ok').
				#role -> #confirm } asDictionary } ;
		yourself).

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
	result := (optionAlert
		present ;
		onDidDismiss) await.

	"Validate the user confirmed a selection"
	result ifNil: [ ^ nil ].
	(result at: #role ifAbsent: [ ^ nil ]) = #confirm
		ifFalse: [ ^ nil ].

	"Extract the selected input value (the input index)"
	resultIndex := (result at: #data ifAbsent: [ ^ nil ])
		at: #values ifAbsent: [ ^ nil ].
	resultIndex isInteger
		ifFalse: [ ^ nil ].

	"Remove the alert (does not happen automagically)"
	optionAlert remove.

	"Retrieve the result value (using the index) into the original input value"
	result := aCollection at: resultIndex ifAbsent: [ ^ nil ].

	^ result isString
		ifTrue: [ result ]
		ifFalse: [
			"Result will be an IonAlertInput or something similar"
			(result at: #value ifAbsent: [ nil ])
				ifNil: [ resultIndex ] ]
]

{ #category : #'event handling' }
CynApp >> sessionExpired [

	"The session expired.
	See also class comment with respect to session expiration."

]

{ #category : #actions }
CynApp >> showAlertTitle: titleString message: messageString [

	"Show alert message and wait for user to confirm it"

	(alert
		header: titleString ;
		message: messageString ;
		buttons: { 'Okay' } ;
		present ;
		onDidDismiss) await
]

{ #category : #actions }
CynApp >> showLoading: aString [

	"Show a loading message.

	Implementation:
	Do NOT perform an #await here to prevent any delay."

	loading
		message: aString ;
		present
]

{ #category : #actions }
CynApp >> showModal: aViewClass [

	"Show the specified View modal.
	Evaluate the specified Block with the result from the View."

	^ self showModal: aViewClass withModel: nil
]

{ #category : #actions }
CynApp >> showModal: aViewClass withModel: aModel [

	"Show the specified View modal with the (optional) Model"

	| modal view result |

	"Create modal View"
	modal := IonModal new
		component: (view := aViewClass on: aModel) ;
		yourself.

	"Let the view assign dismiss events (after it had time to fully initialize)"
	view makeDismissableIn: modal.

	view updateBeforeNavigate.
	self appendChild: modal.
	modal present.
	view updateAfterNavigate.

	"Wait for it to close"
	result := modal onWillDismiss await.

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

	toast
		message: aString ;
		duration: anInteger ;
		present
]
