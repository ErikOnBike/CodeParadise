Class {
	#name : #CpBrowserLocation,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserLocation >> hashString [

	"A string containing a '#' followed by the fragment identifier of the URL."

	^ self propertyAt: #hash
]

{ #category : #accessing }
CpBrowserLocation >> hashString: aString [

	"A string containing a '#' followed by the fragment identifier of the URL."

	self propertyAt: #hash put: aString
]

{ #category : #accessing }
CpBrowserLocation >> host [

	"A string containing the host, that is the hostname, a ':', and the port of the URL."

	^ self propertyAt: #host
]

{ #category : #accessing }
CpBrowserLocation >> host: aString [

	"A string containing the host, that is the hostname, a ':', and the port of the URL."

	self propertyAt: #host put: aString
]

{ #category : #accessing }
CpBrowserLocation >> hostname [

	"A string containing the domain of the URL."

	^ self propertyAt: #hostname
]

{ #category : #accessing }
CpBrowserLocation >> hostname: aString [

	"A string containing the domain of the URL."

	self propertyAt: #hostname put: aString
]

{ #category : #accessing }
CpBrowserLocation >> href [

	"A stringifier that returns a string containing the entire URL. If changed, the associated document navigates to the new page. It can be set from a different origin than the associated document."

	^ self propertyAt: #href
]

{ #category : #accessing }
CpBrowserLocation >> href: aString [

	"A stringifier that returns a string containing the entire URL. If changed, the associated document navigates to the new page. It can be set from a different origin than the associated document."

	self propertyAt: #href put: aString
]

{ #category : #accessing }
CpBrowserLocation >> origin [

	"Returns a string containing the canonical form of the origin of the specific location."

	^ self propertyAt: #origin
]

{ #category : #accessing }
CpBrowserLocation >> pathname [

	"A string containing an initial '/' followed by the path of the URL, not including the query string or fragment."

	^ self propertyAt: #pathname
]

{ #category : #accessing }
CpBrowserLocation >> pathname: aString [

	"A string containing an initial '/' followed by the path of the URL, not including the query string or fragment."

	self propertyAt: #pathname put: aString
]

{ #category : #accessing }
CpBrowserLocation >> port [

	"A string containing the port number of the URL."

	^ self propertyAt: #port
]

{ #category : #accessing }
CpBrowserLocation >> port: aString [

	"A string containing the port number of the URL."

	self propertyAt: #port put: aString
]

{ #category : #accessing }
CpBrowserLocation >> protocol [

	"A string containing the protocol scheme of the URL, including the final ':'."

	^ self propertyAt: #protocol
]

{ #category : #accessing }
CpBrowserLocation >> protocol: aString [

	"A string containing the protocol scheme of the URL, including the final ':'."

	self propertyAt: #protocol put: aString
]

{ #category : #operations }
CpBrowserLocation >> reload [

	"Reloads the current URL, like the Refresh button"

	self apply: #reload
]

{ #category : #accessing }
CpBrowserLocation >> search [

	"A string containing a '?' followed by the parameters or ""querystring"" of the URL. Modern browsers provide URLSearchParams and URL.searchParams to make it easy to parse out the parameters from the querystring."

	^ self propertyAt: #search
]

{ #category : #accessing }
CpBrowserLocation >> search: aString [

	"A string containing a '?' followed by the parameters or ""querystring"" of the URL. Modern browsers provide URLSearchParams and URL.searchParams to make it easy to parse out the parameters from the querystring."

	self propertyAt: #search put: aString
]
