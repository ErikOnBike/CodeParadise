Class {
	#name : #CpNodeJSSupportExampleHttpServerApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-NodeJS-Support-Examples'
}

{ #category : #accessing }
CpNodeJSSupportExampleHttpServerApplication class >> app [

	^ 'http-server-example'
]

{ #category : #actions }
CpNodeJSSupportExampleHttpServerApplication >> load [

	super load.

	self environment
		addClass: CpNodeJSExampleHttpServer
]
