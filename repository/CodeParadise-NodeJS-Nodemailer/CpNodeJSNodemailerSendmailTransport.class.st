"
I am the Sendmail Transport (definition).

See https://nodemailer.com/transports/sendmail/
"
Class {
	#name : #CpNodeJSNodemailerSendmailTransport,
	#superclass : #CpNodeJSNodemailerTransport,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> args [

	"an optional array of command line options to pass to the sendmail command (ie. [""-f"", ""foo@example.com""]). This overrides all default arguments except for '-i' and recipient list so you need to make sure you have all required arguments set (ie. the ‘-f’ flag)."

	^ options at: #args
]

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> args: anArray [

	"an optional array of command line options to pass to the sendmail command (ie. [""-f"", ""foo@example.com""]). This overrides all default arguments except for '-i' and recipient list so you need to make sure you have all required arguments set (ie. the ‘-f’ flag)."

	options at: #args put: anArray
]

{ #category : #initialization }
CpNodeJSNodemailerSendmailTransport >> initialize [

	super initialize.

	options at: #sendmail put: true
]

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> newline [

	"either ‘windows’ or ‘unix’ (default). Forces all newlines in the output to either use Windows syntax <CR><LF> or Unix syntax <LF>"

	^ options at: #newline
]

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> newline: aString [

	"either ‘windows’ or ‘unix’ (default). Forces all newlines in the output to either use Windows syntax <CR><LF> or Unix syntax <LF>"

	options at: #newline put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> path [

	"path to the sendmail command (defaults to ‘sendmail’)"

	^ options at: #path
]

{ #category : #accessing }
CpNodeJSNodemailerSendmailTransport >> path: aString [

	"path to the sendmail command (defaults to ‘sendmail’)"

	options at: #path put: aString
]
