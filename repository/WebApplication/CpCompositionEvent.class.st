Class {
	#name : #CpCompositionEvent,
	#superclass : #CpEvent,
	#instVars : [
		'data'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpCompositionEvent class >> newFrom: aDictionary [

	^ (super newFrom: aDictionary)
		data: (aDictionary at: #data ifAbsent: [ nil ]) ;
		yourself
]

{ #category : #accessing }
CpCompositionEvent class >> type [

	^ #composition
]

{ #category : #accessing }
CpCompositionEvent >> data [

	^ data
]

{ #category : #accessing }
CpCompositionEvent >> data: aString [

	data := aString
]

{ #category : #printing }
CpCompositionEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ', data: '.
	self data printOn: aStream
]
