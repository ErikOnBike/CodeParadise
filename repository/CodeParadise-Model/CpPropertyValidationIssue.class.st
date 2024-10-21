"
I am responsible for keeping track of a property name and its validation issue (a message).
"
Class {
	#name : #CpPropertyValidationIssue,
	#superclass : #Object,
	#instVars : [
		'name',
		'issue'
	],
	#category : #'CodeParadise-Model-Support'
}

{ #category : #'as yet unclassified' }
CpPropertyValidationIssue class >> name: aSymbol issue: aString [

	^ self basicNew
		initializeWithName: aSymbol issue: aString ;
		yourself
]

{ #category : #initialization }
CpPropertyValidationIssue >> initializeWithName: aSymbol issue: aString [

	self initialize.

	name := aSymbol.
	issue := aString
]

{ #category : #accessing }
CpPropertyValidationIssue >> issue [

	^ issue
]

{ #category : #accessing }
CpPropertyValidationIssue >> name [

	^ name
]
