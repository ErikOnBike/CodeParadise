Extension { #name : #String }

{ #category : #'*CodeParadise-RemoteEnvironment' }
String >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeString: self
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
