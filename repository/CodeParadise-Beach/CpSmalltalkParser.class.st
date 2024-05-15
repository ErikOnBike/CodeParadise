Class {
	#name : 'CpSmalltalkParser',
	#superclass : 'CpCodeParser',
	#instVars : [
		'context'
	],
	#category : 'CodeParadise-Beach-Editor',
	#package : 'CodeParadise-Beach',
	#tag : 'Editor'
}

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseDigitsWithRadix: anInteger into: aStream [

	"Scan for digits of specified radix and store result on specified stream.
	Answer the value (an Integer) of the digits parsed.
	Implementation: assume the caller knows numbers are available."

	| value |

	value := 0.

	[ self class isDigit: parseStream peek withRadix: anInteger ] whileTrue: [
		| digit |

		digit := parseStream next.
		value := value * anInteger + digit digitValue.
		aStream nextPut: digit ].

	^ value
]

{ #category : 'parsing' }
CpSmalltalkParser >> parseLiteral [

	"Scan for literal token and answer if such token is found.
	Create token if found."

	| firstChar |

	parseStream atEnd
		ifTrue: [ ^ false ].

	firstChar := parseStream peek.
	(firstChar isDigit or: [ firstChar = $- and: [ self class isDigit: (parseStream lookAheadAt: 1) ] ])
		ifTrue: [  ^ self parseLiteralNumber ].
	firstChar = $$
		ifTrue: [ ^ self parseLiteralCharacter ].
	firstChar = $'
		ifTrue: [ ^ self parseLiteralString ].
	firstChar = $#
		ifTrue: [
			(parseStream lookAheadAt: 1) = $(
				ifTrue: [ ^ self parseLiteralArray ].
			^ self parseLiteralSymbol ].

	^ false
]

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseLiteralArray [

	"Scan for literal array token and answer if such token is found.
	Create token if found."

	^ false
]

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseLiteralCharacter [

	"Scan for literal character token and answer if such token is found.
	Create token if found."

	^ false
]

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseLiteralNumber [

	"Scan for literal number token and answer if such token is found.
	Create token if found.
	Implementation: assume the caller knows numbers are available and a token will be created."

	| numberString radix |

	numberString := String streamContents: [ :stream |

		"Parse (optional) minus"
		parseStream peek = $-
			ifTrue: [ stream nextPut: parseStream next ].

		"Parse integer part or radix (don't know yet, assume radix)"
		radix := self parseDigitsWithRadix: 10 into: stream.

		"Parse (optional) radix"
		(parseStream peek = $r and: [ self class isDigit: (parseStream lookAheadAt: 1) withRadix: radix ])
			ifTrue: [
				stream nextPut: parseStream next.	"Skip $r"

				"Validate radix value is allowed/usable"
				radix = 0
					ifTrue: [ self halt ].				
				radix > 36
					ifTrue: [ self halt ].

				self parseDigitsWithRadix: radix into: stream ]
			ifFalse: [ radix := 10 ].

		"Parse (optional) decimal part"
		(parseStream peek = $. and: [ self class isDigit: (parseStream lookAheadAt: 1) withRadix: radix ])
			ifTrue: [
				stream nextPut: parseStream next.	"skip $."
				self parseDigitsWithRadix: radix into: stream ].

		"Parse (optional) exponent part"
		(parseStream peek = $e and: [ self class isDigit: (parseStream lookAheadAt: 1) ])
			ifTrue: [
				stream nextPut: parseStream next.	"skip $e"
				self parseDigitsWithRadix: 10 into: stream ] ].

	"Create token for number"
	self createTokenNodeFor: #number with: numberString.

	^ true
]

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseLiteralString [

	"Scan for literal string token and answer if such token is found.
	Create token if found."

	^ false
]

{ #category : 'parsing - private' }
CpSmalltalkParser >> parseLiteralSymbol [

	"Scan for literal symbol token and answer if such token is found.
	Create token if found."

	^ false
]
