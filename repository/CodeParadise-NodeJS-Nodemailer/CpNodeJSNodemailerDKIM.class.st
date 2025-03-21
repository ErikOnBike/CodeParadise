"
I am a Nodemailer DKIM definition.

See https://nodemailer.com/dkim/
"
Class {
	#name : #CpNodeJSNodemailerDKIM,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> cacheDir [

	"Optional) The location for cached messages. If not set, caching is not used."

	^ options at: #cacheDir
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> cacheDir: aString [

	"(Optional) The location for cached messages. If not set, caching is not used."

	options at: #cacheDir put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> cacheThreshold [

	"(Optional) The size in bytes after which messages are cached to disk (assuming cacheDir is set and writable). Defaults to 131072 (128 kB)."

	^ options at: #cacheThreshold
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> cacheThreshold: anInteger [

	"(Optional) The size in bytes after which messages are cached to disk (assuming cacheDir is set and writable). Defaults to 131072 (128 kB)."

	options at: #cacheThreshold put: anInteger
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> domainName [

	"The domain name to use in the signature"

	^ options at: #domainName
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> domainName: aString [

	"The domain name to use in the signature"

	options at: #domainName put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> hashAlgo [

	"(Optional) The hashing algorithm for the body hash, defaults to ‘sha256’."

	^ options at: #hashAlgo
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> hashAlgo: aString [

	"(Optional) The hashing algorithm for the body hash, defaults to ‘sha256’."

	options at: #hashAlgo put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> headerFieldNames [

	"(Optional) A colon-separated list of header fields to sign (e.g., message-id:date:from:to)."

	^ options at: #headerFieldNames
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> headerFieldNames: aString [

	"(Optional) A colon-separated list of header fields to sign (e.g., message-id:date:from:to)."

	options at: #headerFieldNames put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> keySelector [

	"The DKIM key selector"

	^ options at: #keySelector
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> keySelector: aString [

	"The DKIM key selector"

	options at: #keySelector put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> keys [

	"(Optional) An array of key objects (domainName, keySelector, privateKey) for signing with multiple keys. If this is provided, the default key values are ignored."

	^ options at: #keys
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> keys: anArray [

	"(Optional) An array of key objects (domainName, keySelector, privateKey) for signing with multiple keys. If this is provided, the default key values are ignored.

	See also: class CpNodeJSNodemailerDKIMKey"

	options at: #keys put: anArray
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> privateKey [

	"The private key for the selector in PEM format"

	^ options at: #privateKey
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> privateKey: aString [

	"The private key for the selector in PEM format"

	options at: #privateKey put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> skipFields [

	"(Optional) A colon-separated list of header fields not to sign, useful when certain fields (like Message-ID or Date) are modified by the provider."

	^ options at: #skipFields
]

{ #category : #accessing }
CpNodeJSNodemailerDKIM >> skipFields: aString [

	"(Optional) A colon-separated list of header fields not to sign, useful when certain fields (like Message-ID or Date) are modified by the provider."

	options at: #skipFields put: aString
]
