"
I am the module for Nodemailer.

Do not forget to include 'nodemailer' in your package dependencies.

The Nodemailer implementation is capable of sending mail using either
SMTP or sendmail as transport mechanism. Other transport mechanisms
are not availble (yet) but can be added in separate package(s).

Most features are available EXCEPT for the following:
- Plugins are not supported (yet)
- OAuth2 is not supported (yet)

Implementation:
This Nodemailer implementation uses callbacks instead of Promises.
If needed some extension methods can be added which provide results
through Promises.

Since Nodemailer uses declarative definitions for both transport as
well as messages and results, these definitions are implemented as
wrappers around a Dictionary. This makes it clear which options are
available and allows the code completion and/or help to be usable.

See https://nodemailer.com
"
Class {
	#name : #CpNodeJSNodemailer,
	#superclass : #CpNodeJSImportedModule,
	#category : #'CodeParadise-NodeJS-Nodemailer-Core'
}

{ #category : #'instance creation' }
CpNodeJSNodemailer class >> createTransport: aTransportOptions [

	^ self createTransport: aTransportOptions withDefaults: Dictionary new
]

{ #category : #'instance creation' }
CpNodeJSNodemailer class >> createTransport: aTransportOptions withDefaults: aMessage [

	"Create and answer an instance of a Transporter.

	aTransportOptions: transport is the transport configuration object, connection url or a transport plugin instance
	aMessage: defaults is an object that defines default values for mail options"

	^ self apply: #createTransport withArguments: { aTransportOptions asDictionary . aMessage asDictionary }
]

{ #category : #accessing }
CpNodeJSNodemailer class >> moduleName [

	^ 'nodemailer'
]
