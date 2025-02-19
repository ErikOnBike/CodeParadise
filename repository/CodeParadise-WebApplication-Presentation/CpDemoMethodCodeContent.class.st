Class {
	#name : #CpDemoMethodCodeContent,
	#superclass : #CpDemoCodeContent,
	#instVars : [
		'methodClass',
		'methodClassifier'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'instance creation' }
CpDemoMethodCodeContent class >> code: aString methodClass: aClass classified: aSymbol [

	^ (self code: aString)
		methodClass: aClass classified: aSymbol ;
		yourself
]

{ #category : #operations }
CpDemoMethodCodeContent >> installMethod [

	| class |

	(class := Smalltalk classNamed: self methodClass)
		ifNil: [ self error: 'Probably installing methods before class has been created' ].
	
	class compile: self code classified: self methodClassifier.

	self valueChanged
]

{ #category : #accessing }
CpDemoMethodCodeContent >> methodClass [

	^ methodClass
]

{ #category : #accessing }
CpDemoMethodCodeContent >> methodClass: aClass classified: aSymbol [

	methodClass := aClass.
	methodClassifier := aSymbol
]

{ #category : #accessing }
CpDemoMethodCodeContent >> methodClassifier [

	^ methodClassifier
]

{ #category : #accessing }
CpDemoMethodCodeContent >> methodSelector [

	| keywords signature |

	"Assume method signature is on first line"
	signature := self code copyUpTo: Character cr.

	"Check for non-keyword message"
	(signature includes: $:)
		ifFalse: [ ^ signature asSymbol ].

	"Assume keyword message, split at colon ':'"
	keywords := signature findTokens: $:.

	"Remove last argument name"
	keywords := keywords allButLast: 1.

	"Every 2nd keyword contains an argument name (surrounded by spaces) followed by the next keyword"
	keywords withIndexDo: [ :each :index |
		index even
			ifTrue: [ keywords at: index put: (each findTokens: Character space) last ] ].

	"Re-add the colons (incl. the last)"
	^ (($: join: keywords), ':') asSymbol
]

{ #category : #accessing }
CpDemoMethodCodeContent >> otherCode [

	"Answer the code of the other method installed (assuming it is different then the receiver's code)
	or nil if no code is installed"

	| class |

	(class := Smalltalk classNamed: self methodClass)
		ifNil: [ ^ nil ].

	^ class sourceCodeAt: self methodSelector ifAbsent: [ ^ nil ]
]

{ #category : #accessing }
CpDemoMethodCodeContent >> status [

	"Answer whether the method is already installed, another method is installed or nil (if method does not exist yet)"

	| class currentCode |

	(class := Smalltalk classNamed: self methodClass)
		ifNil: [ ^ nil ].

	currentCode := class sourceCodeAt: self methodSelector ifAbsent: [ ^ nil ].

	^ self code = currentCode
		ifTrue: [ #installed ]
		ifFalse: [ #other ]
]
