"
I am a helper Object for the CpClientEnvironmentTest
"
Class {
	#name : #CpClientEnvironmentTestObject,
	#superclass : #Object,
	#instVars : [
		'someInstVar',
		'otherInstVar'
	],
	#classVars : [
		'SomeClassVar'
	],
	#category : #'CodeParadise-RemoteEnvironment-Tests'
}

{ #category : #accessing }
CpClientEnvironmentTestObject class >> someClassVar [

	^ SomeClassVar
]

{ #category : #accessing }
CpClientEnvironmentTestObject >> otherInstVar [

	^ otherInstVar
]

{ #category : #accessing }
CpClientEnvironmentTestObject >> someInstVar [

	^ someInstVar
]
