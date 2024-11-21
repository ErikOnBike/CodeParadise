Class {
	#name : #CpJsonObject,
	#superclass : #OrderedDictionary,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJsonObject class >> fromOrderedDictionary: anOrderedDictionary [

	^ self basicNew
		initializeWithOrderedDictionary: anOrderedDictionary ;
		yourself
]

{ #category : #'instance creation' }
CpJsonObject class >> fromString: aString [

	^ self fromOrderedDictionary: (CpJavaScriptJSON parse: aString)
]

{ #category : #adding }
CpJsonObject >> add: anAssociation [

	^ super add: anAssociation key asString -> anAssociation value
]

{ #category : #accessing }
CpJsonObject >> at: anObject [

	^ self at: anObject ifAbsent: [ nil ]
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifAbsent: aBlock [

	^ super at: anObject asString ifAbsent: aBlock
]

{ #category : #accessing }
CpJsonObject >> at: anObject ifAbsentPut: aBlock [

	^ super at: anObject asString ifAbsentPut: aBlock
]

{ #category : #accessing }
CpJsonObject >> at: keyObject put: valueObject [

	^ super at: keyObject asString put: valueObject
]

{ #category : #'reflective operations' }
CpJsonObject >> doesNotUnderstand: aMessage [

	"Accept getters and setters"

	| key isSetter |

	"Check for keyword message"
	key := aMessage selector asString.
	(key first isLetter or: [ key first = $_ ])
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].

	"Check for too many arguments (not a simple setter)"
	isSetter := key endsWith: ':'.
	(isSetter and: [ aMessage arguments size > 1 ])
		ifTrue: [ ^ super doesNotUnderstand: aMessage ].

	isSetter
		ifTrue: [ self at: key allButLast put: aMessage arguments first ]
		ifFalse: [ ^ self at: key ]
]

{ #category : #initialization }
CpJsonObject >> initializeWithOrderedDictionary: anOrderedDictionary [

	self initialize: anOrderedDictionary size.

	"Add individual keys and values to make sure keys are converted to Strings"
	anOrderedDictionary keysAndValuesDo: [ :key :value |
		self at: key put: value ]
]

{ #category : #printing }
CpJsonObject >> printOn: aStream [

	"Print the receiver on the specified Stream.

	Implementation:
	Use the JSON.stringify() method to create a regular JSON representation of the receiver.
	Since the VM does not recognize the receiver as a Dictionary-like Object, make an explicit
	Dictionary for this purpose."

	aStream nextPutAll: (CpJavaScriptJSON stringify: self)
]

{ #category : #accessing }
CpJsonObject >> value [

	"To allow accessing #value through a message send"

	^ self at: #value
]
