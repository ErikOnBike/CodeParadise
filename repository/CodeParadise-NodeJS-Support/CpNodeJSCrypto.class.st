Class {
	#name : #CpNodeJSCrypto,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-Crypto'
}

{ #category : #actions }
CpNodeJSCrypto >> randomUUID [

	"Generates a random RFC 4122 version 4 UUID. The UUID is generated using a cryptographic pseudorandom number generator."

	^ self apply: #randomUUID
]
