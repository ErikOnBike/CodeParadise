"
I am a Counter. I have a value which can be increased and decreased.
"
Class {
	#name : #CpCounterModel,
	#superclass : #Model,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-WebApplication-Examples'
}

{ #category : #accessing }
CpCounterModel >> decrease [

	value := value - 1.

	self valueChanged
]

{ #category : #accessing }
CpCounterModel >> increase [

	value := value + 1.

	self valueChanged
]

{ #category : #initialization }
CpCounterModel >> initialize [

	super initialize.

	value := 0
]

{ #category : #accessing }
CpCounterModel >> value [

	^ value
]
