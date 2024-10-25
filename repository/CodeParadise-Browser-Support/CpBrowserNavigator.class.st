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
