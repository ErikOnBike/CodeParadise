Class {
	#name : #CpBrowserCustomElementRegistry,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserCustomElementRegistry class >> current [

	"Answer the current custom element registry.

	Implementation:
	To prevent too many dependencies, retrieve the value from the global object
	(instead of asking the CpBrowserWindow for it)."

	^ self wrap: (CpJavaScriptObject global propertyAt: #customElements)
]

{ #category : #'instance creation' }
CpBrowserCustomElementRegistry class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #operations }
CpBrowserCustomElementRegistry >> whenDefined: aString [

	"Returns an empty Promise that resolves when a custom element becomes defined with the given name. If such a custom element is already defined, the returned promise is immediately fulfilled."

	^ self apply: #whenDefined withArguments: { aString } resultAs: CpJavaScriptPromise
]
