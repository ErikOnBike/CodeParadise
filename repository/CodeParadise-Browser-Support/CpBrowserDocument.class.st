Class {
	#name : 'CpBrowserDocument',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-Core',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'Core'
}

{ #category : 'accessing' }
CpBrowserDocument class >> current [

	"Answer the current document.

	Implementation:
	To prevent to many dependencies, retrieve the value from the global object
	(instead of asking the CpBrowserWindow for it)."

	^ self wrap: (CpJavaScriptObject global propertyAt: #document)
]

{ #category : 'instance creation' }
CpBrowserDocument class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using the selector ', #current
]

{ #category : 'testing' }
CpBrowserDocument >> isVisible [

	^ self visibilityState = #visible
]

{ #category : 'accessing' }
CpBrowserDocument >> visibilityState [

	"Returns a string denoting the visibility state of the document. Possible values are visible, hidden, prerender, and unloaded."

	^ self propertyAt: #visibilityState
]
