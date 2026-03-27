Class {
	#name : #CpAuth0SPAExamplesWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#instVars : [
		'client'
	],
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Examples'
}

{ #category : #accessing }
CpAuth0SPAExamplesWebClientBehavior >> clearOutput [

	self outputElement makeEmpty
]

{ #category : #initialization }
CpAuth0SPAExamplesWebClientBehavior >> client [

	^ client ifNil: [
		client := CpAuth0Client options: (CpAuth0ClientOptions new
			domain: 'codeparadise.eu.auth0.com' ;
			clientId: '2gnhXe1qvMi37SHSKnz2JDLQo6PEDZyJ' ;
			authorizationParams: (CpAuth0AuthorizationParams new
				redirect_uri: CpBrowserDocument current location ;
				yourself) ;
			yourself) ]
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> exampleGetTokenSilently [

	<example: 'Get Token Silently' order: 30>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Get Token Silently' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Click to get token:' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'GetTokenSilently' ;
			when: CpPrimaryClickEvent send: #getTokenSilently to: self ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> exampleLoginPopup [

	<example: 'Login popup' order: 10>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Login popup' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Click to login:' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Login' ;
			when: CpPrimaryClickEvent send: #loginWithPopup to: self ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> exampleLoginRedirect [

	<example: 'Login redirect' order: 20>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Login redirect' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Click to login:' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Login' ;
			when: CpPrimaryClickEvent send: #loginWithRedirect to: self ;
			yourself)
]

{ #category : #operations }
CpAuth0SPAExamplesWebClientBehavior >> getTokenSilently [

	self client
		ifNotNil: [ :authClient |
			authClient getTokenSilently
				then: [ :value |
					self showResult: value.
					self updateStatus ]
				catch: [ :error |
					self showError: error.
					self updateStatus ] ]
		ifNil: [ self showError: 'Auth0 not loaded yet' ]
]

{ #category : #initialization }
CpAuth0SPAExamplesWebClientBehavior >> initialize [

	super initialize.

	self showIndex.

	"Allow Auth0 to be loaded"
	CpAuth0Client whenLoadedDo: [ self updateStatus ]
]

{ #category : #operations }
CpAuth0SPAExamplesWebClientBehavior >> loginWithPopup [

	self client
		ifNotNil: [ :authClient |
			authClient loginWithPopup
				then: [ :value |
					self showResult: value.
					self updateStatus ]
				catch: [ :error |
					self showError: error.
					self updateStatus ] ]
		ifNil: [ self showError: 'Auth0 not loaded yet' ]
]

{ #category : #operations }
CpAuth0SPAExamplesWebClientBehavior >> loginWithRedirect [

	self client
		ifNotNil: [ :authClient |
			authClient loginWithRedirect
				then: [ :value | self showResult: value ]
				catch: [ :error | self showError: error ] ]
		ifNil: [ self showError: 'Auth0 not loaded yet' ]
]

{ #category : #operations }
CpAuth0SPAExamplesWebClientBehavior >> logout [

	self client
		ifNotNil: [ :authClient |
			(authClient logoutOptions: (CpAuth0LogoutOptions new openUrl: false ; yourself))
				then: [ :value |
					self showResult: value.
					self updateStatus ]
				catch: [ :error |
					self showError: error.
					self updateStatus ] ]
		ifNil: [ self showError: 'Auth0 not loaded yet' ]
]

{ #category : #accessing }
CpAuth0SPAExamplesWebClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showAuthenticated: aString [

	(CpHtmlElement elementWithId: #authenticated)
		textContent: aString
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showError: anObject [

	self outputElement
		appendChild: ((CpHtmlElement newWithTag: #p)
			styleAt: #color put: #red ;
			textContent: 'Error: ', anObject printString ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentAddStyle: '
		#container {
			display: flex;
			height: calc(100vh - 6em);
		}
		#left {
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			width: 20em;
			height: 100%;
			overflow-y: scroll;
			margin: 0;
			padding: 0;
			border-right: 1px solid #999;
		}
		#menu {
			display: inline-block;
		}
		#menu li { 
			cursor: pointer;
		}
		#right {
			width: 100%;
			height: 100%;
			overflow-y: scroll;
		}
		#result {
			display: inline-block;
			width: calc(100% - 4em);
			height: calc(100% - 4em);
			padding: 2em;
		}
		#output {
			position: relative;
			width: 100%;
			height: 100%;
		}'.
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>Browser Support Examples</h1>
		<div id="container">
			<div id="left">
				<div id="menu"><ul id="list"></ul></div>
				<div>
					<div><span>Authenticated: </span><span id="authenticated">&lt;unknown&gt;</span></div>
					<div><button id="logout">Logout</button></div>
				</div>
			</div>
			<div id="right">
				<div id="result"><div id="output"></div></div>
			</div>
		</div>
	'.

	list := body firstDescendantMatching: '#list'.

	"Collect items from example methods"

	items := 	OrderedCollection new.
	(self class selectors select: [ :each | each beginsWith: #example ]) do: [ :selector |
		(self class >> selector) properties ifNotNil: [ :properties |
			(properties at: #example:order:) ifNotNil: [ :pragma |
				items add: selector -> pragma arguments ] ] ].

	"Sort items (a and b are associations where the value contains the pragma arguments #title and #order)"
	items sort: [ :a :b |
		"Either the order of a is lower than order of b"
		(a value second < b value second) or: [
			"or the have the same order and a comes before b alphabetically" 
			(a value second = b value second) and: [ a value first < b value first ] ] ].

	"Render items onto DOM"
	items do: [ :item |
				
		list appendChild: ((CpHtmlElement newWithTag: 'li')
			id: item key ;	"ie selector"
			textContent: item value first ;	"ie title"
			when: CpClickEvent send: item key to: self ;
			yourself) ].

	"Click handler for logout"
	(CpHtmlElement elementWithId: #logout)
		when: CpPrimaryClickEvent send: #logout to: self
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showResult: anObject [

	self outputElement
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Result: ', anObject printString ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showToken: anObject [

	self outputElement
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Token: ', anObject printString ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> showUser: aString [

	self outputElement
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'User:' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #pre)
			textContent: aString ;
			yourself)
]

{ #category : #examples }
CpAuth0SPAExamplesWebClientBehavior >> updateStatus [

	"Check if we came here after a login redirect"
	self client
		ifNotNil: [ :authClient |
			authClient hasRedirectParameters
				ifTrue: [
					authClient handleRedirectCallback
						then: [ :value |
							self showResult: 'Handling redirect parameters: ', value printString.
							authClient getTokenSilently
								then: [ :token | self showToken: token ]
								catch: [ :error | self showError: 'Failed #getTokenSilently: ', error printString ].
							authClient removeRedirectParameters ]
						catch: [ :error | self showError: 'Failed #handleRedirectCallback: ', error printString ].

					"Stop here, since otherwise additional Auth0 requests are made (which interfere with the above async code)"
					^ self ] ].

	"Perform some checks and show result"
	self client
		ifNotNil: [ :authClient |
			authClient checkSession
				then: [ :value | self traceCr: 'Check session: ', value printString ]
				catch: [ :error | self showError: 'Failed #checkSession: ', error printString ] ].

	self client
		ifNotNil: [ :authClient |
			authClient isAuthenticated
				then: [ :authenticated | self showAuthenticated: authenticated printString ]
				catch: [ :error |
					self showError: 'Failed #isAuthenticated: ', error printString.
					self showAuthenticated: '<error>' ] ]
		ifNil: [ self showAuthenticated: '<unavailable>' ].

 	self client
		ifNotNil: [ :authClient |
			authClient getUser
				then: [ :user | self showUser: (CpJavaScriptJSON indentedStringify: user) ]
				catch: [ :error | self showError: 'Failed #getUser: ', error printString ] ]
]
