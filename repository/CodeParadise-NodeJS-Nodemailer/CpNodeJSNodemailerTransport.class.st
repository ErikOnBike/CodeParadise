Class {
	#name : #CpNodeJSNodemailerTransport,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #'accessing - content' }
CpNodeJSNodemailerTransport >> attachDataUrls [

	"if true then convert data: images in the HTML content of this message to embedded attachments"

	^ options at: #attachDataUrls
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerTransport >> attachDataUrls: aBoolean [

	"if true then convert data: images in the HTML content of this message to embedded attachments"

	options at: #attachDataUrls put: aBoolean
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerTransport >> disableFileAccess [

	"if true, then does not allow to use files as content. Use it when you want to use JSON data from untrusted source as the email. If an attachment or message node tries to fetch something from a file the sending returns an error"

	^ options at: #disableFileAccess
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerTransport >> disableFileAccess: aBoolean [

	"if true, then does not allow to use files as content. Use it when you want to use JSON data from untrusted source as the email. If an attachment or message node tries to fetch something from a file the sending returns an error"

	options at: #disableFileAccess put: aBoolean
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerTransport >> disableUrlAccess [

	"if true, then does not allow to use Urls as content"

	^ options at: #disableUrlAccess
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerTransport >> disableUrlAccess: aBoolean [

	"if true, then does not allow to use Urls as content"

	options at: #disableUrlAccess put: aBoolean
]

{ #category : #'accessing - signing' }
CpNodeJSNodemailerTransport >> dkim [

	"Answer the DKIM definition of the receiver"

	^ options at: #dkim
]

{ #category : #'accessing - signing' }
CpNodeJSNodemailerTransport >> dkim: aDKIM [

	"Set the DKIM definition for the receiver.

	See also: class CpNodeJSNodemailerDKIM"

	options at: #dkim put: aDKIM
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerTransport >> normalizeHeaderKey [

	"a method that is applied to every header key before inserting to generated rfc822 message.

	Implementation:
	This method tries to answer a Smalltalk Block if it is used to set the normalizer, otherwise
	the JavaScript Function (wrapper) is answered."

	^ (options at: #normalizeHeaderKey)
		ifNotNil: [ :normalizer |
			normalizer asBlock
				ifNil: [ normalizer ] ]
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerTransport >> normalizeHeaderKey: aBlock [

	"a method that is applied to every header key before inserting to generated rfc822 message.

	The specified Block is responsible for converting the single String provided into a normalized
	String value."

	options at: #normalizeHeaderKey put: (CpJavaScriptFunction wrap: aBlock)
]
