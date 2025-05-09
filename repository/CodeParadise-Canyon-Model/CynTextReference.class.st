"
I am a parameterized text reference.
I have a key referencing a text and formatting values as parameters.
Tyically I am used in a constraint class to specify some violation
with some parameters. For example in a length constraint one could
use one of the following instances to specify a minimum length is not
reached. The two parameters specify the required minimum and the actual
size. In the first instance the parameters need to be retrieved
based on an index. In the second instance the parameters can be
retrieved using a name.

```
CynTextReference key: #'constraint.length.min' with: min with: size.
CynTextReference key: #'constraint.length.min' format: {
	#min -> min.
	#size -> size } asDictionary
```

"
Class {
	#name : #CynTextReference,
	#superclass : #Object,
	#instVars : [
		'key',
		'format'
	],
	#category : #'CodeParadise-Canyon-Model-Support'
}

{ #category : #'accessing - default lang' }
CynTextReference class >> key: aSymbol [

	^ self key: aSymbol format: nil
]

{ #category : #'accessing - default lang' }
CynTextReference class >> key: aSymbol format: aDictionary [

	"Answer a new instance of the receiver with the specified key and optional formatting Dictionary"

	^ self basicNew
		initializeWithKey: aSymbol format: aDictionary ;
		yourself
]

{ #category : #'accessing - default lang' }
CynTextReference class >> key: aSymbol with: aString [

	^ self key: aSymbol format: (Dictionary with: 1 -> aString)
]

{ #category : #'accessing - default lang' }
CynTextReference class >> key: aSymbol with: firstString with: secondString [

	^ self key: aSymbol format: (Dictionary with: 1 -> firstString with: 2 -> secondString)
]

{ #category : #'accessing - default lang' }
CynTextReference class >> key: aSymbol with: firstString with: secondString with: thirdString [

	^ self key: aSymbol format: (Dictionary with: 1 -> firstString with: 2 -> secondString with: 3 -> thirdString)
]

{ #category : #'instance creation' }
CynTextReference class >> new [

	self errorNewReplacedBy: #key:format:
]

{ #category : #converting }
CynTextReference >> asTextReference [

	^ self
]

{ #category : #accessing }
CynTextReference >> format [

	^ format
]

{ #category : #accessing }
CynTextReference >> formatWithAll: aDictionary [

	"Answer a new formatting Dictionary containing the values from the receiver and
	the (optional) Dictionary specified"

	| dictionary |

	dictionary := format
		ifNotNil: [ format copy ]
		ifNil: [ Dictionary new ].

	aDictionary ifNotNil: [
		dictionary addAll: aDictionary ].

	^ dictionary
]

{ #category : #testing }
CynTextReference >> hasEmptyFormat [

	"Answer whether the receiver has something to format"

	^ format isEmptyOrNil
]

{ #category : #initialization }
CynTextReference >> initializeWithKey: aSymbol format: aDictionary [

	self initialize.

	key := aSymbol.
	format := aDictionary
]

{ #category : #printing }
CynTextReference >> printOn: aStream [

	| first |

	aStream nextPutAll: key.

	format ifEmptyOrNil: [ ^ self ].

	aStream nextPut: $[.

	first := true.
	format keysAndValuesDo: [ :formatKey :formatValue |
		first
			ifTrue: [ first := false ]
			ifFalse: [ aStream nextPut: $, ].
		aStream
			nextPutAll: formatKey asString ;
			nextPut: $= ;
			print: formatValue ].

	aStream nextPut: $]
]

{ #category : #accessing }
CynTextReference >> textKey [

	"Answer the receiver's key.
	This method is to allow for a single access protocol for both the receiver class and Symbol."

	^ key
]
