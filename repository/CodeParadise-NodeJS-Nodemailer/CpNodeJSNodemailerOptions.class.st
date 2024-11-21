Class {
	#name : #CpNodeJSNodemailerOptions,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #converting }
CpNodeJSNodemailerOptions >> asDictionary [

	^ options
]

{ #category : #initialization }
CpNodeJSNodemailerOptions >> initialize [

	super initialize.

	options := CpJsonObject new
]

{ #category : #enumerating }
CpNodeJSNodemailerOptions >> keysAndValuesDo: aBlock [

	options keysAndValuesDo: aBlock
]

{ #category : #accessing }
CpNodeJSNodemailerOptions >> merge: anObject [

	"Merge the specified Dictionary-like object into the receiver"

	anObject keysAndValuesDo: [ :key :value |
		options at: key put: value ]
]
