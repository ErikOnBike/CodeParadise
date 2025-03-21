Class {
	#name : #CpNodeJSNodemailerDKIMKey,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> domainName [

	"The domain name to use in the signature"

	^ options at: #domainName
]

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> domainName: aString [

	"The domain name to use in the signature"

	options at: #domainName put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> keySelector [

	"The DKIM key selector"

	^ options at: #keySelector
]

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> keySelector: aString [

	"The DKIM key selector"

	options at: #keySelector put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> privateKey [

	"The private key for the selector in PEM format"

	^ options at: #privateKey
]

{ #category : #accessing }
CpNodeJSNodemailerDKIMKey >> privateKey: aString [

	"The private key for the selector in PEM format"

	options at: #privateKey put: aString
]
