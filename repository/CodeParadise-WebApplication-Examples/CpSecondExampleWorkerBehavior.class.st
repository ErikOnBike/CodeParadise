Class {
	#name : #CpSecondExampleWorkerBehavior,
	#superclass : #CpWorkerBehavior,
	#category : #'CodeParadise-WebApplication-Examples-Browser-Support'
}

{ #category : #initialization }
CpSecondExampleWorkerBehavior >> initialize [

	super initialize.

	self traceCr: 'The block-executor-Worker has started'.

	self onMessageDo: [ :input :block | self postMessage: (block value: input) ]
]
