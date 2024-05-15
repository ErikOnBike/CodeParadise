Class {
	#name : 'CpParser',
	#superclass : 'Object',
	#instVars : [
		'text',
		'parseStream',
		'tokens',
		'tokenizer'
	],
	#category : 'CodeParadise-Beach-Editor',
	#package : 'CodeParadise-Beach',
	#tag : 'Editor'
}

{ #category : 'testing' }
CpParser class >> isDigit: aCharacter [

	aCharacter ifNil: [ ^ false ].

	^ aCharacter isDigit
]

{ #category : 'testing' }
CpParser class >> isDigit: aCharacter withRadix: anInteger [

	| digitValue |

	aCharacter ifNil: [ ^ false ].

	self flag: #todo.	"Unclear whether lowercase should be supported. Blue Book defines uppercase explicitly."
	aCharacter isLowercase ifTrue: [ ^ false ].

	(digitValue := aCharacter digitValue) < 0
		ifTrue: [ ^ false ].

	^ digitValue < anInteger
]

{ #category : 'testing' }
CpParser class >> isWhitespace: aCharacter [

	^ { Character space . Character tab . Character lf . Character cr } includes: aCharacter
]

{ #category : 'parsing' }
CpParser >> parse [

	self subclassResponsibility
]

{ #category : 'initialization' }
CpParser >> resetStream [

	parseStream := ReadStream on: self text
]

{ #category : 'initialization' }
CpParser >> resetTokens [

	tokens := OrderedCollection new
]

{ #category : 'accessing' }
CpParser >> text [

	^ text
]

{ #category : 'accessing' }
CpParser >> text: aString [

	text := aString.
	self
		resetStream ;
		resetTokens
]

{ #category : 'accessing' }
CpParser >> tokenizer [

	^ tokenizer
]

{ #category : 'accessing' }
CpParser >> tokenizer: aTokenizer [

	tokenizer := aTokenizer.
	self resetTokens
]

{ #category : 'accessing' }
CpParser >> tokens [

	^ tokens
]
