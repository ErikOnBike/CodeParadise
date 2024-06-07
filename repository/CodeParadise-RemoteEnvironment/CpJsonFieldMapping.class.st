Class {
	#name : #CpJsonFieldMapping,
	#superclass : #Object,
	#instVars : [
		'jsonFieldName'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonFieldMapping class >> jsonFieldName: aString [

	^ self basicNew
		initializeWithJsonFieldName: aString ;
		yourself
]

{ #category : #copying }
CpJsonFieldMapping >> copyFromJson: aDictionary toObject: anObject [

	"Copy the value of the field (specified by the receiver) in the specified JSON object to the object"

	self setValue: (self valueFromJson: aDictionary) inObject: anObject
]

{ #category : #copying }
CpJsonFieldMapping >> copyFromObject: anObject toJson: aDictionary [

	"Copy the value of the field (specified by the receiver) in the specified object to the JSON object"

	self setValue: (self valueFromObject: anObject) inJson: aDictionary
]

{ #category : #initialization }
CpJsonFieldMapping >> initializeWithJsonFieldName: aString [

	self initialize.

	jsonFieldName := aString
]

{ #category : #accessing }
CpJsonFieldMapping >> setValue: anObject inJson: aDictionary [

	"Set the specified value of the field (specified by the receiver) in the specified object.

	The JSON object can be any Dictionary like object (Dictionay, OrderedDictionary,
	CpJsonObject, etc)"

	^ aDictionary at: jsonFieldName put: anObject
]

{ #category : #accessing }
CpJsonFieldMapping >> setValue: valueObject inObject: anObject [

	"Set the specified value of the field (specified by the receiver) in the specified object"

	self subclassResponsibility
]

{ #category : #accessing }
CpJsonFieldMapping >> valueFromJson: aDictionary [

	"Answer the value of the field (specified by the receiver) in the specified JSON object.

	The JSON object can be any Dictionary like object (Dictionay, OrderedDictionary,
	CpJsonObject, etc)"

	^ aDictionary at: jsonFieldName ifAbsent: [ nil ]
]

{ #category : #accessing }
CpJsonFieldMapping >> valueFromObject: anObject [

	"Answer the value of the field (specified by the receiver) in the specified object"

	self subclassResponsibility
]
