"
I am a LanguageVolume. I am responsible for providing text (String) values
when looking up text values.

I maintain a collection of TextVariants which store different variants of a
certain text. These variants can be ""regular"", ""cardinal"", ""ordinal"".
I delegate the lookup for the specific variant to the TextVariant matching
the lookup value requested.

"
Class {
	#name : #CpLanguageVolume,
	#superclass : #Object,
	#instVars : [
		'textVariants'
	],
	#category : #'CodeParadise-Canyon-Model-Language'
}

{ #category : #initialization }
CpLanguageVolume >> initialize [

	super initialize.

	textVariants := Dictionary new
]

{ #category : #accessing }
CpLanguageVolume >> lookup: aTextLookup [

	"Lookup the text specified in the receiver's TextVariants and answer it.
	Answer nil if no matching text is found.

	Implementation:
	TextVariants are stored based on a key (Symbol). Within the TextVariant
	the appropriate variant (regular, ordinal, cardinal) is looked up."

	^ (textVariants at: aTextLookup key ifAbsent: [ ^ nil ])
		lookup: aTextLookup
]
