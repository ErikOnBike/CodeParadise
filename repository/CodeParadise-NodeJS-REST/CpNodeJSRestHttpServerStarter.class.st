Class {
	#name : #CpNodeJSRestHttpServerStarter,
	#superclass : #Object,
	#category : #'CodeParadise-NodeJS-REST-Support'
}

{ #category : #'class initialization' }
CpNodeJSRestHttpServerStarter class >> postInstallOnce [

	CpNodeJSRestHttpServer newOnPort: 8181
]
