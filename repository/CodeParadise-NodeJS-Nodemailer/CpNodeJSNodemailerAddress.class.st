"
I am a Nodemailer Address (definition).

See https://nodemailer.com/message/addresses/
"
Class {
	#name : #CpNodeJSNodemailerAddress,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerAddress >> address [

	^ options at: #address
]

{ #category : #accessing }
CpNodeJSNodemailerAddress >> address: aString [

	options at: #address put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAddress >> name [

	^ options at: #name
]

{ #category : #accessing }
CpNodeJSNodemailerAddress >> name: aString [

	options at: #name put: aString
]
