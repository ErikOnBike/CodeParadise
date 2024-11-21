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
