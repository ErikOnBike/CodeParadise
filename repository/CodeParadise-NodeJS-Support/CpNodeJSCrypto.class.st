Class {
	#name : #CpNodeJSCrypto,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-Crypto'
}

{ #category : #actions }
CpNodeJSCrypto >> pbkdf2Password: passwordString salt: saltString iterations: iterationCount keylen: keyLength digest: digestString [

	"Provides a synchronous Password-Based Key Derivation Function 2 (PBKDF2) implementation. A selected HMAC digest algorithm specified by digest is applied to derive a key of the requested byte length (keylen) from the password, salt and iterations.

	If an error occurs an Error will be thrown, otherwise the derived key will be returned as a Buffer.

	The iterations argument must be a number set as high as possible. The higher the number of iterations, the more secure the derived key will be, but will take a longer amount of time to complete.

	The salt should be as unique as possible. It is recommended that a salt is random and at least 16 bytes long. See NIST SP 800-132 for details."

	^ self apply: #pbkdf2Sync withArguments: { passwordString . saltString . iterationCount . keyLength . digestString } resultAs: CpNodeJSBuffer
]

{ #category : #actions }
CpNodeJSCrypto >> randomBytes: anInteger [

	"Generates cryptographically strong pseudorandom data. The size argument is a number indicating the number of bytes to generate.

	size <number> The number of bytes to generate. The size must not be larger than 2**31 - 1.
	Returns: <Buffer>"

	^ self apply: #randomBytes withArguments: { anInteger } resultAs: CpNodeJSBuffer
]

{ #category : #actions }
CpNodeJSCrypto >> randomUUID [

	"Generates a random RFC 4122 version 4 UUID. The UUID is generated using a cryptographic pseudorandom number generator."

	^ self apply: #randomUUID
]
