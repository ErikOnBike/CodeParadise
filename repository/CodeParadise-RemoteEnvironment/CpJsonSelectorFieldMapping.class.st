Class {
	#name : #CpJsonSelectorFieldMapping,
	#superclass : #CpJsonFieldMapping,
	#instVars : [
		'getSelector',
		'setSelector'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonSelectorFieldMapping class >> get: aSymbol jsonFieldName: aString [

	^ self get: aSymbol set: nil jsonFieldName: aString
]

{ #category : #'instance creation' }
CpJsonSelectorFieldMapping class >> get: getSymbol set: setSymbol jsonFieldName: aString [

	^ self basicNew
		initializeWithGet: getSymbol set: setSymbol jsonFieldName: aString ;
		yourself
]

{ #category : #initialization }
CpJsonSelectorFieldMapping >> initializeWithGet: getSymbol set: setSymbol jsonFieldName: aString [

	self initializeWithJsonFieldName: aString.

	getSelector := getSymbol.
	setSelector := setSymbol
]

{ #category : #accessing }
CpJsonSelectorFieldMapping >> setValue: valueObject inObject: anObject [

	anObject perform: setSelector withArguments: { valueObject }
]

{ #category : #accessing }
CpJsonSelectorFieldMapping >> valueFromObject: anObject [

	^ anObject perform: getSelector
]
