Class {
	#name : #CpJsonObjectMapping,
	#superclass : #Object,
	#instVars : [
		'fieldMappings'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonObjectMapping class >> fieldMappings: aCollection [

	"Answer an instance of the receiver with the specified collection of FieldMappings"

	^ self new
		addAll: aCollection ;
		yourself
]

{ #category : #adding }
CpJsonObjectMapping >> add: aFieldMapping [

	"Add the specified FieldMapping to the receiver"

	^ fieldMappings add: aFieldMapping
]

{ #category : #adding }
CpJsonObjectMapping >> addAll: aCollection [

	"Add the specified collection of FieldMappings to the receiver"

	^ fieldMappings addAll: aCollection
]

{ #category : #copying }
CpJsonObjectMapping >> copyFromJson: aDictionary toObject: anObject [

	"Copy the fields (specified by the receiver) in the specified JSON object to the object"

	fieldMappings do: [ :each |
		each copyFromJson: aDictionary toObject: anObject ]
]

{ #category : #copying }
CpJsonObjectMapping >> copyFromObject: anObject toJson: aDictionary [

	"Copy the fields (specified by the receiver) in the specified object to the JSON object"

	fieldMappings do: [ :each |
		each copyFromObject: anObject toJson: aDictionary ]
]

{ #category : #initialization }
CpJsonObjectMapping >> initialize [

	super initialize.

	"Use an OrderedCollection to allow the order of the JSON fields to be specified by
	the order in which field mappings are added"
	fieldMappings := OrderedCollection new
]
