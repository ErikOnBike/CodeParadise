Class {
	#name : #CpJsonBlockFieldMapping,
	#superclass : #CpJsonFieldMapping,
	#instVars : [
		'readBlock',
		'writeBlock'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonBlockFieldMapping class >> read: readBlock write: writeBlock jsonFieldName: aString [

	^ self basicNew
		initializeWithRead: readBlock write: writeBlock jsonFieldName: aString ;
		yourself
]

{ #category : #initialization }
CpJsonBlockFieldMapping >> initializeWithRead: getBlock write: setBlock jsonFieldName: aString [

	self initializeWithJsonFieldName: aString.

	readBlock := getBlock.
	writeBlock := setBlock
]

{ #category : #accessing }
CpJsonBlockFieldMapping >> setValue: valueObject inObject: anObject [

	writeBlock value: anObject value: valueObject
]

{ #category : #accessing }
CpJsonBlockFieldMapping >> valueFromObject: anObject [

	^ readBlock value: anObject
]
