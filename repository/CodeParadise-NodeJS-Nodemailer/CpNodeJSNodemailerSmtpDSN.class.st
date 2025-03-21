"
I am a Nodemailer SMTP DSN definition.

https://nodemailer.com/smtp/dsn/
"
Class {
	#name : #CpNodeJSNodemailerSmtpDSN,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> id [

	"is the envelope identifier that would be included in the response (ENVID)"

	^ options at: #id
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> id: aString [

	"is the envelope identifier that would be included in the response (ENVID)"

	options at: #id put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> notify [

	"is either a string or an array of strings that define the conditions under which a DSN response should be sent. Possible values are ‘never’, ‘success’, ‘failure’ and ‘delay’. The condition ‘never’ can only appear on its own, other values can be grouped together into an array (NOTIFY)"

	^ options at: #notify
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> notify: anArrayOrString [

	"is either a string or an array of strings that define the conditions under which a DSN response should be sent. Possible values are ‘never’, ‘success’, ‘failure’ and ‘delay’. The condition ‘never’ can only appear on its own, other values can be grouped together into an array (NOTIFY)"

	options at: #notify put: anArrayOrString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> recipient [

	"is the email address the DSN should be sent (ORCPT)"

	^ options at: #recipient
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> recipient: aString [

	"is the email address the DSN should be sent (ORCPT)"

	options at: #recipient put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> return [

	"is either ‘headers’ or ‘full’. It specifies if only headers or the entire body of the message should be included in the response (RET)"

	^ options at: #return
]

{ #category : #accessing }
CpNodeJSNodemailerSmtpDSN >> return: aString [

	"is either ‘headers’ or ‘full’. It specifies if only headers or the entire body of the message should be included in the response (RET)"

	options at: #return put: aString
]
