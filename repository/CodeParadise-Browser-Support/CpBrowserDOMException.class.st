Class {
	#name : #CpBrowserDOMException,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserDOMException >> cause [

	"A DOM Exception does not know an underlying cause"

	^ nil
]

{ #category : #testing }
CpBrowserDOMException >> isErrorObject [

	"Answer whether the receiver represents an Error"

	^ true
]

{ #category : #accessing }
CpBrowserDOMException >> message [

	"Returns a string representing a message or description associated with the given error name"

	^ self propertyAt: #message
]

{ #category : #accessing }
CpBrowserDOMException >> name [

	"Returns a string that contains one of the strings associated with an error name"

	^ self propertyAt: #name
]

{ #category : #accessing }
CpBrowserDOMException >> rootCause [

	"Answer the 'lowest' cause (an Error object) of the receiver"

	^ self
]

{ #category : #accessing }
CpBrowserDOMException >> rootException [

	"Answer the 'lowest' exception of the receiver"

	^ self
]

{ #category : #signalling }
CpBrowserDOMException >> signal [

	"Signal the receiver"

	Error signal: 'Error in JavaScript' withTag: self
]
