Class {
	#name : #CpNodeJSBuffer,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Support-Core'
}

{ #category : #'instance creation' }
CpNodeJSBuffer class >> alloc: anInteger [

	"Allocates a new Buffer of size bytes"

	^ self apply: #alloc withArguments: { anInteger } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> alloc: anInteger fill: anObject [

	"Allocates a new Buffer of size bytes. If fill is undefined, the Buffer will be zero-filled.

	size <integer> The desired length of the new Buffer.
	fill <string> | <Buffer> | <Uint8Array> | <integer> A value to pre-fill the new Buffer with. Default: 0"

	^ self apply: #alloc withArguments: { anInteger . anObject } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> alloc: anInteger fill: anObject encoding: aString [

	"Allocates a new Buffer of size bytes. If fill is undefined, the Buffer will be zero-filled.

	size <integer> The desired length of the new Buffer.
	fill <string> | <Buffer> | <Uint8Array> | <integer> A value to pre-fill the new Buffer with. Default: 0.
	encoding <string> If fill is a string, this is its encoding. Default: 'utf8'."

	^ self apply: #alloc withArguments: { anInteger . anObject . aString } resultAs: self
]

{ #category : #accessing }
CpNodeJSBuffer class >> byteLength: anObject [

	"Returns the byte length of a string (assuming utf8 encoding). This is not the same as String.prototype.length, which does not account for the encoding that is used to convert the string into bytes.
	
	string <string> | <Buffer> | <TypedArray> | <DataView> | <ArrayBuffer> | <SharedArrayBuffer> A value to calculate the length of."

	^ self apply: #byteLength withArguments: { anObject }
]

{ #category : #accessing }
CpNodeJSBuffer class >> byteLength: anObject encoding: aString [

	"Returns the byte length of a string when encoded using encoding. This is not the same as String.prototype.length, which does not account for the encoding that is used to convert the string into bytes.
	
	string <string> | <Buffer> | <TypedArray> | <DataView> | <ArrayBuffer> | <SharedArrayBuffer> A value to calculate the length of.
	encoding <string> If string is a string, this is its encoding. Default: 'utf8'."

	^ self apply: #byteLength withArguments: { anObject . aString }
]

{ #category : #testing }
CpNodeJSBuffer class >> compare: buf1 to: buf2 [

	"Compares buf1 to buf2, typically for the purpose of sorting arrays of Buffer instances. This is equivalent to calling buf1.compare(buf2).

	buf1 <Buffer> | <Uint8Array>
	buf2 <Buffer> | <Uint8Array>
	Returns: <integer> Either -1, 0, or 1, depending on the result of the comparison. See buf.compare() for details."

	^ self apply: #compare withArguments: { buf1 . buf2 }
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> concat: anArray [

	"Returns a new Buffer which is the result of concatenating all the Buffer instances in the list together.

	list <Buffer[]> | <Uint8Array[]> List of Buffer or Uint8Array instances to concatenate."

	^ self apply: #concat withArguments: { anArray } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> concat: anArray totalLength: anInteger [

	"Returns a new Buffer which is the result of concatenating all the Buffer instances in the list together.

	list <Buffer[]> | <Uint8Array[]> List of Buffer or Uint8Array instances to concatenate.
	totalLength <integer> Total length of the Buffer instances in list when concatenated."

	^ self apply: #concat withArguments: { anArray . anInteger } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> from: anObject [

	"Create a buffer from the specified object"

	^ self apply: #from withArguments: { anObject } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> from: anObject encoding: aString [

	"Create a buffer from the specified object"

	^ self apply: #from withArguments: { anObject . aString } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> from: anObject offset: anInteger [

	"Create a buffer from the specified object"

	^ self apply: #from withArguments: { anObject . anInteger } resultAs: self
]

{ #category : #'instance creation' }
CpNodeJSBuffer class >> from: anObject offset: offsetInteger length: lengthInteger [

	"Create a buffer from the specified object"

	^ self apply: #from withArguments: { anObject . offsetInteger . lengthInteger } resultAs: self
]

{ #category : #testing }
CpNodeJSBuffer class >> isBuffer: anObject [

	"Returns true if obj is a Buffer, false otherwise."

	^ self apply: #isBuffer withArguments: { anObject }
]

{ #category : #testing }
CpNodeJSBuffer class >> isEncoding: aString [

	"Returns true if encoding is the name of a supported character encoding, or false otherwise."

	^ self apply: #isEncoding withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSBuffer class >> poolSize [

	"This is the size (in bytes) of pre-allocated internal Buffer instances used for pooling. This value may be modified."

	^ self propertyAt: #poolSize
]

{ #category : #accessing }
CpNodeJSBuffer class >> poolSize: anInteger [

	"This is the size (in bytes) of pre-allocated internal Buffer instances used for pooling. This value may be modified."

	self propertyAt: #poolSize put: anInteger
]

{ #category : #accessing }
CpNodeJSBuffer >> at: anInteger [

	"The index operator [index] can be used to get and set the octet at position index in buf. The values refer to individual bytes, so the legal value range is between 0x00 and 0xFF (hex) or 0 and 255 (decimal).

	Be aware this is 0-based indexing because of JavaScript."

	^ self propertyAt: anInteger printString
]

{ #category : #operations }
CpNodeJSBuffer >> compareTo: target at: targetStart end: targetEnd from: sourceStart to: sourceEnd [

	"Compares buf with target and returns a number indicating whether buf comes before, after, or is the same as target in sort order. Comparison is based on the actual sequence of bytes in each Buffer.

	target <Buffer> | <Uint8Array> A Buffer or Uint8Array with which to compare buf.
	targetStart <integer> The offset within target at which to begin comparison. Default: 0.
	targetEnd <integer> The offset within target at which to end comparison (not inclusive). Default: target.length.
	sourceStart <integer> The offset within buf at which to begin comparison. Default: 0.
	sourceEnd <integer> The offset within buf at which to end comparison (not inclusive). Default: buf.length."

	^ self apply: #compare withArguments: { target . targetStart . targetEnd . sourceStart . sourceEnd }
]

{ #category : #operations }
CpNodeJSBuffer >> copyTo: target at: targetStart from: sourceStart to: sourceEnd [

	"Copies data from a region of buf to a region in target, even if the target memory region overlaps with buf.

	target <Buffer> | <Uint8Array> A Buffer or Uint8Array to copy into.
	targetStart <integer> The offset within target at which to begin writing. Default: 0.
	sourceStart <integer> The offset within buf from which to begin copying. Default: 0.
	sourceEnd <integer> The offset within buf at which to stop copying (not inclusive). Default: buf.length."

	^ self apply: #copy withArguments: { target . targetStart . sourceStart . sourceEnd }
]

{ #category : #operations }
CpNodeJSBuffer >> equals: anObject [

	"Returns true if both buf and otherBuffer have exactly the same bytes, false otherwise. Equivalent to buf.compare(otherBuffer) === 0."

	^ self apply: #equals withArguments: { anObject }
]

{ #category : #operations }
CpNodeJSBuffer >> fill: value [

	"Fills buf with the specified value. If the offset and end are not given, the entire buf will be filled:

	value <string> | <Buffer> | <Uint8Array> | <integer> The value with which to fill buf. Empty value (string, Uint8Array, Buffer) is coerced to 0."

	^ self apply: #fill withArguments: { value }
]

{ #category : #operations }
CpNodeJSBuffer >> fill: value offset: offset end: end encoding: encoding [

	"Fills buf with the specified value. If the offset and end are not given, the entire buf will be filled:

	value <string> | <Buffer> | <Uint8Array> | <integer> The value with which to fill buf. Empty value (string, Uint8Array, Buffer) is coerced to 0.
	offset <integer> Number of bytes to skip before starting to fill buf. Default: 0.
	end <integer> Where to stop filling buf (not inclusive). Default: buf.length.
	encoding <string> The encoding for value if value is a string. Default: 'utf8'."

	^ self apply: #fill withArguments: { value . offset . end . encoding }
]

{ #category : #accessing }
CpNodeJSBuffer >> length [

	"Returns the number of bytes in buf."

	^ self propertyAt: #length
]

{ #category : #operations }
CpNodeJSBuffer >> pop [

	^ self apply: #pop
]

{ #category : #printing }
CpNodeJSBuffer >> printOn: aStream [

	"Prevent writing the full content by overriding this method"

	aStream
		nextPutAll: 'Buffer(length: ' ;
		print: self length ;
		nextPut: $)
]

{ #category : #operations }
CpNodeJSBuffer >> push: anObject [

	^ self apply: #push withArguments: { anObject }
]

{ #category : #operations }
CpNodeJSBuffer >> readDoubleBEAt: anInteger [

	^ self apply: #readDoubleBE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readDoubleLEAt: anInteger [

	^ self apply: #readDoubleLE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readFloatBEAt: anInteger [

	^ self apply: #readFloatBE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readFloatLEAt: anInteger [

	^ self apply: #readFloatLE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readInt16BEAt: anInteger [

	^ self apply: #readInt16BE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readInt16LEAt: anInteger [

	^ self apply: #readInt16LE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readInt32BEAt: anInteger [

	^ self apply: #readInt32BE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readInt32LEAt: anInteger [

	^ self apply: #readInt32LE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readInt8At: anInteger [

	^ self apply: #readInt8 withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readUInt16BEAt: anInteger [

	^ self apply: #readUInt16BE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readUInt16LEAt: anInteger [

	^ self apply: #readUInt16LE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readUInt32BEAt: anInteger [

	^ self apply: #readUInt32BE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readUInt32LEAt: anInteger [

	^ self apply: #readUInt32LE withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> readUInt8At: anInteger [

	^ self apply: #readUInt8 withArguments: { anInteger }
]

{ #category : #accessing }
CpNodeJSBuffer >> size [

	"Compatibility with Smalltalk Collections"

	^ self length
]

{ #category : #operations }
CpNodeJSBuffer >> subArrayStart: start end: end [

	"Returns a new Buffer that references the same memory as the original, but offset and cropped by the start and end indices.

	start <integer> Where the new Buffer will start. Default: 0.
	end <integer> Where the new Buffer will end (not inclusive). Default: buf.length."

	^ self apply: #subarray withArguments: { start . end }
]

{ #category : #operations }
CpNodeJSBuffer >> toJSON [

	"Returns a JSON representation of buf. JSON.stringify() implicitly calls this function when stringifying a Buffer instance."

	^ self apply: #toJSON
]

{ #category : #operations }
CpNodeJSBuffer >> toString [

	"Decodes buf to a string assuming an utf8 encoding.

	If a byte sequence in the input is not valid UTF-8, then each invalid byte is replaced with the replacement character U+FFFD."

	^ self apply: #toString
]

{ #category : #operations }
CpNodeJSBuffer >> toStringEncoding: encoding [

	"Decodes buf to a string according to the specified character encoding in encoding.

	If encoding is 'utf8' and a byte sequence in the input is not valid UTF-8, then each invalid byte is replaced with the replacement character U+FFFD.

	encoding <string> The character encoding to use. Default: 'utf8'."

	^ self apply: #toString withArguments: { encoding }
]

{ #category : #operations }
CpNodeJSBuffer >> toStringEncoding: encoding start: start end: end [

	"Decodes buf to a string according to the specified character encoding in encoding. start and end may be passed to decode only a subset of buf.

	If encoding is 'utf8' and a byte sequence in the input is not valid UTF-8, then each invalid byte is replaced with the replacement character U+FFFD.

	encoding <string> The character encoding to use. Default: 'utf8'.
	start <integer> The byte offset to start decoding at. Default: 0.
	end <integer> The byte offset to stop decoding at (not inclusive). Default: buf.length."

	^ self apply: #toString withArguments: { encoding . start . end }
]

{ #category : #operations }
CpNodeJSBuffer >> writeDoubleBE: value at: anInteger [

	^ self apply: #writeDoubleBE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeDoubleLE: value at: anInteger [

	^ self apply: #writeDoubleLE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeFloatBE: value at: anInteger [

	^ self apply: #writeFloatBE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeFloatLE: value at: anInteger [

	^ self apply: #writeFloatLE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeInt16BE: value at: anInteger [

	^ self apply: #writeInt16BE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeInt16LE: value at: anInteger [

	^ self apply: #writeInt16LE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeInt32BE: value at: anInteger [

	^ self apply: #writeInt32BE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeInt32LE: value at: anInteger [

	^ self apply: #writeInt32LE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeInt8: value at: anInteger [

	^ self apply: #writeInt8 withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeString: string offset: offset length: length encoding: encoding [

	"Writes string to buf at offset according to the character encoding in encoding. The length parameter is the number of bytes to write. If buf did not contain enough space to fit the entire string, only part of string will be written. However, partially encoded characters will not be written.

	string <string> String to write to buf.
	offset <integer> Number of bytes to skip before starting to write string. Default: 0.
	length <integer> Maximum number of bytes to write (written bytes will not exceed buf.length - offset). Default: buf.length - offset.
	encoding <string> The character encoding of string. Default: 'utf8'."

	^ self apply: #write withArguments: { string . offset . length . encoding }
]

{ #category : #operations }
CpNodeJSBuffer >> writeUInt16BE: value at: anInteger [

	^ self apply: #writeUInt16BE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeUInt16LE: value at: anInteger [

	^ self apply: #writeUInt16LE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeUInt32BE: value at: anInteger [

	^ self apply: #writeUInt32BE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeUInt32LE: value at: anInteger [

	^ self apply: #writeUInt32LE withArguments: { value . anInteger }
]

{ #category : #operations }
CpNodeJSBuffer >> writeUInt8: value at: anInteger [

	^ self apply: #writeUInt8 withArguments: { value . anInteger }
]
