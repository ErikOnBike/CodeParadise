"
I represent an identifier generator.

I generate identifiers (ByteString) for use within web applications. The generated identifiers
are of fixed size and can be communicated as Unicode strings as well as ASCII strings by simply
enclosing them in double quotes (for use in HTML attribute, JSON or Javascript code).
My identifiers do need encoding for use within URL's, but can be used directly on DOM elements
for the id attribute.
See https://html.spec.whatwg.org/multipage/dom.html#the-id-attribute

When used for security measures, make sure a secure random generator like SecureRandom is set
explicitly and choose a length appropriate for the application. An identifier of
length 16 will have over 2.6e31 possible values (equal to a little more than 104 bits or
13 bytes of random data). To get 16 bytes of randomness, choose an identifier length of 20.

Public API:
#generate - generate a ByteString containing an identifier

Example usage:
	""Identifier with default length using default RandomGenerator""
	WebIdentifierGenerator new generate
		
	""Identifier of 24 bytes using default RandomGenerator""
	(WebIdentifierGenerator new: 24) generate

	""Identifier with default length using SecureRandom generator""
	(WebIdentifierGenerator on: SecureRandom) generate

	""Create a pool of 100 unique identifiers (through uniqueness of elements in Set)""
	| generator identifierPool |
	generator := WebIdentifierGenerator new.	
	identifierPool := Set new: 100.
	[ identifierPool size < 100 ] whileTrue: [ identifierPool add: generator generate ].
	identifierPool

	""Generate guaranteed unique identifiers (create 100 sessions)""
	| generator sessions |
	generator := WebIdentifierGenerator new.
	sessions := Dictionary new.
	1 to: 100 do: [ :i |
		generator generateIn: [ :identifier |
			(sessions includesKey: identifier) not
				ifTrue: [
					sessions at: identifier put: Dictionary new.
					true ] ] ].
	sessions

Implementation:
#generate generates a ByteString consisting of displayable Unicode characters in the UTF-8
single byte range, without the double quote or double quote escaping (ie the non control
characters in the byte range [33, 127>, except double quote 34 and backslash 92).
A total of 92 bytes are present in the collection of allowable bytes.

"
Class {
	#name : #CpWebIdentifierGenerator,
	#superclass : #Object,
	#instVars : [
		'length',
		'randomGenerator'
	],
	#classVars : [
		'AllowedBytes'
	],
	#classInstVars : [
		'random'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> defaultLength [

	"Answer the default length of an identifier.
	
	A length of 6 should allow for [[[92 raisedTo: 6 = 606355001344]]] unique values and still
	offer enough room for not creating collisions in the randomization."

	^ 6
]

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> defaultRandomGenerator [

	^ Smalltalk at: #SecureRandom
		ifAbsent: [
			Smalltalk at: #SharedRandom
				ifAbsent: [
					Smalltalk at: #Random ifAbsent: [ self error: 'No Random generator present in image.' ] ] ]
]

{ #category : #'class initialization' }
CpWebIdentifierGenerator class >> initialize [

	"Initialize receiver"

	"Initialize the set of allowed characters"
	AllowedBytes := ByteString new: 92 streamContents: [ :stream |

		stream nextPut: (Character value: 33).
		35 to: 91 do: [ :each | stream nextPut: (Character value: each) ].
		93 to: 126 do: [ :each | stream nextPut: (Character value: each) ] ]
]

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> new [

	^self new: self defaultLength on: self defaultRandomGenerator new
]

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> new: length [

	^ self new: length on: self defaultRandomGenerator new
]

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> new: length on: aRandomGenerator [

	^ self basicNew
		initialize ;
		length: length ;
		randomGenerator: aRandomGenerator ;
		yourself
]

{ #category : #'instance creation' }
CpWebIdentifierGenerator class >> on: aRandomGenerator [

	^ self new: self defaultLength on: aRandomGenerator
]

{ #category : #accessing }
CpWebIdentifierGenerator >> generate [

	"Generate an identifier usable as HTML identifier (without further decoding of double quotes)"

	| bytes generator maxByteIndex |

	bytes := ByteString new: self length.
	generator := self randomGenerator.
	maxByteIndex := AllowedBytes size.
	1 to: bytes size do: [ :index |
		bytes at: index put: (AllowedBytes at: (generator nextInt: maxByteIndex)) ].
	^ bytes asString
]

{ #category : #accessing }
CpWebIdentifierGenerator >> generateSatisfying: aBlock [

	"Repeatedly generate an identifier until aBlock accepts it"

	| identifier |
	
	[ aBlock value: (identifier := self generate) ] whileFalse.

	^ identifier
]

{ #category : #accessing }
CpWebIdentifierGenerator >> length [

	^ length
]

{ #category : #accessing }
CpWebIdentifierGenerator >> length: anInteger [

	anInteger strictlyPositive ifFalse: [ self error: 'Only positive lengths are allowed.' ].
	length := anInteger
]

{ #category : #accessing }
CpWebIdentifierGenerator >> randomGenerator [

	^ randomGenerator
]

{ #category : #accessing }
CpWebIdentifierGenerator >> randomGenerator: aRandomGenerator [

	randomGenerator := aRandomGenerator
]
