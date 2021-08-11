Class {
	#name : #CpSmalltalkParserTest,
	#superclass : #TestCase,
	#category : #'CodeParadise-Beach-Tests'
}

{ #category : #tests }
CpSmalltalkParserTest >> testDigits [

	self assert: (CpParser isDigit: $0) description: '0 is digit'.
	self assert: (CpParser isDigit: $5) description: '5 is digit'.
	self assert: (CpParser isDigit: $9) description: '9 is digit'.
	self deny: (CpParser isDigit: $A) description: 'A is not a digit'.
	self deny: (CpParser isDigit: $Z) description: 'Z is not a digit'.
	self deny: (CpParser isDigit: $8 withRadix: 8) description: '8 is not a digit with radix 8'.
	self assert: (CpParser isDigit: $8 withRadix: 9) description: '8 is a digit with radix 9'.	
	self assert: (CpParser isDigit: $A withRadix: 11) description: 'A is digit with radix 11'.
	self deny: (CpParser isDigit: $a withRadix: 11) description: 'a is not a digit with radix 11'.
	self deny: (CpParser isDigit: $F withRadix: 15) description: 'F is not digit with radix 15'.
	self assert: (CpParser isDigit: $F withRadix: 16) description: 'F is digit with radix 16'.
	self deny: (CpParser isDigit: $Z withRadix: 35) description: 'Z is not digit with radix 35'.
	self assert: (CpParser isDigit: $Z withRadix: 36) description: 'Z is digit with radix 36'.
	self assert: (CpParser isDigit: $Z withRadix: 350) description: 'Z is digit with radix 350'
]

{ #category : #tests }
CpSmalltalkParserTest >> testLiteralFloatingPointNumber [

	| parser streamIndex |

	parser := CpSmalltalkParser new.
	parser tokenizer: CpEditorTokenizer new.
	streamIndex := CpSmalltalkParser allInstVarNames indexOf: #parseStream.
	(streamIndex = 0 or: [ (parser instVarAt: streamIndex) notNil ])
		ifTrue: [ self error: 'Failed to find private parseStream instance variable within parser' ].

	parser text: '0.0'.
	self assert: parser parseLiteralNumber description: 'Parse single digits floating point literal number'.
	self assert: parser tokens size = 1 description: 'Single digits floating point number'.
	self assert: (parser instVarAt: streamIndex) atEnd description: 'Full single digits floating point number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '0.0' description: 'Correct single digits floating point number'.

	parser text: '123.45x'.
	self assert: parser parseLiteralNumber description: 'Parse floating point literal number'.
	self assert: parser tokens size = 1 description: 'Floating point number'.
	self assert: (parser instVarAt: streamIndex) peek = $x description: 'Full floating point literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '123.45' description: 'Correct floating point number'.

	parser text: '123.45e3estimated'.
	self assert: parser parseLiteralNumber description: 'Parse floating point with exponent literal number'.
	self assert: parser tokens size = 1 description: 'Floating point number with exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full floating point with exponent literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '123.45e3' description: 'Correct floating point with exponent number'.

]

{ #category : #tests }
CpSmalltalkParserTest >> testLiteralIntegerNumber [

	| parser streamIndex |

	parser := CpSmalltalkParser new.
	parser tokenizer: CpEditorTokenizer new.
	streamIndex := CpSmalltalkParser allInstVarNames indexOf: #parseStream.
	(streamIndex = 0 or: [ (parser instVarAt: streamIndex) notNil ])
		ifTrue: [ self error: 'Failed to find private parseStream instance variable within parser' ].

	parser text: '0'.
	self assert: parser parseLiteralNumber description: 'Parse single digit literal number'.
	self assert: parser tokens size = 1 description: 'Single digit number'.
	self assert: (parser instVarAt: streamIndex) atEnd description: 'Full single digit number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '0' description: 'Correct single digit number'.

	parser text: '123a'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit literal number'.
	self assert: parser tokens size = 1 description: 'Multiple digits number'.
	self assert: (parser instVarAt: streamIndex) peek = $a description: 'Full multi digit literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '123' description: 'Correct multi digit number'.

	parser text: '123e'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit literal number without exponent'.
	self assert: parser tokens size = 1 description: 'Multiple digits number without exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full multi digit literal number without exponent parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '123' description: 'Correct multi digit number without exponent'.

	parser text: '987e3estimated'.
	self assert: parser parseLiteralNumber description: 'Parse integer with exponent literal number'.
	self assert: parser tokens size = 1 description: 'Integer with exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full integer with exponent literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '987e3' description: 'Correct integer with exponent number'
]

{ #category : #tests }
CpSmalltalkParserTest >> testLiteralIntegerWithRadixNumber [

	| parser streamIndex |

	parser := CpSmalltalkParser new.
	parser tokenizer: CpEditorTokenizer new.
	streamIndex := CpSmalltalkParser allInstVarNames indexOf: #parseStream.
	(streamIndex = 0 or: [ (parser instVarAt: streamIndex) notNil ])
		ifTrue: [ self error: 'Failed to find private parseStream instance variable within parser' ].

	parser text: '2r1'.
	self assert: parser parseLiteralNumber description: 'Parse single digit with radix literal number'.
	self assert: parser tokens size = 1 description: 'Single digit with radix number'.
	self assert: (parser instVarAt: streamIndex) atEnd description: 'Full single digit with radix number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '2r1' description: 'Correct single digit with radix number'.

	parser text: '16rAa'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit with radix literal number'.
	self assert: parser tokens size = 1 description: 'Multiple digits with radix number'.
	self assert: (parser instVarAt: streamIndex) peek = $a description: 'Full multi digit with radix literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '16rA' description: 'Correct multi digit with radix number'.

	parser text: '8r7e'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit with radix literal number without exponent'.
	self assert: parser tokens size = 1 description: 'Multiple digits with radix number without exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full multi digit with radix literal number without exponent parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '8r7' description: 'Correct multi digit with radix number without exponent'.

	parser text: '8r7e3estimated'.
	self assert: parser parseLiteralNumber description: 'Parse integer with radix and exponent literal number'.
	self assert: parser tokens size = 1 description: 'Integer with radix and exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full integer with radix and exponent literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '8r7e3' description: 'Correct integer with radix and exponent number'
]

{ #category : #tests }
CpSmalltalkParserTest >> testLiteralNegativeFloatingPointNumber [

	| parser streamIndex |

	parser := CpSmalltalkParser new.
	parser tokenizer: CpEditorTokenizer new.
	streamIndex := CpSmalltalkParser allInstVarNames indexOf: #parseStream.
	(streamIndex = 0 or: [ (parser instVarAt: streamIndex) notNil ])
		ifTrue: [ self error: 'Failed to find private parseStream instance variable within parser' ].

	parser text: '-0.0'.
	self assert: parser parseLiteralNumber description: 'Parse single digits floating point literal number'.
	self assert: parser tokens size = 1 description: 'Single digits floating point number'.
	self assert: (parser instVarAt: streamIndex) atEnd description: 'Full single digits floating point number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-0.0' description: 'Correct single digits floating point number'.

	parser text: '-123.45x'.
	self assert: parser parseLiteralNumber description: 'Parse floating point literal number'.
	self assert: parser tokens size = 1 description: 'Floating point number'.
	self assert: (parser instVarAt: streamIndex) peek = $x description: 'Full floating point literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-123.45' description: 'Correct floating point number'.

	parser text: '-123.45e3estimated'.
	self assert: parser parseLiteralNumber description: 'Parse floating point with exponent literal number'.
	self assert: parser tokens size = 1 description: 'Floating point number with exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full floating point with exponent literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-123.45e3' description: 'Correct floating point with exponent number'.

]

{ #category : #tests }
CpSmalltalkParserTest >> testLiteralNegativeIntegerNumber [

	| parser streamIndex |

	parser := CpSmalltalkParser new.
	parser tokenizer: CpEditorTokenizer new.
	streamIndex := CpSmalltalkParser allInstVarNames indexOf: #parseStream.
	(streamIndex = 0 or: [ (parser instVarAt: streamIndex) notNil ])
		ifTrue: [ self error: 'Failed to find private parseStream instance variable within parser' ].

	parser text: '-0'.
	self assert: parser parseLiteralNumber description: 'Parse single digit literal number'.
	self assert: parser tokens size = 1 description: 'Single digit number'.
	self assert: (parser instVarAt: streamIndex) atEnd description: 'Full single digit number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-0' description: 'Correct single digit number'.

	parser text: '-123a'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit literal number'.
	self assert: parser tokens size = 1 description: 'Multiple digits number'.
	self assert: (parser instVarAt: streamIndex) peek = $a description: 'Full multi digit literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-123' description: 'Correct multi digit number'.

	parser text: '-123e'.
	self assert: parser parseLiteralNumber description: 'Parse multi digit literal number without exponent'.
	self assert: parser tokens size = 1 description: 'Multiple digits number without exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full multi digit literal number without exponent parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-123' description: 'Correct multi digit number without exponent'.

	parser text: '-987e3estimated'.
	self assert: parser parseLiteralNumber description: 'Parse integer with exponent literal number'.
	self assert: parser tokens size = 1 description: 'Integer with exponent'.
	self assert: (parser instVarAt: streamIndex) peek = $e description: 'Full integer with exponent literal number parsed'.
	self assert: (CpEditorTokenizer getValueFromNode: parser tokens first) = '-987e3' description: 'Correct integer with exponent number'
]
