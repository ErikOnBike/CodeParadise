Class {
	#name : #CpPartialClass,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'instSelectors',
		'classSelectors'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpPartialClass class >> new [

	self errorNewReplacedBy: #on:
]

{ #category : #'instance creation' }
CpPartialClass class >> on: aClass [

	^ self basicNew
		initializeWithClass: aClass ;
		yourself
]

{ #category : #accessing }
CpPartialClass >> addClassSelector: aSymbol [

	^ classSelectors add: aSymbol
]

{ #category : #accessing }
CpPartialClass >> addInstSelector: aSymbol [

	^ instSelectors add: aSymbol
]

{ #category : #delegating }
CpPartialClass >> classInstVarNames [

	^ theClass class instVarNames
]

{ #category : #accessing }
CpPartialClass >> classMethods [

	"Answer the method dictionary for the class methods of the receiver (answer an actual Dictionary)"

	| methods |

	"Order is actually not relevant, but this is a fast 'adding' collection"
	methods := OrderedCollection new.

	theClass classSide methodDictionary keysAndValuesDo: [ :selector :compiledMethod |
		(classSelectors includes: selector)
			ifTrue: [ methods add: compiledMethod ] ].

	^ methods
]

{ #category : #delegating }
CpPartialClass >> classVarNames [

	^ theClass classVarNames
]

{ #category : #encoding }
CpPartialClass >> cpEncodeWith: anEncoder [

	"This extension method should not be present in the ClientEnvironment!
	Otherwise classes within Announcements will be installed on the server."

	<serverEnvironment>

	anEncoder encodePartialClass: self
]

{ #category : #delegating }
CpPartialClass >> cpInstVarNames [

	^ theClass cpInstVarNames
]

{ #category : #initialization }
CpPartialClass >> initialize [

	super initialize.

	instSelectors := Set new.
	classSelectors := Set new
]

{ #category : #initialization }
CpPartialClass >> initializeWithClass: aClass [

	self initialize.

	theClass := aClass
]

{ #category : #accessing }
CpPartialClass >> instMethods [

	"Answer a collection with the instance methods of the receiver"

	| methods |

	"Order is actually not relevant, but this is a fast 'adding' collection"
	methods := OrderedCollection new.

	theClass instanceSide methodDictionary keysAndValuesDo: [ :selector :compiledMethod |
		(instSelectors includes: selector)
			ifTrue: [ methods add: compiledMethod ] ].

	^ methods
]

{ #category : #delegating }
CpPartialClass >> instVarNames [

	^ theClass instVarNames
]

{ #category : #delegating }
CpPartialClass >> name [

	^ theClass name
]

{ #category : #delegating }
CpPartialClass >> sharedPoolNames [

	^ theClass sharedPoolNames
]

{ #category : #delegating }
CpPartialClass >> superclass [

	^ theClass superclass
]
