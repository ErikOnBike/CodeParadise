Class {
	#name : #CpAuth0Client,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Core'
}

{ #category : #accessing }
CpAuth0Client class >> getClass [

	^ (CpGlobalThis globalThis propertyAt: #auth0 resultAs: CpJavaScriptObject) ifNotNil: [ :auth0 |
		auth0 propertyAt: self getClassName resultAs: CpJavaScriptClass ]
]

{ #category : #'class initialization' }
CpAuth0Client class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentAddExternalScript: 'https://cdn.auth0.com/js/auth0-spa-js/2.17/auth0-spa-js.production.js'
]

{ #category : #accessing }
CpAuth0Client class >> options: anAuth0ClientOptions [

	^ self newInstanceWithArguments: { anAuth0ClientOptions asDictionary }
]

{ #category : #'class initialization' }
CpAuth0Client class >> postInstallOnce [

	self loadLibrary
]

{ #category : #'event handling' }
CpAuth0Client class >> whenLoadedDo: aBlock [

	"Convenience method to invoke a Block once the receiver is fully loaded"

	self getClass
		ifNotNil: [ self traceCr: 'loaded'. aBlock value ]
		ifNil: [ self traceCr: 'waiting'. CpGlobalThis setTimeout: 100 thenDo: [ self whenLoadedDo: aBlock ] ]
]

{ #category : #operations }
CpAuth0Client >> checkSession [

	"Check if the user is logged in using getTokenSilently. The difference with getTokenSilently is that this doesn't return a token, but it will pre-fill the token cache.

	This method also heeds the auth0.{clientId}.is.authenticated cookie, as an optimization to prevent calling Auth0 unnecessarily. If the cookie is not present because there was no previous login (or it has expired) then tokens will not be refreshed.

	It should be used for silently logging in the user when you instantiate the Auth0Client constructor. You should not need this if you are using the createAuth0Client factory.

	Note: the cookie may not be present if running an app using a private tab, as some browsers clear JS cookie data and local storage when the tab or page is closed, or on page reload. This effectively means that checkSession could silently return without authenticating the user on page refresh when using a private tab, despite having previously logged in. As a workaround, use getTokenSilently instead and handle the possible login_required error as shown in the readme."

	^ self apply: #checkSession resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getConfiguration [

	"Returns a readonly copy of the initialization configuration."

	^ self apply: #getConfiguration
]

{ #category : #operations }
CpAuth0Client >> getIdTokenClaims [

	"Returns all claims from the id_token if available."

	^ self apply: #getIdTokenClaims resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getTokenSilently [

	"Fetches a new access token and returns the response from the /oauth/token endpoint, omitting the refresh token."

	^ self apply: #getTokenSilently resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getTokenWithPopup [

	^ self apply: #getTokenWithPopup resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getTokenWithPopupOptions: aGetTokenWithPopupOptions [

	^ self
		apply: #getTokenWithPopup
		withArguments: { aGetTokenWithPopupOptions asDictionary }
		resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getTokenWithPopupOptions: aGetTokenWithPopupOptions config: aPopupConfigOptions [

	^ self
		apply: #getTokenWithPopup
		withArguments: { aGetTokenWithPopupOptions asDictionary . aPopupConfigOptions asDictionary }
		resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> getUser [

	"Returns the user information if available (decoded from the id_token)."

	^ self apply: #getUser resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> handleRedirectCallback [

	"After the browser redirects back to the callback page, call handleRedirectCallback to handle success and error responses from Auth0. If the response is successful, results will be valid according to their expiration times."

	^ self apply: #handleRedirectCallback resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> handleRedirectCallback: aString [

	"After the browser redirects back to the callback page, call handleRedirectCallback to handle success and error responses from Auth0. If the response is successful, results will be valid according to their expiration times."

	^ self apply: #handleRedirectCallback withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #'operations - convenience' }
CpAuth0Client >> hasRedirectParameters [

	"Answer whether the browser's current location has redirect parameter values present"

	| location searchParams |

	"Get current search parameters"
	location := CpBrowserDocument current location.
	searchParams := CpBrowserURLSearchParams newInstanceWithArguments: { location search }.

	"Check the redirect parameters"
	^ (searchParams hasKey: #code) and: [ searchParams hasKey: #state ]
]

{ #category : #operations }
CpAuth0Client >> isAuthenticated [

	"Returns true if there's valid information stored, otherwise returns false."

	^ self apply: #isAuthenticated resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> loginWithPopup [

	"Opens a popup with the /authorize URL using the parameters provided as arguments. Random and secure state and nonce parameters will be auto-generated. If the response is successful, results will be valid according to their expiration times.

	IMPORTANT: This method has to be called from an event handler that was started by the user like a button click, for example, otherwise the popup will be blocked in most browsers."

	^ self apply: #loginWithPopup resultAs: CpJavaScriptPromise 
]

{ #category : #operations }
CpAuth0Client >> loginWithPopupOptions: aPopupLoginOptions [

	"Opens a popup with the /authorize URL using the parameters provided as arguments. Random and secure state and nonce parameters will be auto-generated. If the response is successful, results will be valid according to their expiration times.

	IMPORTANT: This method has to be called from an event handler that was started by the user like a button click, for example, otherwise the popup will be blocked in most browsers."

	^ self
		apply: #loginWithPopup
		withArguments: { aPopupLoginOptions asDictionary }
		resultAs: CpJavaScriptPromise 
]

{ #category : #operations }
CpAuth0Client >> loginWithPopupOptions: aPopupLoginOptions config: aPopupConfigOptions [

	"Opens a popup with the /authorize URL using the parameters provided as arguments. Random and secure state and nonce parameters will be auto-generated. If the response is successful, results will be valid according to their expiration times.

	IMPORTANT: This method has to be called from an event handler that was started by the user like a button click, for example, otherwise the popup will be blocked in most browsers."

	^ self
		apply: #loginWithPopup
		withArguments: { aPopupLoginOptions asDictionary . aPopupConfigOptions asDictionary }
		resultAs: CpJavaScriptPromise 
]

{ #category : #operations }
CpAuth0Client >> logout [

	"Clears the application session and performs a redirect to /v2/logout, using the parameters provided as arguments, to clear the Auth0 session.

	If the federated option is specified it also clears the Identity Provider session."

	^ self apply: #logout resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpAuth0Client >> logoutOptions: aLogoutOptions [

	"Clears the application session and performs a redirect to /v2/logout, using the parameters provided as arguments, to clear the Auth0 session.

	If the federated option is specified it also clears the Identity Provider session."

	^ self
		apply: #logout
		withArguments: { aLogoutOptions asDictionary }
		resultAs: CpJavaScriptPromise
]

{ #category : #'operations - convenience' }
CpAuth0Client >> removeRedirectParameters [

	"Remove the redirect parameter values (otherwise reload will fail, because the
	redirect parameters can't be reused)"

	| location searchParams |

	"Get current search parameters"
	location := CpBrowserDocument current location.
	searchParams := CpBrowserURLSearchParams newInstanceWithArguments: { location search }.

	"Remove the redirect parameters"
	searchParams
		deleteKey: #code ;
		deleteKey: #state.

	"Keep new search parameters (do not update existing location, because it will perform a navigation operation)"
	location := CpBrowserURL newUrl: location hrefWithoutSearch.
	location search: searchParams toString.
	CpBrowserHistory current
		replaceState: nil url: location href
]
