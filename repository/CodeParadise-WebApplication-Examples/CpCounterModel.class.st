"
I am a Counter. I have a value which can be increased and decreased.
"
Class {
	#name : #CpCounterModel,
	#superclass : #CpModel,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-WebApplication-Examples-MVP'
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
