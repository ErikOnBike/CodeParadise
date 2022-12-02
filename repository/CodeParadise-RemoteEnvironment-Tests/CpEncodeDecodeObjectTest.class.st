"
Tests for ObjectEncoder and ObjectDecoder
"
Class {
	#name : #CpEncodeDecodeObjectTest,
	#superclass : #TestCase,
	#category : #'CodeParadise-RemoteEnvironment-Tests'
}

{ #category : #comparing }
CpEncodeDecodeObjectTest class >> compareMethod: aCompiledMethod to: anotherCompiledMethod [

	"Compare both methods for equality.
	This is a copy of CompiledCode >> #= except for comparing literals at end."

	aCompiledMethod == anotherCompiledMethod
		ifTrue: [ ^ true ].
	aCompiledMethod class = anotherCompiledMethod class
		ifFalse: [ ^ false ].
	aCompiledMethod size = anotherCompiledMethod size
		ifFalse: [ ^ false ].
	aCompiledMethod header = anotherCompiledMethod header
		ifFalse: [ ^ false ].
	aCompiledMethod initialPC to: aCompiledMethod endPC do: [ :i | 
		(aCompiledMethod at: i) = (anotherCompiledMethod at: i)
			ifFalse: [ ^ false ] ].
	^ self compareMethodLiteralsFrom: aCompiledMethod to: anotherCompiledMethod
]

{ #category : #comparing }
CpEncodeDecodeObjectTest class >> compareMethodLiteralsFrom: aCompiledMethod to: anotherCompiledMethod [

	"Compare literals from both methods for equality.
	This is an adaptation of CompiledMethod >> #sameLiteralsAs: with slightly less strict comparison."

	| numLits literal1 literal2 |
	(numLits := aCompiledMethod numLiterals) ~= anotherCompiledMethod numLiterals
		ifTrue: [ ^ false ].
	"The last literal requires special checking instead of using #literalEqual:"
	1 to: numLits - 1 do: [ :index | 
		literal1 := aCompiledMethod literalAt: index.
		literal2 := anotherCompiledMethod literalAt: index.
		((literal1 isMethodProperties and: [ literal2 isMethodProperties ])
			ifTrue: [ self compareMethodPropertiesFrom: literal1 to: literal2 ]
			ifFalse: [ literal1 = literal2 ])
				ifFalse: [ ^ false ] ].
	"Class side methods have non unique (nil -> a Metaclass) as literal and cannot be compared equal"
	literal1 := aCompiledMethod literalAt: numLits.
	literal2 := anotherCompiledMethod literalAt: numLits.
	^ literal1 class == literal2 class
	     and: [literal1 isVariableBinding
	                ifTrue: [literal1 key = literal2 key and: [literal1 value = literal2 value]]
	                ifFalse: [literal1 = literal2]]
]

{ #category : #comparing }
CpEncodeDecodeObjectTest class >> compareMethodPropertiesFrom: aMethodProperties to: anotherMethodProperties [

	aMethodProperties selector = anotherMethodProperties selector
		ifFalse: [ ^ false ].

	aMethodProperties size = anotherMethodProperties size
		ifFalse: [ ^ false ].

	aMethodProperties pragmas withIndexDo: [ :eachPragma :index |
		| otherPragma |
		otherPragma := anotherMethodProperties pragmas at: index.
		eachPragma selector = otherPragma selector
			ifFalse: [ ^ false ].
		eachPragma arguments asArray = otherPragma arguments asArray
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testArray [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeArray: Array new ; bytes)) decodeNext isArray
		description: 'Encode/decode empty Array'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeArray: Array new ; bytes)) decodeNext isEmpty
		description: 'Encode/decode empty Array has no elements'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeArray: { 'hello' . 'world' } ; bytes)) decodeNext = { 'hello' . 'world' }
		description: 'Encode/decode Array with 2 Strings'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeArray: { 'hello' . 123 . $! } ; bytes)) decodeNext = { 'hello' . 123 . $! }
		description: 'Encode/decode Array with String, Integer and Character'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeArray: { 'hello' . { 1 . { 20 } . 3 } . $! } ; bytes)) decodeNext = { 'hello' . { 1 . { 20 } . 3 } . $! }
		description: 'Encode/decode Array with nested Arrays and String, Integer and Character'.
	self
		assert: (CpObjectDecoder on: { 3 . { 2 } . 1 } cpEncoded) decodeNext = { 3 . {  2 } . 1 }
		description: 'Decode an encoded Array'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testAssociation [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeAssociation: 'hello' -> 'world' ; bytes)) decodeNext = (Association key: 'hello' value: 'world')
		description: 'Encode/decode Association with String value'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeAssociation: 'hello' -> { 'to' . 'the' . 'world' } ; bytes)) decodeNext = (Association key: 'hello' value: { 'to' . 'the' . 'world' })
		description: 'Encode/decode Association with Array value'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeAssociation: 'hello' -> ('to' -> 'world') ; bytes)) decodeNext = (Association key: 'hello' value: 'to' -> 'world')
		description: 'Encode/decode Association with Association value'

]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testCharacter [

	"Test different (Unicode) characters"

	| char |

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: $R ; bytes)) decodeNext = $R
		description: 'Encode/decode $R'.
	char := Unicode value: 16r1f600.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r1f600'.
	char := Unicode value: 16r00.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r00'.
	char := Unicode value: 16r01.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r01'.
	char := Unicode value: 16r7f.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r7f'.
	char := Unicode value: 16r80.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r80'.
	char := Unicode value: 16r7ff.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r7ff'.
	char := Unicode value: 16r800.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r800'.
	char := Unicode value: 16rffff.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16rffff'.
	char := Unicode value: 16r10ffff.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char
		description: 'Encode/decode unicode character 16r10ffff'.
	char := Unicode value: 16r110000.
	self
		should: [ (CpObjectDecoder on: (CpObjectEncoder new encodeCharacter: char ; bytes)) decodeNext = char ]
		raise: Error
		description: 'Encode/decode unicode character fails to accept 16r110000'.
	self
		assert: (CpObjectDecoder on: $X cpEncoded) decodeNext = $X
		description: 'Decode an encoded character'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testCompiledMethod [

	self
		assert: (self class compareMethod: (CpObjectDecoder on: (CpObjectEncoder new encodeCompiledMethod: (CpEncodeDecodeObjectTest >> #testCompiledMethod) ; bytes)) decodeNext to: CpEncodeDecodeObjectTest >> #testCompiledMethod)
		description: 'Encode/decode CpEncodeDecodeMessageTest >> #testCompiledMethod'.
	self
		assert: (self class compareMethod: (CpObjectDecoder on: (CpObjectEncoder new encodeCompiledMethod: (ByteString >> #isByteString) ; bytes)) decodeNext to: ByteString >> #isByteString)
		description: 'Encode/decode ByteString >> #isByteString'.
	self
		assert: (self class compareMethod: (CpObjectDecoder on: (CpObjectEncoder new encodeCompiledMethod: (ByteString >> #isByteString) ; bytes)) decodeNext to: ByteSymbol >> #isByteString) not
		description: 'Encode/decode ByteString >> #isByteString and ByteSymbol >> #isByteString (same implementation but different class)'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testCompiledMethodWithAdditionalMethodState [

	<somePragma: #someValue>

	self
		assert: (self class compareMethod: (CpObjectDecoder on: (CpObjectEncoder new encodeCompiledMethod: (CpEncodeDecodeObjectTest >> #testCompiledMethodWithAdditionalMethodState) ; bytes)) decodeNext to: CpEncodeDecodeObjectTest >> #testCompiledMethodWithAdditionalMethodState)
		description: 'Encode/decode CpEncodeDecodeMessageTest >> #testCompiledMethodWithAdditionalMethodState'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testFalse [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFalse ; bytes)) decodeNext == false
		description: 'Encode/decode false'.
	self
		assert: (CpObjectDecoder on: false cpEncoded) decodeNext == false
		description: 'Decode an encoded false'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testFloat [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float zero ; bytes)) decodeNext isZero
		description: 'Encode/decode Float 0.0'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float negativeZero ; bytes)) decodeNext isZero
		description: 'Encode/decode Float negativeZero'.
"	'Float negativeZero negative' answers false, therefore not a valid test.	
	self
		assert: (CpMessageDecoder on: (CpMessageEncoder new encodeFloat: Float negativeZero ; bytes)) decodeNext negative
		description: 'Encode/decode Float negativeZero'.
"	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float one ; bytes)) decodeNext = Float one
		description: 'Encode/decode Float 1.0'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float halfPi ; bytes)) decodeNext = Float halfPi
		description: 'Encode/decode Float halfPi'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float infinity ; bytes)) decodeNext isInfinite
		description: 'Encode/decode Float infinity'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float negativeInfinity ; bytes)) decodeNext isInfinite
		description: 'Encode/decode Float negativeInfinity'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeFloat: Float negativeInfinity ; bytes)) decodeNext negative
		description: 'Encode/decode Float negativeInfinity'.
	self
		assert: (CpObjectDecoder on: 1.23 cpEncoded) decodeNext = 1.23
		description: 'Decode an encoded Float'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testInteger [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: 0 ; bytes)) decodeNext = 0
		description: 'Encode/decode Integer 0'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: 1 ; bytes)) decodeNext = 1
		description: 'Encode/decode Integer 1'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: -1 ; bytes)) decodeNext = -1
		description: 'Encode/decode Integer -1'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: 127 ; bytes)) decodeNext = 127
		description: 'Encode/decode Integer 127'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: 128 ; bytes)) decodeNext = 128
		description: 'Encode/decode Integer 128'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: -128 ; bytes)) decodeNext = -128
		description: 'Encode/decode Integer -128'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: -129 ; bytes)) decodeNext = -129
		description: 'Encode/decode Integer -129'.
	-16r100000123 to: -16rfffffedc do: [ :integer |
		self
			assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: integer ; bytes)) decodeNext = integer
			description: 'Encode/decode Integer loop1' ].
	16r7ffffedc to: 16r80000123 do: [ :integer |
		self
			assert: (CpObjectDecoder on: (CpObjectEncoder new encodeInteger: integer ; bytes)) decodeNext = integer
			description: 'Encode/decode Integer loop2' ].

]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testLength [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new writeLength: 0 ; bytes)) readLength == 0
		description: 'Encode/decode true'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new writeLength: 1 ; bytes)) readLength == 1
		description: 'Encode/decode true'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new writeLength: 16r7f ; bytes)) readLength == 16r7f
		description: 'Encode/decode true'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new writeLength: 16r80 ; bytes)) readLength == 16r80
		description: 'Encode/decode true'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new writeLength: 1234567890 ; bytes)) readLength == 1234567890
		description: 'Encode/decode true'.

]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testMessageSend [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeMessageSend: (MessageSend receiver: #id selector: #doIt arguments: nil) ; bytes)) decodeNext = (MessageSend receiver: #id selector: #doIt arguments: nil)
		description: 'Encode/decode MessageSend with no arguments'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeMessageSend: (MessageSend receiver: #id selector: #doIt arguments: {}) ; bytes)) decodeNext = (MessageSend receiver: #id selector: #doIt arguments: {})
		description: 'Encode/decode MessageSend with empty arguments'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeMessageSend: (MessageSend receiver: #id selector: #doIt arguments: { 1. 2. 3 }) ; bytes)) decodeNext = (MessageSend receiver: #id selector: #doIt arguments: { 1. 2. 3 })
		description: 'Encode/decode MessageSend with arguments'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeMessageSend: (MessageSend receiver: #id selector: #doIt:with:and: arguments: { 123. #hello. { #more } }) ; bytes)) decodeNext = (MessageSend receiver: #id selector: #doIt:with:and: arguments: { 123. #hello. { #more } })
		description: 'Encode/decode MessageSend with array arguments'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeMessageSend: (MessageSend receiver: nil selector: #doIt:and:more: arguments: { 1. 2. 3 }) ; bytes)) decodeNext = (MessageSend receiver: nil selector: #doIt:and:more: arguments: { 1. 2. 3 })
		description: 'Encode/decode MessageSend with nil as receiver'.

]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testNegativeIntegerEncoding [

	"Test different byte size negative integers"

	self
		assert: ((CpObjectEncoder new encodeInteger: -1 ; bytes) at: 1) = 8
		description: 'Encode/decode Integer type for -1'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r80 ; bytes) at: 1) = 8
		description: 'Encode/decode Integer type for -16r80'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r81 ; bytes) at: 1) = 9
		description: 'Encode/decode Integer type for -16r81'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r8000 ; bytes) at: 1) = 9
		description: 'Encode/decode Integer type for -16r8000'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r8001 ; bytes) at: 1) = 10
		description: 'Encode/decode Integer type for -16r8001'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r800000 ; bytes) at: 1) = 10
		description: 'Encode/decode Integer type for -16r800000'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r800001 ; bytes) at: 1) = 11
		description: 'Encode/decode Integer type for -16r800001'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r80000000 ; bytes) at: 1) = 11
		description: 'Encode/decode Integer type for -16r80000000'.
	self
		assert: ((CpObjectEncoder new encodeInteger: -16r80000001 ; bytes) at: 1) = 13
		description: 'Encode/decode Integer type for -16r80000001'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testNil [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeNil ; bytes)) decodeNext isNil
		description: 'Encode/decode nil'.
	self
		assert: (CpObjectDecoder on: nil cpEncoded) decodeNext isNil
		description: 'Decode an encoded nil'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testPositiveIntegerEncoding [

	"Test different byte size positive integers"

	self
		assert: ((CpObjectEncoder new encodeInteger: 0 ; bytes) at: 1) = 7
		description: 'Encode/decode Integer type for 0'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 1 ; bytes) at: 1) = 8
		description: 'Encode/decode Integer type for 1'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r7f ; bytes) at: 1) = 8
		description: 'Encode/decode Integer type for 16r7f'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r80 ; bytes) at: 1) = 9
		description: 'Encode/decode Integer type for 16r80'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r7fff ; bytes) at: 1) = 9
		description: 'Encode/decode Integer type for 16r7fff'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r8000 ; bytes) at: 1) = 10
		description: 'Encode/decode Integer type for 16r8000'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r7fffff ; bytes) at: 1) = 10
		description: 'Encode/decode Integer type for 16r7fffff'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r800000 ; bytes) at: 1) = 11
		description: 'Encode/decode Integer type for 16r800000'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r7fffffff ; bytes) at: 1) = 11
		description: 'Encode/decode Integer type for 16r7fffffff'.
	self
		assert: ((CpObjectEncoder new encodeInteger: 16r80000000 ; bytes) at: 1) = 12
		description: 'Encode/decode Integer type for 16r80000000'

]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testString [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeString: 'hello world' ; bytes)) decodeNext = 'hello world'
		description: 'Encode/decode String ''hello world'''.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeString: '' ; bytes)) decodeNext = ''
		description: 'Encode/decode String '''''.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeString: 'éîüç§≈≥×≡' ; bytes)) decodeNext = 'éîüç§≈≥×≡'
		description: 'Encode/decode String ''éîüç§≈≥×≡'''.
	self
		assert: (CpObjectDecoder on: 'Hello' cpEncoded) decodeNext = 'Hello'
		description: 'Decode an encoded String'.
	self assert: (CpObjectDecoder on: '<mtable columnalign="left"><mtr><mtd><mrow><mrow><mrow><mrow> <mi>a</mi> <mo>⁢</mo> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mo>⁢</mo> <mi>x</mi> </mrow> <mo> + </mo> <mi>c</mi> </mrow> <mo>=</mo> <mn>0</mn> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mi>a</mi> <mo>⁢</mo> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mo>⁢</mo> <mi>x</mi> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mrow> <mo>=</mo> <mo>-</mo><mi> c</mi><mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mo>⁤</mo> <mi>x</mi> </mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>c</mi> </mrow> <mi>a</mi> </mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Divide out leading coefficient.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mo>⁤</mo> <mi>x</mi> <mo> + </mo> <msup> <mfenced> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mfenced> <mn>2</mn> </msup> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>c</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow> <mrow> <mi>a</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow></mfrac> </mrow> <mo> + </mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Complete the square.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Discriminant revealed.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mrow> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> </mrow> <mn>2</mn> </msup> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mo>=</mo> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">There''s the vertex formula.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi> b</mi> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt></mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace> <mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> </mtable>' cpEncoded) decodeNext = '<mtable columnalign="left"><mtr><mtd><mrow><mrow><mrow><mrow> <mi>a</mi> <mo>⁢</mo> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mo>⁢</mo> <mi>x</mi> </mrow> <mo> + </mo> <mi>c</mi> </mrow> <mo>=</mo> <mn>0</mn> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mi>a</mi> <mo>⁢</mo> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mo>⁢</mo> <mi>x</mi> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mrow> <mo>=</mo> <mo>-</mo><mi> c</mi><mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mo>⁤</mo> <mi>x</mi> </mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>c</mi> </mrow> <mi>a</mi> </mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Divide out leading coefficient.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mo>⁤</mo> <mi>x</mi> <mo> + </mo> <msup> <mfenced> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mfenced> <mn>2</mn> </msup> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>c</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow> <mrow> <mi>a</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow></mfrac> </mrow> <mo> + </mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Complete the square.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Discriminant revealed.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mrow> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> </mrow> <mn>2</mn> </msup> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mo>=</mo> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">There''s the vertex formula.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi> b</mi> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt></mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace> <mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> </mtable>'
		description: 'Very long string'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testSymbol [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeSymbol: #testSymbol ; bytes)) decodeNext = #testSymbol
		description: 'Encode/decode Symbol #do:'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeSymbol: #_ ; bytes)) decodeNext = #_
		description: 'Encode/decode Symbol #_'.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeSymbol: #' ' ; bytes)) decodeNext = #' '
		description: 'Encode/decode Symbol #'' '''.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeSymbol: #'' ; bytes)) decodeNext = #''
		description: 'Encode/decode Symbol #'''''.
	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeSymbol: #to:do: ; bytes)) decodeNext = #to:do:
		description: 'Encode/decode Symbol #to:do:'.
	self
		assert: (CpObjectDecoder on: #test cpEncoded) decodeNext == #test
		description: 'Decode an encoded Symbol'
]

{ #category : #tests }
CpEncodeDecodeObjectTest >> testTrue [

	self
		assert: (CpObjectDecoder on: (CpObjectEncoder new encodeTrue ; bytes)) decodeNext == true
		description: 'Encode/decode true'.
	self
		assert: (CpObjectDecoder on: true cpEncoded) decodeNext == true
		description: 'Decode an encoded true'
]
