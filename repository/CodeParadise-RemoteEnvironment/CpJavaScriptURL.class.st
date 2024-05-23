Class {
	#name : #CpJavaScriptUrl,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptUrl class >> canParse: aString [

	"Returns a boolean indicating whether or not a URL defined from a URL string and optional base URL string is parsable and valid."

	^ self canParse: aString base: nil
]

{ #category : #operations }
CpJavaScriptUrl class >> canParse: urlString base: baseString [

	"Returns a boolean indicating whether or not a URL defined from a URL string and optional base URL string is parsable and valid."

	^ self apply: #canParse withArguments: { urlString . baseString }
]

{ #category : #operations }
CpJavaScriptUrl class >> createObjectURL: anObject [

	"Returns a string containing a unique blob URL, that is a URL with blob: as its scheme, followed by an opaque string uniquely identifying the object in the browser."

	^ self apply: #createObjectURL withArguments: { anObject }
]

{ #category : #'instance creation' }
CpJavaScriptUrl class >> newUrl: aString [

	"Creates and returns a URL object referencing the URL specified using an absolute URL string, or a relative URL string and a base URL string."

	^ self newUrl: aString base: nil
]

{ #category : #'instance creation' }
CpJavaScriptUrl class >> newUrl: urlString base: baseString [

	"Creates and returns a URL object referencing the URL specified using an absolute URL string, or a relative URL string and a base URL string."

	^ self newInstanceWithArguments: { urlString . baseString }
]

{ #category : #operations }
CpJavaScriptUrl class >> revokeObjectURL: aString [

	"Revokes an object URL previously created using URL.createObjectURL()."

	^ self apply: #revokeObjectURL withArguments: { aString }
]

{ #category : #accessing }
CpJavaScriptUrl >> host [

	"A string containing the domain (that is the hostname) followed by (if a port was specified) a ':' and the port of the URL."

	^ self propertyAt: #host
]

{ #category : #accessing }
CpJavaScriptUrl >> host: aString [

	"A string containing the domain (that is the hostname) followed by (if a port was specified) a ':' and the port of the URL."

	self propertyAt: #host put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> hostname [

	"A string containing the domain of the URL."

	^ self propertyAt: #hostname
]

{ #category : #accessing }
CpJavaScriptUrl >> hostname: aString [

	"A string containing the domain of the URL."

	self propertyAt: #hostname put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> href [

	"A stringifier that returns a string containing the whole URL."

	^ self propertyAt: #href
]

{ #category : #accessing }
CpJavaScriptUrl >> href: aString [

	"A stringifier that returns a string containing the whole URL."

	self propertyAt: #href put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> origin [

	"Returns a string containing the origin of the URL, that is its scheme, its domain and its port."

	^ self propertyAt: #origin
]

{ #category : #accessing }
CpJavaScriptUrl >> password [

	"A string containing the password specified before the domain name."

	^ self propertyAt: #password
]

{ #category : #accessing }
CpJavaScriptUrl >> password: aString [

	"A string containing the password specified before the domain name."

	self propertyAt: #password put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> pathname [

	"A string containing an initial '/' followed by the path of the URL, not including the query string or fragment."

	^ self propertyAt: #pathname
]

{ #category : #accessing }
CpJavaScriptUrl >> pathname: aString [

	"A string containing an initial '/' followed by the path of the URL, not including the query string or fragment."

	self propertyAt: #pathname put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> port [

	"A string containing the port number of the URL."

	^ self propertyAt: #port
]

{ #category : #accessing }
CpJavaScriptUrl >> port: aString [

	"A string containing the port number of the URL."

	self propertyAt: #port put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> protocol [

	"A string containing the protocol scheme of the URL, including the final ':'."

	^ self propertyAt: #protocol
]

{ #category : #accessing }
CpJavaScriptUrl >> protocol: aString [

	"A string containing the protocol scheme of the URL, including the final ':'."

	self propertyAt: #protocol put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> search [

	"A string indicating the URL's parameter string; if any parameters are provided, this string includes all of them, beginning with the leading ? character."

	^ self propertyAt: #search
]

{ #category : #accessing }
CpJavaScriptUrl >> search: aString [

	"A string indicating the URL's parameter string; if any parameters are provided, this string includes all of them, beginning with the leading ? character."

	self propertyAt: #search put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> searchParams [

	"A URLSearchParams object which can be used to access the individual query parameters found in search."

	^ self propertyAt: #searchParams
]

{ #category : #accessing }
CpJavaScriptUrl >> urlHash [

	"A string containing a '#' followed by the fragment identifier of the URL.

	(Renamed from #hash because of name clash)"

	^ self propertyAt: #hash
]

{ #category : #accessing }
CpJavaScriptUrl >> urlHash: aString [

	"A string containing a '#' followed by the fragment identifier of the URL.

	(Renamed from #hash because of name clash)"

	self propertyAt: #hash put: aString
]

{ #category : #accessing }
CpJavaScriptUrl >> username [

	"A string containing the username specified before the domain name."

	^ self propertyAt: #username
]

{ #category : #accessing }
CpJavaScriptUrl >> username: aString [

	"A string containing the username specified before the domain name."

	self propertyAt: #username put: aString
]
