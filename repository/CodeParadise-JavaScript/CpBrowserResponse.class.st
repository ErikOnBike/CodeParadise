"
I represent both the Browser Response and the Node.js Response.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserResponse,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserResponse class >> body: anObject [

	^ self body: anObject options: Dictionary new
]

{ #category : #'instance creation' }
CpBrowserResponse class >> body: anObject options: aDictionary [

	"Answer a new instance of the receiver.

	See also: https://developer.mozilla.org/en-US/docs/Web/API/Response/Response"

	^ self newInstanceWithArguments: { anObject . aDictionary }
]

{ #category : #'instance creation' }
CpBrowserResponse class >> error [

	"Returns a new Response object associated with a network error"

	^ self apply: #error resultAs: self
]

{ #category : #'instance creation' }
CpBrowserResponse class >> json: anObject [

	"Returns a new Response object for returning the provided JSON encoded data"

	^ self apply: #json withArguments: { anObject } resultAs: self
]

{ #category : #'instance creation' }
CpBrowserResponse class >> json: anObject options: aDictionary [

	"Returns a new Response object for returning the provided JSON encoded data"

	^ self apply: #json withArguments: { anObject . aDictionary } resultAs: self
]

{ #category : #'instance creation' }
CpBrowserResponse class >> redirect: aString [

	"Returns a new response with a different URL"

	^ self apply: #redirect withArguments: { aString } resultAs: self
]

{ #category : #'instance creation' }
CpBrowserResponse class >> redirect: aString status: anInteger [

	"Returns a new response with a different URL"

	^ self apply: #redirect withArguments: { aString . anInteger } resultAs: self
]

{ #category : #operations }
CpBrowserResponse >> arrayBuffer [

	"Returns a promise that resolves with an ArrayBuffer representation of the response body"

	^ self apply: #arrayBuffer resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserResponse >> blob [

	"Returns a promise that resolves with a Blob representation of the response body"

	^ self apply: #blob resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserResponse >> body [

	"A ReadableStream of the body contents"

	^ self propertyAt: #body resultAs: CpBrowserReadableStream
]

{ #category : #accessing }
CpBrowserResponse >> bodyUsed [

	"Stores a boolean value that declares whether the body has been used in a response yet"

	^ self propertyAt: #bodyUsed
]

{ #category : #operations }
CpBrowserResponse >> bytes [

	"Returns a promise that resolves with a Uint8Array representation of the response body"

	^ self apply: #bytes resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpBrowserResponse >> clone [

	"Creates a clone of a Response object"

	^ self apply: #clone resultAs: self class
]

{ #category : #operations }
CpBrowserResponse >> formData [

	"Returns a promise that resolves with a FormData representation of the response body"

	^ self apply: #formData resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserResponse >> headers [

	"The Headers object associated with the response"

	^ self propertyAt: #headers resultAs: CpBrowserHeaders
]

{ #category : #operations }
CpBrowserResponse >> json [

	"Returns a promise that resolves with the result of parsing the response body text as JSON"

	^ self apply: #json resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserResponse >> ok [

	"A boolean indicating whether the response was successful (status in the range 200 – 299) or not"

	^ self propertyAt: #ok
]

{ #category : #accessing }
CpBrowserResponse >> redirected [

	"Indicates whether or not the response is the result of a redirect (that is, its URL list has more than one entry)"

	^ self propertyAt: #redirected
]

{ #category : #accessing }
CpBrowserResponse >> status [

	"The status code of the response. (This will be 200 for a success)"

	^ self propertyAt: #status
]

{ #category : #accessing }
CpBrowserResponse >> statusText [

	"The status message corresponding to the status code. (e.g., OK for 200)"

	^ self propertyAt: #statusText
]

{ #category : #operations }
CpBrowserResponse >> text [

	"Returns a promise that resolves with a text representation of the response body"

	^ self apply: #text resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserResponse >> type [

	"The type of the response (e.g., basic, cors)"

	^ self propertyAt: #type
]

{ #category : #accessing }
CpBrowserResponse >> url [

	"The URL of the response"

	^ self propertyAt: #url
]
