Class {
	#name : #CpDocument,
	#superclass : #CpModel,
	#instVars : [
		'content'
	],
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpDocument >> content [

	^ content ifNil: [ '' ]
]

{ #category : #accessing }
CpDocument >> content: aString [

	content = aString
		ifTrue: [ ^ self ].

	content := aString.

	self valueChanged
]
