Class {
	#name : #CpBrowserRequest,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Fetch'
}

{ #category : #'instance creation' }
CpBrowserRequest class >> input: aStringOrRequest [

	^ self input: aStringOrRequest options: Dictionary new
]

{ #category : #'instance creation' }
CpBrowserRequest class >> input: aStringOrRequest options: aDictionary [

	"Answer a new instance of the receiver.

	See also: https://developer.mozilla.org/en-US/docs/Web/API/RequestInit"

	^ self newInstanceWithArguments: { aStringOrRequest . aDictionary }
]

{ #category : #operations }
CpBrowserRequest >> arrayBuffer [

	"Returns a promise that resolves with an ArrayBuffer representation of the request body"

	^ self apply: #arrayBuffer resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserRequest >> blob [

	"Returns a promise that resolves with a Blob representation of the request body"

	^ self apply: #blob resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRequest >> body [

	"A ReadableStream of the body contents"

	^ self propertyAt: #body resultAs: CpBrowserReadableStream
]

{ #category : #accessing }
CpBrowserRequest >> bodyUsed [

	"Stores true or false to indicate whether or not the body has been used in a request yet"

	^ self propertyAt: #bodyUsed
]

{ #category : #operations }
CpBrowserRequest >> bytes [

	"Returns a promise that resolves with a Uint8Array representation of the request body"

	^ self apply: #bytes resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRequest >> cache [

	"Contains the cache mode of the request (e.g., default, reload, no-cache)"

	^ self propertyAt: #cache
]

{ #category : #operations }
CpBrowserRequest >> clone [

	"Creates a copy of the current Request object"

	^ self apply: #clone resultAs: self class
]

{ #category : #accessing }
CpBrowserRequest >> credentials [

	"Contains the credentials of the request (e.g., omit, same-origin, include). The default is same-origin."

	^ self propertyAt: #credentials
]

{ #category : #accessing }
CpBrowserRequest >> destination [

	"A string describing the type of content being requested"

	^ self propertyAt: #destination
]

{ #category : #operations }
CpBrowserRequest >> formData [

	"Returns a promise that resolves with a FormData representation of the request body"

	^ self apply: #formData resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRequest >> headers [

	"Contains the associated Headers object of the request"

	^ self propertyAt: #headers resultAs: CpBrowserHeaders
]

{ #category : #accessing }
CpBrowserRequest >> integrity [

	"Contains the subresource integrity value of the request (e.g., sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE=)"

	^ self propertyAt: #integrity
]

{ #category : #operations }
CpBrowserRequest >> json [

	"Returns a promise that resolves with the result of parsing the request body as JSON"

	^ self apply: #json resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRequest >> method [

	"Contains the request's method (GET, POST, etc.)"

	^ self propertyAt: #method
]

{ #category : #accessing }
CpBrowserRequest >> mode [

	"Contains the mode of the request (e.g., cors, no-cors, same-origin, navigate)"

	^ self propertyAt: #mode
]

{ #category : #accessing }
CpBrowserRequest >> redirect [

	"Contains the mode for how redirects are handled. It may be one of follow, error, or manual."

	^ self propertyAt: #redirect
]

{ #category : #accessing }
CpBrowserRequest >> referrer [

	"Contains the referrer of the request (e.g., client)"

	^ self propertyAt: #referrer
]

{ #category : #accessing }
CpBrowserRequest >> referrerPolicy [

	"Contains the referrer policy of the request (e.g., no-referrer)"

	^ self propertyAt: #referrerPolicy
]

{ #category : #accessing }
CpBrowserRequest >> signal [

	"Returns the AbortSignal associated with the request"

	^ self propertyAt: #signal resultAs: CpJavaScriptAbortSignal
]

{ #category : #operations }
CpBrowserRequest >> text [

	"Returns a promise that resolves with a text representation of the request body"

	^ self apply: #text resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserRequest >> url [

	"Contains the URL of the request."

	^ self propertyAt: #url
]
