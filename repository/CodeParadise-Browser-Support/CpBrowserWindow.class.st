Class {
	#name : #CpBrowserWindow,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #printing }
CpBrowserWindow >> print [

	"Opens the print dialog to print the current document."

	self apply: #print
]
