Class {
	#name : #CpCodeParser,
	#superclass : #CpParser,
	#category : #'CodeParadise-Beach-Editor'
}

{ #category : #support }
CpCodeParser >> createTokenNodeFor: aSymbol [

	^ self tokens add: (self tokenizer createTokenNodeFor: aSymbol)
]

{ #category : #support }
CpCodeParser >> createTokenNodeFor: aSymbol with: aString [

	^ self tokens add: (self tokenizer createTokenNodeFor: aSymbol with: aString)
]

{ #category : #'parsing - private' }
CpCodeParser >> parseWhitespace [

	"Scan for whitespace tokens and answer if such tokens are found.
	Create tokens for all whitespace."

	(self class isWhitespace: parseStream peek)
		ifFalse: [ ^ false ].

	[ self class isWhitespace: parseStream peek ] whileTrue: [
		self createTokenNodeFor: #whitespace with: parseStream next ].

	^ true
]
