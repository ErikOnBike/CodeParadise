Class {
	#name : #CpCounterApplication,
	#superclass : #CpModel,
	#instVars : [
		'local',
		'global'
	],
	#classVars : [
		'GlobalCounter'
	],
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #accessing }
CpCounterApplication class >> globalCounter [

	^ GlobalCounter ifNil: [ GlobalCounter := CpCounterModel new ]
]

{ #category : #dependencies }
CpCounterApplication class >> release [

	GlobalCounter ifNotNil: [
		GlobalCounter release.
		GlobalCounter := nil ].

	super release
]

{ #category : #accessing }
CpCounterApplication >> global [

	^ global
]

{ #category : #initialization }
CpCounterApplication >> initialize [

	super initialize.

	local := CpCounterModel new.
	global := self class globalCounter
]

{ #category : #accessing }
CpCounterApplication >> local [

	^ local
]
