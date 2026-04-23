Class {
	#name : #CpFirstExampleWorkerBehavior,
	#superclass : #CpWorkerBehavior,
	#category : #'CodeParadise-WebApplication-Examples-Browser-Support'
}

{ #category : #'event handling' }
CpFirstExampleWorkerBehavior >> handleAdd: firstInteger and: secondInteger [

	| sum |

	sum := firstInteger + secondInteger.

	self postMessage: {
		#first -> firstInteger.
		#second -> secondInteger.
		#sum -> sum } asDictionary
]

{ #category : #'event handling' }
CpFirstExampleWorkerBehavior >> handleNumbers: aCollection [

	| sum |

	self traceCr: 'Worker thread is adding numbers!'.

	aCollection size = 2
		ifTrue: [ ^ self handleAdd: aCollection first and: aCollection second ].

	sum := aCollection inject: 0 into: [ :total :each | total + each ].

	self postMessage: {
		#input -> aCollection.
		#sum -> sum } asDictionary
]

{ #category : #initialization }
CpFirstExampleWorkerBehavior >> initialize [

	super initialize.

	self traceCr: 'The numbers-adding-Worker has started'.

	self onMessage: [ :numbers | self handleNumbers: numbers ]
]
