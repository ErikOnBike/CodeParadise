Extension { #name : #String }

{ #category : #'*CodeParadise-RemoteEnvironment' }
String >> asNumberOrNil [

	"Answer the specified number represented by the receiver
	or nil if no such value exists.
	The 'special' values 'NaN', 'Infinity' and '-Infinity' ARE supported.
	In contrast with #asNumber, the (Smalltalk) radix is NOT supported.
	For example: 16rff will not be accepted (i.e. will answer nil)."

	<clientEnvironment>

	^ [
		(self includes: $r)
			ifFalse: [ self asNumber ]
	] on: Error do: [ nil ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
String >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeString: self
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
String class >> fromUTF8EncodedByteArray: aByteArray [

	"Answer a String containing the information from the specified ByteArray
	assume an UTF-8 encoding is applied"

	<applicationExtension>

	| objectDecoder |

	objectDecoder := CpObjectDecoder on: aByteArray.
	^ self streamContents: [ :aStream |
		[  objectDecoder hasMoreData ] whileTrue: [
			aStream nextPut: (Character value: objectDecoder readUTF8CodePoint) ] ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
String class >> fromWordArray: aWordArray [

	"Answer an instance of the receiver consisting of Characters having
	the values of the elements in the specified WordArray.
	This method will fail for a ByteString if an element has a non-byte value."

	| newString |

	newString := self new: aWordArray size.
	1 to: aWordArray size do: [ :index | newString basicAt: index put: (aWordArray basicAt: index) ].

	^ newString

]
