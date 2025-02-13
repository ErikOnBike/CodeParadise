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

	^ options asDictionary
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

{ #category : #printing }
CpNodeJSNodemailerOptions >> printOn: aStream [

	aStream
		nextPutAll: (self class name withoutPrefix: CpNodeJSNodemailer name) ;
		nextPut: $( ;
		print: options ;
		nextPut: $)
]
