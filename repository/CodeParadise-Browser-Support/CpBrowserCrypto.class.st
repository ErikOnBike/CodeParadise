Class {
	#name : #CpBrowserCrypto,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Crypto'
}

{ #category : #accessing }
CpBrowserCrypto class >> current [

	^ CpGlobalThis propertyAt: #crypto resultAs: self
]

{ #category : #'instance creation' }
CpBrowserCrypto class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #actions }
CpBrowserCrypto >> randomUUID [

	"Returns a randomly generated, 36 character long v4 UUID."

	^ self apply: #randomUUID
]
