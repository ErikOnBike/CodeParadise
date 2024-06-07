Class {
	#name : #CpJsonInstVarFieldMapping,
	#superclass : #CpJsonFieldMapping,
	#instVars : [
		'instVarName'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonInstVarFieldMapping class >> instVarName: aSymbol jsonFieldName: aString [

	^ self basicNew
		initializeWithInstVarName: aSymbol jsonFieldName: aString ;
		yourself
]

{ #category : #initialization }
CpJsonInstVarFieldMapping >> initializeWithInstVarName: aSymbol jsonFieldName: aString [

	self initializeWithJsonFieldName: aString.

	instVarName := aSymbol
]

{ #category : #accessing }
CpJsonInstVarFieldMapping >> setValue: valueObject inObject: anObject [

	anObject instVarNamed: instVarName put: valueObject
]

{ #category : #accessing }
CpJsonInstVarFieldMapping >> valueFromObject: anObject [

	^ anObject instVarNamed: instVarName
]
