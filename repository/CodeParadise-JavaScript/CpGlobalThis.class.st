"
I represent the global object in the JavaScript environment als known as 'globalThis'.
For convenience I have implemented my interface on the class side. This allows my users
to directly send a message without needing to send an additional message for my (singleton)
instance first.

In a web browser the 'globalThis' object is the 'window' object, but I do not implement
the Window interface. Please use CpBrowserWindow for that or use #globalThis to access
the global object instance (which is not an instance of myself).

If you want to keep a reference to an instance of the global object (for quick access),
send #globalThis to retrieve it. It will not be an instance of myself but either a
CpBrowserWindow or an instance of CpJavaScriptObject.
"
Class {
	#name : #CpGlobalThis,
	#superclass : #Object,
	#classVars : [
		'GlobalThis'
	],
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #private }
CpGlobalThis class >> apply: aSymbol [

	"Apply the specified selector on the global JavaScript object.
	For better performance use #apply:resultAs: if the result Class is known."

	^ self apply: aSymbol withArguments: nil resultAs: nil
]

{ #category : #private }
CpGlobalThis class >> apply: aSymbol resultAs: aProxyClass [

	"Apply the specified selector on the global JavaScript object
	and answer the result as an instance of the proxy class specified or answer
	a default object if aProxyClass is nil."

	^ self apply: aSymbol withArguments: nil resultAs: aProxyClass
]

{ #category : #private }
CpGlobalThis class >> apply: aSymbol withArguments: anArray [

	"Apply the specified selector on the global JavaScript object
	using the specified arguments (nil means no arguments).
	For better performance use #apply:resultAs: if the result Class is known."

	^ self apply: aSymbol withArguments: anArray resultAs: nil
]

{ #category : #private }
CpGlobalThis class >> apply: aSymbol withArguments: anArray resultAs: aProxyClass [

	"Apply the specified selector on the global JavaScript object
	using the specified arguments (nil means no arguments). And answer the result
	as an instance of the proxy class specified or answer a default object
	if aProxyClass is nil."

	^ self globalThis
		apply: aSymbol withArguments: anArray resultAs: aProxyClass
]

{ #category : #operations }
CpGlobalThis class >> clearTimeout: anInteger [

	"Clear a previously set timeout"

	^ self apply: #clearTimeout withArguments: { anInteger }
]

{ #category : #operations }
CpGlobalThis class >> decodeURI: aString [

	"Answer a new string representing the unencoded version of the given encoded Uniform Resource Identifier (URI)"

	^ self apply: #decodeURI withArguments: { aString }
]

{ #category : #operations }
CpGlobalThis class >> decodeURIComponent: aString [

	"Answer a new string representing the decoded version of the given encoded Uniform Resource Identifier (URI) component"

	^ self apply: #decodeURIComponent withArguments: { aString }
]

{ #category : #'deferred message' }
CpGlobalThis class >> defer: aBlock [

	"Evaluate the specified Block with the smallest delay (at least one tick).

	Implementation:
	Since execution of Blocks is handled synchronously when used as JavaScript
	function, the Block will be executed synchronously here. If you prefer a
	more relaxed execution please use `[ ... ] fork`."

	self setTimeout: 0 thenDo: aBlock
]

{ #category : #'deferred message' }
CpGlobalThis class >> deferLongRunning: aBlock [

	"Evaluate the specified Block with the smallest delay.
	Assuming the Block is long running, perform it in its own Process.
	See also #defer:"

	aBlock fork
]

{ #category : #operations }
CpGlobalThis class >> encodeURI: aString [

	"Answer a new string representing the provided string encoded as a URI"

	^ self apply: #encodeURI withArguments: { aString }
]

{ #category : #operations }
CpGlobalThis class >> encodeURIComponent: aString [

	"Answer a new string representing the provided uriComponent encoded as a URI component"

	^ self apply: #encodeURIComponent withArguments: { aString }
]

{ #category : #operations }
CpGlobalThis class >> fetch: aString withOptions: aDictionary [

	"Fetch the resource using the specified URL string.

	Options is an object containing any custom settings that you want to apply to the request. The possible options are:

	method
		The request method, e.g., ""GET"", ""POST"". The default is ""GET"". Note that the Origin header is not set on Fetch requests with a method of HEAD or GET. (This behavior was corrected in Firefox 65 — see Firefox bug 1508661.) Any string which is a case-insensitive match for one of the methods in RFC 9110 will be uppercased automatically. If you want to use a custom method (like PATCH), you should uppercase it yourself.

	headers
		Any headers you want to add to your request, contained within a Headers object or an object literal with String values. Note that some names are forbidden.

		Note: The Authorization HTTP header may be added to a request, but will be removed if the request is redirected cross-origin.

	body
		Any body that you want to add to your request: this can be a Blob, an ArrayBuffer, a TypedArray, a DataView, a FormData, a URLSearchParams, string object or literal, or a ReadableStream object. This latest possibility is still experimental; check the compatibility information to verify you can use it. Note that a request using the GET or HEAD method cannot have a body.

	mode
		The mode you want to use for the request, e.g., cors, no-cors, or same-origin.

	credentials
		Controls what browsers do with credentials (cookies, HTTP authentication entries, and TLS client certificates). Must be one of the following strings:

		omit
			Tells browsers to exclude credentials from the request, and ignore any credentials sent back in the response (e.g., any Set-Cookie header).
		same-origin
			Tells browsers to include credentials with requests to same-origin URLs, and use any credentials sent back in responses from same-origin URLs. This is the default value.
		include
			Tells browsers to include credentials in both same- and cross-origin requests, and always use any credentials sent back in responses.

		Note: Credentials may be included in simple and ""final"" cross-origin requests, but should not be included in CORS preflight requests.

	cache
		A string indicating how the request will interact with the browser's HTTP cache. The possible values, default, no-store, reload, no-cache, force-cache, and only-if-cached, are documented in the article for the cache property of the Request object.

	redirect
		How to handle a redirect response:

		follow
			Automatically follow redirects. Unless otherwise stated the redirect mode is set to follow.
		error
			Abort with an error if a redirect occurs.
		manual
			Caller intends to process the response in another context. See WHATWG fetch standard for more information.

	referrer
		A string specifying the referrer of the request. This can be a same-origin URL, about:client, or an empty string.

	referrerPolicy
		Specifies the referrer policy to use for the request. May be one of no-referrer, no-referrer-when-downgrade, same-origin, origin, strict-origin, origin-when-cross-origin, strict-origin-when-cross-origin, or unsafe-url.

	integrity
		Contains the subresource integrity value of the request (e.g., sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE=).

	keepalive
		The keepalive option can be used to allow the request to outlive the page. Fetch with the keepalive flag is a replacement for the Navigator.sendBeacon() API.

	signal
		An AbortSignal object instance; allows you to communicate with a fetch request and abort it if desired via an AbortController.

	priority
		Specifies the priority of the fetch request relative to other requests of the same type. Must be one of the following strings:

		high
			A high priority fetch request relative to other requests of the same type.
		low
			A low priority fetch request relative to other requests of the same type.
		auto
			Automatically determine the priority of the fetch request relative to other requests of the same type (default)."

	<ignoreReference: #CpJavaScriptPromise>

	^ self apply: #fetch withArguments: { aString . aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpGlobalThis class >> globalThis [

	"Answer the globalThis instance. This will NOT be an instance of the receiver.
	In a web browser this will result in an instance of CpBrowserWindow and in a
	Node.js environment this will be an instance of CpJavaScriptObject."

	^ GlobalThis ifNil: [ GlobalThis := CpJavaScriptObject global ]
]

{ #category : #'class initialization' }
CpGlobalThis class >> preSnapshotOnce [

	GlobalThis := nil
]

{ #category : #accessing }
CpGlobalThis class >> propertyAt: aSymbol [

	"Get the property from the global JavaScript object.
	In line with regular JavaScript this will either answer the
	property value or nil if such a property does not exist or
	its value is null or undefined.

	This method is more forgiving than #apply: since it will just
	answer nil if not present, instead of raising an error."

	^ self propertyAt: aSymbol resultAs: nil
]

{ #category : #accessing }
CpGlobalThis class >> propertyAt: aSymbol put: anObject [

	"Set the property of the global JavaScript object to the specified value.
	In line with regular JavaScript this will set or create a property with the
	given value.

	This method is more forgiving than #apply:witArguments: since it will just
	add a property if not present, instead of raising an error.

	Implementation:
	Convert Smalltalk Blocks to JavaScript functions if necessary.
	See also CpJavaScriptFunction class >> #wrap:"

	self globalThis
		propertyAt: aSymbol put: anObject
]

{ #category : #accessing }
CpGlobalThis class >> propertyAt: aSymbol resultAs: aProxyClass [

	"Get the property from the global JavaScript object.
	In line with regular JavaScript this will either answer the
	property value or nil if such a property does not exist or
	its value is null or undefined.

	This method is more forgiving than #apply: since it will just
	answer nil if not present, instead of raising an error.
	
	If a proxy Class is specified and the result is an object
	(i.e. not undefined or null) it will be proxied."

	^ self globalThis
		propertyAt: aSymbol resultAs: aProxyClass
]

{ #category : #accessing }
CpGlobalThis class >> rawPropertyAt: aSymbol [

	"Answer the raw property value (i.e. without JavaScript conversion).
	If the property has no value, nil will be answered.
	If the specified property is not a Smalltalk object, the primitive
	will fail."

	^ self globalThis
		rawPropertyAt: aSymbol
]

{ #category : #accessing }
CpGlobalThis class >> rawPropertyAt: aSymbol put: anObject [

	"Set the property with the specified raw value (i.e. without JavaScript conversion)"

	self globalThis
		rawPropertyAt: aSymbol put: anObject
]

{ #category : #operations }
CpGlobalThis class >> setTimeout: anInteger thenDo: aBlock [

	"Set a timeout (in milliseconds) before performing the specified Block.
	An integer is answered to identify this timeout. It can be
	used to stop the timeout using #clearTimeout."

	^ self apply: #setTimeout withArguments: { aBlock asJavaScriptFunction . anInteger }
]
