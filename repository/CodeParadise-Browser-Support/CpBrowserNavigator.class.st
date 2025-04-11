Class {
	#name : #CpBrowserNavigator,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Navigator'
}

{ #category : #accessing }
CpBrowserNavigator class >> current [

	"Answer an instance of the receiver"

	^ CpBrowserWindow current
		apply: #navigator resultAs: self
]

{ #category : #'instance creation' }
CpBrowserNavigator class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #accessing }
CpBrowserNavigator >> language [

	"Returns a string representing the preferred language of the user, usually the language of the browser UI. The null value is returned when this is unknown."

	^ self propertyAt: #language
]

{ #category : #accessing }
CpBrowserNavigator >> languages [

	"Returns an array of strings representing the languages known to the user, by order of preference."

	^ self propertyAt: #languages
]

{ #category : #accessing }
CpBrowserNavigator >> onLine [

	^ self propertyAt: #onLine
]

{ #category : #'beacon api' }
CpBrowserNavigator >> sendBeacon: aString data: anObject [

	"The method takes two arguments, the URL and the data to send in the request. The data argument is optional and its type may be a string, an ArrayBuffer, a TypedArray, a DataView, a ReadableStream, a Blob, a FormData object, or a URLSearchParams object. If the browser successfully queues the request for delivery, the method returns true; otherwise, it returns false."

	^ self apply: #sendBeacon withArguments: { aString . anObject }
]
