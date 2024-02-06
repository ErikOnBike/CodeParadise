Class {
	#name : #CpDemoClassDefinitionCodeContent,
	#superclass : #CpDemoExecutableCodeContent,
	#instVars : [
		'superclassName',
		'className',
		'slotNames',
		'packageName'
	],
	#category : 'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #testing }
CpDemoClassDefinitionCodeContent class >> isRecentVersion [

	"Answer whether the receiver is running in a recent Pharo version (or has fluid classes selected as default option)"

	[
		| classDefinitionPrinterClass |
		classDefinitionPrinterClass := Smalltalk classNamed: #ClassDefinitionPrinter.
		(SystemVersion current major >= 11 or: [ classDefinitionPrinterClass isNotNil and: [ classDefinitionPrinterClass showFluidClassDefinition ] ])
			ifTrue: [ ^ true ]
	 ] on: Error do: [ "Ignore error, probably older version" ].

	^ false
]

{ #category : #'instance creation' }
CpDemoClassDefinitionCodeContent class >> superclassName: superclassName className: className slotNames: slotNames packageName: packageName [

	| code |

	code := String streamContents: [ :stream |
		self isRecentVersion
			ifTrue: [
				stream
					nextPutAll: superclassName ; nextPutAll: ' << #' ; nextPutAll: className ; cr ;
					tab ; nextPutAll: 'slots: {'.
				slotNames do: [ :each | stream nextPutAll: ' #' ; nextPutAll: each ; space ] separatedBy: [ stream nextPutAll: '.' ].
				stream
					nextPutAll: '};' ; cr ;
					tab ; nextPutAll: 'package: ''' ; nextPutAll: packageName ; nextPutAll: '''.' ]
			ifFalse: [
				stream
					nextPutAll: superclassName ; nextPutAll: ' subclass: #' ; nextPutAll: className ; cr ;
					tab ; nextPutAll: 'instanceVariableNames: '''.
				slotNames do: [ :each | stream nextPutAll: each ] separatedBy: [ stream space ].
				stream
					nextPut: $' ; cr ;
					tab ; nextPutAll: 'classVariableNames: ''''' ; cr ;
					tab ; nextPutAll: 'package: ''' ; nextPutAll: packageName ; nextPutAll: '''.' ] ].

	^ (self code: code)
		superclassName: superclassName ;
		className: className ;
		slotNames: slotNames ;
		packageName: packageName ;
		yourself
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> className: aSymbol [

	className := aSymbol
]

{ #category : #'do-its' }
CpDemoClassDefinitionCodeContent >> doIt [

	super doIt.

	self valueChanged
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> otherCode [

	"Answer the code of the other class defnition installed (assuming it is different then the receiver's code)
	or nil if no code is installed"

	| class |

	(class := Smalltalk classNamed: className)
		ifNil: [ ^ nil ].

	^ class definitionString
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> packageName: aSymbol [

	packageName := aSymbol
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> slotNames: aCollection [

	slotNames := aCollection
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> status [

	"Answer whether the method is already installed, another method is installed or nil (if method does not exist yet)"

	| class |

	(class := Smalltalk classNamed: className)
		ifNil: [ ^ nil ].

	^ (class superclass name = superclassName
		and: [ class slotNames asSet = slotNames asSet
			and: [ class package name = packageName ] ])
		ifTrue: [ #installed ]
		ifFalse: [ #other ]
]

{ #category : #accessing }
CpDemoClassDefinitionCodeContent >> superclassName: aSymbol [

	superclassName := aSymbol
]
