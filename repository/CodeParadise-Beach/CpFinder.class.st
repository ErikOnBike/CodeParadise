Class {
	#name : #CpFinder,
	#superclass : #Object,
	#instVars : [
		'globals'
	],
	#classVars : [
		'Current'
	],
	#category : #'CodeParadise-Beach-Browsers'
}

{ #category : #api }
CpFinder class >> allClassesWhereNameBeginsWith: aString [

	^ self current allClassesWhereNameBeginsWith: aString
]

{ #category : #api }
CpFinder class >> allClassesWhereNameEndsWith: aString [

	^ self current allClassesWhereNameEndsWith: aString
]

{ #category : #api }
CpFinder class >> allClassesWhereNameIncludes: aString [

	^ self current allClassesWhereNameIncludes: aString
]

{ #category : #api }
CpFinder class >> allImplementorsOf: aSymbol [

	^ self current allImplementorsOf: aSymbol
]

{ #category : #api }
CpFinder class >> allMethodsSending: aSymbol [

	^ self current allMethodsSending: aSymbol
]

{ #category : #api }
CpFinder class >> allMethodsWhereSelectorBeginsWith: aString [

	^ self current allMethodsWhereSelectorBeginsWith: aString
]

{ #category : #api }
CpFinder class >> allMethodsWhereSelectorEndsWith: aString [

	^ self current allMethodsWhereSelectorEndsWith: aString
]

{ #category : #api }
CpFinder class >> allMethodsWhereSelectorIncludes: aString [

	^ self current allMethodsWhereSelectorIncludes: aString
]

{ #category : #api }
CpFinder class >> allSendersOf: aSymbol [

	"Convenience method"

	^ self current allMethodsSending: aSymbol
]

{ #category : #accessing }
CpFinder class >> current [

	^ Current ifNil: [ Current := self basicNew initialize ; yourself  ]
]

{ #category : #accessing }
CpFinder class >> new [

	"Use self >> #current instead to get the singleton instance"

	^ self error: 'The Finder should not be instantiated through #new, use #current instead'
]

{ #category : #enumerating }
CpFinder >> allClassesDo: aBlock [

	self globals allClassesDo: aBlock
]

{ #category : #api }
CpFinder >> allClassesSelect: aBlock [

	| classes |

	classes := OrderedCollection streamContents: [ :stream |
		self allClassesDo: [ :each |
			(aBlock value: each)
				ifTrue: [ stream nextPut: each ] ] ].

	^ classes asSortedCollection: [ :a :b | a name <= b name ]
]

{ #category : #api }
CpFinder >> allClassesWhereNameBeginsWith: aString [

	^ self allClassesSelect: [ :each | each name beginsWith: aString ]
]

{ #category : #api }
CpFinder >> allClassesWhereNameEndsWith: aString [

	^ self allClassesSelect: [ :each | each name endsWith: aString ]
]

{ #category : #api }
CpFinder >> allClassesWhereNameIncludes: aString [

	^ self allClassesSelect: [ :each | each name includesSubstring: aString ]
]

{ #category : #api }
CpFinder >> allImplementorsOf: aSymbol [

	^ self allMethodsSelect: [ :each | each selector = aSymbol ]
]

{ #category : #enumerating }
CpFinder >> allMethodsDo: aBlock [

	self allClassesDo: [ :each | each methodsDo: aBlock ]
]

{ #category : #api }
CpFinder >> allMethodsSelect: aBlock [

	| methods |

	methods := OrderedCollection streamContents: [ :stream |
		self allMethodsDo: [ :each |
			(aBlock value: each)
				ifTrue: [ stream nextPut: each methodReference ] ] ].

	^ methods asSortedCollection: [ :a :b | a selector <= b selector ]
]

{ #category : #api }
CpFinder >> allMethodsSending: aSymbol [

	^ self allMethodsSelect: [ :each | each sendsOrRefersTo: aSymbol ]
]

{ #category : #api }
CpFinder >> allMethodsWhereSelectorBeginsWith: aString [

	^ self allMethodsSelect: [ :each | each selector beginsWith: aString ]
]

{ #category : #api }
CpFinder >> allMethodsWhereSelectorEndsWith: aString [

	^ self allMethodsSelect: [ :each | each selector endsWith: aString ]
]

{ #category : #api }
CpFinder >> allMethodsWhereSelectorIncludes: aString [

	^ self allMethodsSelect: [ :each | each selector includesSubstring: aString ]
]

{ #category : #api }
CpFinder >> allSendersOf: aSymbol [

	"Convenience method"

	^ self allMethodsSending: aSymbol
]

{ #category : #accessing }
CpFinder >> globals [

	^ globals
]

{ #category : #initialization }
CpFinder >> initialize [

	super initialize.

	globals := Smalltalk globals
]
