"
I am a Nodemailer SMTP Envelope (definition).

See https://nodemailer.com/smtp/envelope/
"
Class {
	#name : #CpNodeJSNodemailerSmtpEnvelope,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> bcc [

	"addresses from this value get added to RCPT TO list"

	^ options at: #bcc
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> bcc: aString [

	"addresses from this value get added to RCPT TO list"

	options at: #bcc put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> cc [

	"addresses from this value get added to RCPT TO list"

	^ options at: #cc
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> cc: aString [

	"addresses from this value get added to RCPT TO list"

	options at: #cc put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> from [

	"the first address gets used as MAIL FROM address in SMTP"

	^ options at: #from
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> from: aString [

	"the first address gets used as MAIL FROM address in SMTP"

	options at: #from put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> to [

	"addresses from this value get added to RCPT TO list"

	^ options at: #to
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpEnvelope >> to: aString [

	"addresses from this value get added to RCPT TO list"

	options at: #to put: aString
]
