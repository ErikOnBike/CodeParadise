"
I am an Object Decoder. See the comment of my companion ObjectEncoder.
"
Class {
	#name : #CpObjectDecoder,
	#superclass : #Object,
	#instVars : [
		'readStream',
		'stringTable',
		'symbolTable',
		'currentMethod'
	],
	#category : #'CodeParadise-RemoteEnvironment-Serialization'
}

{ #category : #'instance creation' }
CpObjectDecoder class >> on: aByteArray [

	^ self new
		on: aByteArray
]

{ #category : #utilities }
CpObjectDecoder class >> putInstVars: instVars in: anObject [

	instVars withIndexDo: [ :instVar :index | anObject instVarAt: index put: instVar ]
]

{ #category : #reading }
CpObjectDecoder >> basicReadStringUsingTable: aCollection [

	"Read a String (can be a Symbol) using the specified table space (cache)"

	| characterCount |

	characterCount := self readLength.
	(characterCount = 2 and: [ self peekHasStringIndex ])
		ifTrue: [ ^ self basicReadStringWithIndexUsingTable: aCollection ].

	^ self basicReadStringWithLength: characterCount usingTable: aCollection
]

{ #category : #reading }
CpObjectDecoder >> basicReadStringWithIndexUsingTable: aCollection [

	"Read an index (into either the String or Symbol table) from the read stream.
	Assume the index is max 11 bits big.

	See CpObjectEncoder >> #basicWriteStringIndex: for an explanation."

	| index string |

	"Read index which is 0-based"
	index := ((readStream next bitAnd: 16r07) bitShift: 8) bitOr: readStream next.
	index := index + 1.

	string := aCollection
		at: index
		ifAbsent: [
			self errorCr: 'Error during String decoding: Accessing indexed String from invalid location ', index printString.

			"Answer an appropriate empty String"
			^ aCollection == stringTable
				ifTrue: [ '' ]
				ifFalse: [ #'' ] ].

	"For Strings (not Symbols) make a copy since these are unique instances"
	^ aCollection == stringTable
		ifTrue: [ string copy ]
		ifFalse: [ string ]
]

{ #category : #reading }
CpObjectDecoder >> basicReadStringWithLength: anInteger usingTable: aCollection [

	"Read a String consisting of UTF-8 characters and store it in the specified table space (cache)"

	| wordArray isWideString string |

	"Create and fill the string"
	wordArray := WordArray new: anInteger.
	isWideString := false.
	1 to: anInteger do: [  :index |
		(wordArray at: index put: self readUTF8CodePoint) >= 256
			ifTrue: [ isWideString := true ] ].

	string := isWideString
		ifTrue: [ WideString fromWordArray: wordArray ]
		ifFalse: [ ByteString fromWordArray: wordArray ].

	aCollection == symbolTable
		ifTrue: [ string := string asSymbol ].

	^ aCollection add: string
]

{ #category : #accessing }
CpObjectDecoder >> cacheString: aString [

	"Add the specified String to the receiver's cache (String table)"

	(stringTable ifNil: [ stringTable := OrderedCollection new ])
		addIfNotPresent: aString
]

{ #category : #decoding }
CpObjectDecoder >> decodeAdditionalMethodState [

	"Decode AdditionalMethodState assuming only Pragmas are relevant.
	An AdditionalMethodState is only decoded in the context of a CompiledMethod."

	| additionalMethodState selector pragmas |

	selector := self readSymbol.
	pragmas := self readArray.

	additionalMethodState := AdditionalMethodState new: pragmas size.
	pragmas withIndexDo: [ :eachPragma :index | additionalMethodState basicAt: index put: eachPragma ].

	"Set the method for the AdditionalMethodState (will in turn set the method for the Pragmas)"
	currentMethod ifNil: [ self error: 'Decoding AdditionalMethodState without a method' ].
	additionalMethodState setMethod: currentMethod.

	"Set the selector for the method"
	additionalMethodState selector: selector.

	^ additionalMethodState
]

{ #category : #decoding }
CpObjectDecoder >> decodeAnnouncement [

	"Decode an Announcement"

	| announcement className instVars |

	"Read class name"
	className := self readSymbol.

	"Read instance variables"
	instVars := self readArray.

	"Instanciate new announcement"
	announcement := (Smalltalk classNamed: className) basicNew.
	self class putInstVars: instVars in: announcement.

	^ announcement
]

{ #category : #decoding }
CpObjectDecoder >> decodeArray [

	"Decode Array"

	^ self readArray
]

{ #category : #decoding }
CpObjectDecoder >> decodeAssociation [

	"Decode Association"

	^ Association key: self decodeNext value: self decodeNext
]

{ #category : #decoding }
CpObjectDecoder >> decodeByteArray [

	"Decode ByteArray"

	| array size |

	size := self readLength.
	array := ByteArray new: size.
	1 to: size do: [ :index | array at: index put: readStream next ].

	^ array
]

{ #category : #decoding }
CpObjectDecoder >> decodeCharacter [

	"Decode a Character based on a Unicode value written using UTF-8"

	^ Character value: self readUTF8CodePoint
]

{ #category : #decoding }
CpObjectDecoder >> decodeClass [

	"Decode a Class and install it. Answer the newly installed Class or nil if this failed.
	A failure will occur when the superclass specified does not exist."

	| newClass theSuperclass className superclassName instVarNames classVarNames classInstVarNames |

	"Raise error if the receiver is not running in the ClientEnvironment"
	CpClientEnvironment isRunning
		ifFalse: [ ^ self error: 'ClientEnvironment sent Class to ServerEnvironment' ].

	"Read class and superclass name"
	className := self readSymbol.
	superclassName := self readSymbol.

	"Read instance variable, class variable and share pool names"
	instVarNames := self readArray.
	classVarNames := self readArray.
	classInstVarNames := self readArray.

	"Retrieve super class"
	(theSuperclass := Smalltalk classNamed: superclassName)
		ifNil: [

			"Create temporary class to allow cyclic dependencies"
			theSuperclass := Object
				subclass: superclassName
				instanceVariableNames: #()
				classVariableNames: #()
				classInstanceVariableNames: #().
			CpClientEnvironment current resolveClassReferences: theSuperclass ].

	"Create new or update existing subclass from our superclass"
	(Smalltalk classNamed: className)
		ifNotNil: [ :existingClass |

			"Not actually a new class, but update it to become the 'full' class"
			superclassName == #Object
				ifTrue: [ newClass := existingClass ]
				ifFalse: [
					existingClass superclass == Object
						ifTrue: [ Object removeSubclass: existingClass ].
					newClass := existingClass.
					newClass superclass: theSuperclass.
					newClass class superclass: theSuperclass class.
					newClass setFormat: newClass format + theSuperclass instSize.	"Object has no instance vars, so simply add the new inst var count"
					theSuperclass addSubclass: newClass ].

			"Update instance variables and class variables"
			instVarNames
				ifNotEmpty: [
					newClass instVarNames: instVarNames.
					newClass withAllSubclassesDo: [ :each | each setFormat: each format + instVarNames size ] ].
			classVarNames do: [ :each | newClass addClassVarNamed: each ].
			classInstVarNames
				ifNotEmpty: [

					"Add the class instance variables"
					newClass class instVarNames: classInstVarNames.

					"Update the metaclass(es), since their instances (i.e. the classes) have changed size"
					newClass withAllSubclassesDo: [ :each |
						each class setFormat: each class format + classInstVarNames size ].

					"Recreate the metaclass instance(s), i.e. the class, since they have changed size"
					newClass withAllSubclassesDo: [ :each |
						| tempClass |
						tempClass := each superclass
							subclass: each name
							instanceVariableNames: each instVarNames
							classVariableNames: each classVarNames
							classInstanceVariableNames: each class instVarNames.
						each becomeForward: tempClass ] ] ]
		ifNil: [

			"Create new subclass"
			newClass := theSuperclass
				subclass: className
				instanceVariableNames: instVarNames
				classVariableNames: classVarNames
				classInstanceVariableNames: classInstVarNames.
			CpClientEnvironment current resolveClassReferences: newClass ].

	"Read and install instance and class methods"
	newClass installMethodDictionary: self readMethodDictionary.
	newClass class installMethodDictionary: self readMethodDictionary.

	^ newClass
]

{ #category : #decoding }
CpObjectDecoder >> decodeClassReference [

	| name class classReference |

	name := self readSymbol.
	class := Smalltalk classNamed: name.
	classReference := Association key: name value: (class ifNil: [ #__ClassReference ]).
	class ifNil: [
		"In the client environment keep track of unresolved class reference"
		CpClientEnvironment isRunning
			ifTrue: [ CpClientEnvironment current registerUnresolvedClassReference: classReference ]
			ifFalse: [ self error: 'Unknown class named ', name ] ].
	^ classReference
]

{ #category : #decoding }
CpObjectDecoder >> decodeClassVariable [

	| name |

	name := self readSymbol.

	^ (Smalltalk at: #ClassVariable)
		key: name
		value: nil
]

{ #category : #decoding }
CpObjectDecoder >> decodeCompiledBlock [

	"Decode a CompiledBlock. It will have its outerCode set,
	based on the current method being decoded (a CompiledBlock
	should only be present in context of a CompiledMethod)."

	| block header bytecodeSize initialPC endPC |

	"Raise error if the receiver is not running in the ClientEnvironment"
	CpClientEnvironment isRunning
		ifFalse: [ ^ self error: 'ClientEnvironment sent CompiledBlock to ServerEnvironment' ].

	"Read header and bytecode size"
	header := self denormalizeHeader: self readUInt32.
	bytecodeSize := self readLength.

	"Create empty block instance"
	block := CompiledBlock basicNew: bytecodeSize header: header.

	"Add bytecode to the block"
	initialPC := block initialPC.
	endPC := block endPC.
	initialPC to: endPC do: [ :byteIndex | block byteAt: byteIndex put: readStream next ].

	"Add literals  (excl. outerCode which is positioned at index 'numLiterals')"
	1 to: block numLiterals - 1 do: [ :index | block literalAt: index put: self decodeNext ].

	"Add outerCode (which resides at index 'numLiterals')"
	block outerCode: currentMethod.

	^ block
]

{ #category : #decoding }
CpObjectDecoder >> decodeCompiledMethod [

	"Decode a CompiledMethod. Although it is not installed here, it will have its bound Class set
	since this is one of the CompiledMethod's literals."

	| method header bytecodeSize initialPC endPC |

	"Raise error if the receiver is not running in the ClientEnvironment"
	CpClientEnvironment isRunning
		ifFalse: [ ^ self error: 'ClientEnvironment sent CompiledMethod to ServerEnvironment' ].

	"Read header and bytecode size"
	header := self denormalizeHeader: self readUInt32.
	bytecodeSize := self readLength.

	"Create empty method instance"
	method := CompiledMethod basicNew: bytecodeSize + 4 header: header.

	"Keep reference to this method in instvar 'currentMethod' for use when decoding AdditionalMethodState or Pragmas"
	currentMethod := method.

	"Add bytecode to the method"
	initialPC := method initialPC.
	endPC := method endPC.
	initialPC to: endPC do: [ :byteIndex | method byteAt: byteIndex put: readStream next ].

	"Add literals"
	1 to: method numLiterals do: [ :index | method literalAt: index put: self decodeNext ].

	"Reference to currentMethod no longer needed (can't be nested so just set to nil)"
	currentMethod := nil.

	^ method
]

{ #category : #decoding }
CpObjectDecoder >> decodeConstantBlockClosure [

	| numArgs literal |

	"Raise error if the receiver is not running in the ClientEnvironment"
	CpClientEnvironment isRunning
		ifFalse: [ ^ self error: 'ClientEnvironment sent CompiledBlock to ServerEnvironment' ].

	"Read number of arguments and literal"
	numArgs := self readLength.
	literal := self decodeNext.

	^ ConstantBlockClosure numArgs: numArgs literal: literal
]

{ #category : #decoding }
CpObjectDecoder >> decodeDictionary [

	^ self readArray asDictionary
]

{ #category : #decoding }
CpObjectDecoder >> decodeFalse [

	^ false
]

{ #category : #decoding }
CpObjectDecoder >> decodeFloat [

	| word1 word2 |

	word1 := self readUInt32.
	word2 := self readUInt32.

	^ (Float new: 2)
		basicAt: 1 put: word1 ;
		basicAt: 2 put: word2 ;
		yourself
]

{ #category : #decoding }
CpObjectDecoder >> decodeGlobalVariable [

	| name |

	name := self readSymbol.

	^ (Smalltalk at: #GlobalVariable)
		key: name
		value: (Smalltalk at: name ifAbsent: [ self error: 'Unknown global ', name ])
]

{ #category : #decoding }
CpObjectDecoder >> decodeInteger0 [

	^ 0
]

{ #category : #decoding }
CpObjectDecoder >> decodeInteger1Byte [

	^ self readIntegerWithBytes: 1
]

{ #category : #decoding }
CpObjectDecoder >> decodeInteger2Bytes [

	^ self readIntegerWithBytes: 2
]

{ #category : #decoding }
CpObjectDecoder >> decodeInteger3Bytes [

	^ self readIntegerWithBytes: 3
]

{ #category : #decoding }
CpObjectDecoder >> decodeInteger4Bytes [

	^ self readIntegerWithBytes: 4
]

{ #category : #decoding }
CpObjectDecoder >> decodeLargeNegativeInteger [

	"Large integers are stored as special type and therefore do not need a sign bit anymore.
	Large integers are therefore stored using their positive value."

	^ self readLargePositiveInteger negated
]

{ #category : #decoding }
CpObjectDecoder >> decodeLargePositiveInteger [

	^ self readLargePositiveInteger
]

{ #category : #decoding }
CpObjectDecoder >> decodeMessage [

	"Decode a Message (lookupClass is ignored"

	^ Message
		selector: self readSymbol
		arguments: self decodeNext
]

{ #category : #decoding }
CpObjectDecoder >> decodeMessageSend [

	"Decode a MessageSend"

	^ MessageSend
		receiver: self decodeNext
		selector: self readSymbol
		arguments: self decodeNext
]

{ #category : #decoding }
CpObjectDecoder >> decodeMetaclassReference [

	| name class |

	name := self readSymbol.
	class := Smalltalk classNamed: name.
	class ifNil: [ self error: 'Unknown class named ', name ].

	^ Association key: nil value: class class
]

{ #category : #decoding }
CpObjectDecoder >> decodeNext [

	| type selector |

	type := readStream next.
	selector := #(
		decodeNil
		decodeTrue
		decodeFalse
		decodeCharacter
		decodeSymbol
		decodeString
		decodeInteger0
		decodeInteger1Byte
		decodeInteger2Bytes
		decodeInteger3Bytes
		decodeInteger4Bytes
		decodeLargePositiveInteger
		decodeLargeNegativeInteger
		decodeFloat
		decodeArray
		decodeAssociation
		decodeDictionary
		decodeCompiledMethod
		decodeAdditionalMethodState
		decodePragma
		decodeClassReference
		decodeMetaclassReference
		decodeClassVariable
		decodeGlobalVariable
		decodeClass
		decodeAnnouncement
		decodeMessageSend
		decodeMessage
		decodePoint
		decodeCompiledBlock
		decodeConstantBlockClosure
		decodeByteArray
		decodeWordArray
	) at: type ifAbsent: [ self error: 'Unknown type in decode stream' ].

	^ self perform: selector
]

{ #category : #decoding }
CpObjectDecoder >> decodeNil [

	^ nil
]

{ #category : #decoding }
CpObjectDecoder >> decodePoint [

	"Decode a Point"

	^ Point x: self decodeNext y: self decodeNext
]

{ #category : #decoding }
CpObjectDecoder >> decodePragma [

	"Decode Pragma using its selector (fka keyword) and arguments.
	A Pragma is only decoded in the context of a CompiledMethod."

	| selector arguments |

	"The Pragma's method will be set in #decodeAdditionalMethodState just use keyword and arguments"
	selector := self readSymbol.
	arguments := self readArray.

	^ Pragma new
		selector: selector ;
		arguments: arguments ;
		yourself
]

{ #category : #decoding }
CpObjectDecoder >> decodeString [

	^ self readString
]

{ #category : #decoding }
CpObjectDecoder >> decodeSymbol [

	^ self readSymbol
]

{ #category : #decoding }
CpObjectDecoder >> decodeTrue [

	^ true
]

{ #category : #decoding }
CpObjectDecoder >> decodeWordArray [

	"Decode WordArray"

	| array size |

	size := self readLength.
	array := WordArray new: size.
	1 to: size do: [ :index | array at: index put: self readUInt32 ].

	^ array
]

{ #category : #accessing }
CpObjectDecoder >> denormalizeHeader: header [

	"De-normalize the header value of CompiledCode. (See comment of CpObjectEncoder >> #normalizeHeader:)

	Implementation:
	Reset the position of the sign flag, which is used to indicate secondary bytecode set being used."

	^ (header bitAnd: 16r40000000) ~~ 0
		ifTrue: [ (header bitAnd: 16r3fffffff) + SmallInteger minVal ]
		ifFalse: [ header ]
]

{ #category : #reading }
CpObjectDecoder >> doPeek: aBlock [

	"Evaluate aBlock while preserving the current read stream position"

	| position |

	position := readStream position.
	[ aBlock value ] ensure: [ readStream position: position ]

]

{ #category : #errors }
CpObjectDecoder >> errorMalformedUTF8 [

	self error: 'Malformed UTF-8 character'
]

{ #category : #testing }
CpObjectDecoder >> hasMoreData [

	^ readStream atEnd not
]

{ #category : #'instance creation' }
CpObjectDecoder >> on: aByteArray [

	readStream := ReadStream on: aByteArray.

	"Implementation: The stringTable is lazy initialized"
	symbolTable := OrderedCollection new
]

{ #category : #reading }
CpObjectDecoder >> peekHasStringIndex [

	"Answer whether a String index is on the read stream.

	See CpObjectEncoder >> #basicWriteStringIndex: for an explanation."

	^ (readStream peek bitAnd: 16rf8) = 16rf8
]

{ #category : #reading }
CpObjectDecoder >> readArray [

	| array size |

	size := self readLength.
	array := Array new: size.
	1 to: size do: [ :index | array at: index put: self decodeNext ].

	^ array
]

{ #category : #reading }
CpObjectDecoder >> readIntegerWithBytes: byteSize [

	"Read an integer from the read stream consisting of byteSize bytes.
	It is assumed that the integer is stored in 2's complement representation and little endian order."

	| integer highByteShift |

	"Read integer as positive integer (ignore possible sign)"
	integer := self readPositiveIntegerWithSize: byteSize.

	"Update sign (and value) of integer if high bit is set"
	highByteShift := 8 * (byteSize - 1).
	(integer bitAnd: (16r80 bitShift: highByteShift)) = 0
		ifFalse: [ integer := integer - (16r100 bitShift: highByteShift) ].

	^ integer
]

{ #category : #reading }
CpObjectDecoder >> readLargePositiveInteger [

	"Read a (possibly large) integer from the read stream in little endian order.
	The number of bytes is assumed to be present on the read stream (size in 2 bytes, little endian order).
	The integer is assumed to be positive (ie no sign bit)."

	| byteSize |

	"Retrieve size of integer"
	byteSize := self readLength.

	^ self readPositiveIntegerWithSize: byteSize
]

{ #category : #reading }
CpObjectDecoder >> readLength [

	"Read a length value using a byte encoding where the high (8th) bit is designated to mark the final byte.
	The resulting length will be either 0 or a positive integer.
	The length is stored in little endian (least significant byte first) order."

	| length byte bitShift |

	length := 0.

	"Read 7 bits of the length at a time (little endian order)"
	bitShift := 0.
	[
		byte := readStream next.
		length := length bitOr: ((byte bitAnd: 16r7f) bitShift: bitShift).
		bitShift := bitShift + 7.
		(byte bitAnd: 16r80) = 16r80 ] whileFalse.

	^ length
]

{ #category : #decoding }
CpObjectDecoder >> readMethodDictionary [

	"Create and answer a MethodDictionary from the methods read.

	Implementation:
	Create the MethodDictionary with enough size to hold all methods and be performant for
	accessing elements (hash behavior). This also prevents having to grow the MethodDictionary
	during installation of individual methods. See Set >> #fullCheck."

	| methods methodDictionary |

	methods := self readArray.
	methodDictionary := MethodDictionary new: methods size + (methods size // 4 max: 1).
	methods do: [ :eachMethod | methodDictionary at: eachMethod selector put: eachMethod ].

	^ methodDictionary
]

{ #category : #reading }
CpObjectDecoder >> readPositiveIntegerWithSize: byteSize [

	"Read integer from readStream as positive integer (ignore possible sign bit).
	Assume integer is byteSize bytes long and is stored in little endian order."

	| integer |

	integer := 0.
	0 to: byteSize - 1 do: [ :byteShift | integer := integer bitOr: (readStream next bitShift: 8 * byteShift) ].

	^ integer
]

{ #category : #reading }
CpObjectDecoder >> readString [

	"Read a String (should not be a Symbol)"

	^ self basicReadStringUsingTable: (stringTable ifNil: [ stringTable := OrderedCollection new ])
]

{ #category : #reading }
CpObjectDecoder >> readSymbol [

	"Read a Symbol (should not be a String)"

	^ self basicReadStringUsingTable: symbolTable
]

{ #category : #reading }
CpObjectDecoder >> readUInt32 [

	"Read uint32 using little endian (least significant byte first) order"

	^ self readPositiveIntegerWithSize: 4
]

{ #category : #reading }
CpObjectDecoder >> readUTF8CodePoint [

	"Read a Unicode value written using UTF-8.
	See also https://en.wikipedia.org/wiki/UTF-8"

	| unicode |

	unicode := readStream next.
	(unicode bitAnd: 16r80) = 0 	"Encoding 0xxxxxxx for single byte UTF-8 character"
		ifFalse: [

			| bytesToRead byte |

			"Decide additional number of bytes to read"
			(unicode bitAnd: 16re0) = 16rc0 	"Encoding 110xxxxx for 2-byte UTF-8 character"
				ifTrue: [ bytesToRead := 1 ]
				ifFalse: [
					(unicode bitAnd: 16rf0) = 16re0 	"Encoding 1110xxxx for 3-byte UTF-8 character"
						ifTrue: [ bytesToRead := 2 ]
						ifFalse: [
							(unicode bitAnd: 16rf8) = 16rf0 	"Encoding 11110xxx for 4-byte UTF-character"
								ifTrue: [ bytesToRead := 3 ]
								ifFalse: [ self errorMalformedUTF8 ] ] ].

			"Remove encoding bits from first unicode byte"
			unicode := unicode bitAnd: (16r3f bitShift: bytesToRead negated).

			"Read additional bytes (removing encoding bits 10xxxxxx)"
			bytesToRead timesRepeat: [
				byte := readStream next.
				(byte bitAnd: 16rc0) = 16r80 	"check continuation bit"
					ifFalse: [ self errorMalformedUTF8 ].
				unicode := (unicode bitShift: 6) bitOr: (byte bitAnd: 16r3f) ] ].

	^ unicode
]

{ #category : #accessing }
CpObjectDecoder >> remainingBytes [

	"Answer the remaining bytes of the receiver"

	^ readStream upToEnd
]
