Class {
	#name : #CynRestHttpServerApplication,
	#superclass : #CpNodeApplication,
	#category : #'CodeParadise-Canyon-Data-Application'
}

{ #category : #accessing }
CynRestHttpServerApplication class >> allowedPackages [

	"Answer a collection of Packages which are allowed to contain classes to install in the receiver"

	^ super allowedPackages, {
		CpNodeJSHttpServer package .
		CpNodeJSRestHttpServer package .
		CpNodeJSSqlite3Database package .
		CpNodeJSNodemailerMessage package .
		CpNodeJSCrypto package .
		CynDatabase package .
		ValueChanged package .
		CynPropertyModel package }
]

{ #category : #accessing }
CynRestHttpServerApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(restApplicationExtension canyonModelExtension)
]

{ #category : #actions }
CynRestHttpServerApplication >> load [

	super load.

	"By default install all property slot (types)"
	CynClientPropertySlot allSubclassesDo: [ :each |
		self installClass: each ].

	self installClass: CpNodeJSRestHttpServer
]
