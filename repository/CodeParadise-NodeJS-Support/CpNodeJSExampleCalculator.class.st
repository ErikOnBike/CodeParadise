Class {
	#name : 'CpNodeJSExampleCalculator',
	#superclass : 'Object',
	#instVars : [
		'stack'
	],
	#classVars : [
		'Current'
	],
	#category : 'CodeParadise-NodeJS-Support-Examples',
	#package : 'CodeParadise-NodeJS-Support',
	#tag : 'Examples'
}

{ #category : 'accessing' }
CpNodeJSExampleCalculator class >> current [

	^ Current ifNil: [ Current := self basicNew initialize; yourself ]
]

{ #category : 'instance creation' }
CpNodeJSExampleCalculator class >> new [

	self error: 'Please use ', #current
]

{ #category : 'calculating' }
CpNodeJSExampleCalculator >> add: aNumber [

	stack
		add: aNumber ;
		add: #+.

	^ self value
]

{ #category : 'calculating' }
CpNodeJSExampleCalculator >> divide: aNumber [

	stack
		add: aNumber ;
		add: #/.

	^ self value
]

{ #category : 'initialization' }
CpNodeJSExampleCalculator >> initialize [

	super initialize.

	stack := OrderedCollection new.
	stack add: 0
]

{ #category : 'calculating' }
CpNodeJSExampleCalculator >> multiply: aNumber [

	stack
		add: aNumber ;
		add: #*.

	^ self value
]

{ #category : 'accessing' }
CpNodeJSExampleCalculator >> reset [

	"Remove all operators and values (except initial value)"

	[ stack size > 1 ]
		whileTrue: [ stack removeLast ].

	^ self value
]

{ #category : 'calculating' }
CpNodeJSExampleCalculator >> subtract: aNumber [

	stack
		add: aNumber ;
		add: #-.

	^ self value
]

{ #category : 'accessing' }
CpNodeJSExampleCalculator >> undo [

	"Remove the last operator and value"

	stack size > 2
		ifTrue: [ stack removeLast ; removeLast ].

	^ self value
]

{ #category : 'accessing' }
CpNodeJSExampleCalculator >> value [

	"Answer the calculation as a String"

	| result value |

	result := String streamContents: [ :aStream |
		value := stack first.
		aStream print: value.
		2 to: stack size - 1 by: 2 do: [ :index |
			| nextValue operator |
			nextValue := stack at: index.
			operator := stack at: index + 1.
			aStream
				nextPutAll: operator ;
				print: nextValue.
			value := value perform: operator withArguments: { nextValue } ].

		aStream
			nextPutAll: ' = ' ;
			print: value ].

	^ result
]
