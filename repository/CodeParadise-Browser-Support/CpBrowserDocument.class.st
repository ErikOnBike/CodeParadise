Class {
	#name : #CpBrowserDocument,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserDocument class >> current [

	"Answer the current document.

	Implementation:
	To prevent too many dependencies, retrieve the value from the global object
	(instead of asking the CpBrowserWindow for it)."

	^ self wrap: (CpJavaScriptObject global propertyAt: #document)
]

{ #category : #'instance creation' }
CpBrowserDocument class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #testing }
CpBrowserDocument >> isVisible [

	^ self visibilityState = #visible
]

{ #category : #accessing }
CpBrowserDocument >> location [

	"Returns the URI of the current document."

	^ self propertyAt: #location
]

{ #category : #accessing }
CpBrowserDocument >> title [

	^ self propertyAt: #title
]

{ #category : #accessing }
CpBrowserDocument >> title: aString [

	self propertyAt: #title put: aString
]

{ #category : #accessing }
CpBrowserDocument >> url [

	"Convenience method to answer the receiver's URL as an Object (instead of String).
	See also: #urlString."

	^ CpBrowserURL newUrl: self urlString
]

{ #category : #accessing }
CpBrowserDocument >> urlString [

	"The URL read-only property of the Document interface returns the document location as a string"

	^ self propertyAt: #URL
]

{ #category : #accessing }
CpBrowserDocument >> visibilityState [

	"Returns a string denoting the visibility state of the document. Possible values are visible, hidden, prerender, and unloaded."

	^ self propertyAt: #visibilityState
]
