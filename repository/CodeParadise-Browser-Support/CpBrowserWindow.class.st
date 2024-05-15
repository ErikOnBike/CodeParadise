Class {
	#name : 'CpBrowserWindow',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-Core',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'Core'
}

{ #category : 'accessing' }
CpBrowserWindow class >> current [

	"The Window object is the global object in the Browser"

	^ CpJavaScriptObject global
]

{ #category : 'instance creation' }
CpBrowserWindow class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using the selector ', #current
]

{ #category : 'operations' }
CpBrowserWindow >> print [

	"Opens the print dialog to print the current document."

	self apply: #print
]
