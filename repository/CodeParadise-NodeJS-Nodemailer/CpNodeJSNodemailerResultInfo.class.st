"
I am a result info (definition).

See https://nodemailer.com/usage/#sending-mail

"
Class {
	#name : #CpNodeJSNodemailerResultInfo,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #'instance creation' }
CpNodeJSNodemailerResultInfo class >> from: aDictionary [

	^ self basicNew
		initializeFrom: aDictionary ;
		yourself
]

{ #category : #'accessing - smtp' }
CpNodeJSNodemailerResultInfo >> accepted [

	"is an array returned by SMTP transports (includes recipient addresses that were accepted by the server)"

	^ options at: #accepted
]

{ #category : #accessing }
CpNodeJSNodemailerResultInfo >> envelope [

	"includes the envelope object for the message"

	^ options at: #envelope
]

{ #category : #initialization }
CpNodeJSNodemailerResultInfo >> initializeFrom: aDictionary [

	"Initialize the receiver with the specified Dictionary
	(received from CpNodeJSNodemailerTransport >> #sendMail:thenDo:

	See also: https://nodemailer.com/usage/#sending-mail"

	self initialize.

	aDictionary ifNil: [ ^ self ].

	"Add result info the the receiver, catch exceptions and store description"
	[
		aDictionary keysAndValuesDo: [ :key :value |
			value
				ifNotNil: [ options at: key put: value ] ]
	] on: Error do: [ :err |
		options at: #internalError put: err description
	]
]

{ #category : #accessing }
CpNodeJSNodemailerResultInfo >> messageId [

	"most transports should return the final Message-Id value used with this property"

	^ options at: #messageId
]

{ #category : #'accessing - smtp' }
CpNodeJSNodemailerResultInfo >> pending [

	"is an array returned by Direct SMTP transport. Includes recipient addresses that were temporarily rejected together with the server response"

	^ options at: #pending
]

{ #category : #'accessing - smtp' }
CpNodeJSNodemailerResultInfo >> rejected [

	"is an array returned by SMTP transports (includes recipient addresses that were rejected by the server)"

	^ options at: #rejected
]

{ #category : #accessing }
CpNodeJSNodemailerResultInfo >> response [

	"is a string returned by SMTP transports and includes the last SMTP response from the server.

	A fixed String 'Messages queued for delivery' (content might change in future versions of Nodemaile) for sendmail transport."

	^ options at: #response
]
