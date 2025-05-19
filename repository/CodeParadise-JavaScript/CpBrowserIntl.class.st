"
I represent the Intl namespace in Browser and Node.js.
"
Class {
	#name : #CpBrowserIntl,
	#superclass : #CpJavaScriptObject,
	#classVars : [
		'Namespace'
	],
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'class initialization' }
CpBrowserIntl class >> namespace [

	"Answer a namespace (instance) of the receiver"

	^ Namespace ifNil: [
		Namespace := CpJavaScriptObject global
			getClassRefFrom: self getClassName resultAs: self ]
]

{ #category : #'class initialization' }
CpBrowserIntl class >> preSnapshotOnce [

	Namespace := nil
]

{ #category : #accessing }
CpBrowserIntl >> getClass: aClass [

	"Answer the JavaScript class for the specified Smalltalk class.
	The specified Class is assumed to be one of the receiver's classes.

	Implementation:
	Since the receiver is a namespace, the classes are properties on it."

	^ self propertyAt: aClass getClassName resultAs: CpJavaScriptClass
]
