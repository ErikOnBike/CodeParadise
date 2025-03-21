"
I am a Nodemailer icalEvent (definition).

See https://nodemailer.com/message/calendar-events/
"
Class {
	#name : #CpNodeJSNodemailerIcalEvent,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> content [

	"is the event file, it can be a string, a buffer, a stream"

	^ options at: #content
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> content: anObject [

	"is the event file, it can be a string, a buffer, a stream"

	options at: #content put: anObject
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> encoding [

	"defines optional content encoding, eg. ‘base64’ or ‘hex’. This only applies if the content is a string. By default an unicode string is assumed."

	^ options at: #encoding
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> encoding: aString [

	"defines optional content encoding, eg. ‘base64’ or ‘hex’. This only applies if the content is a string. By default an unicode string is assumed."

	options at: #encoding put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> filename [

	"optional filename, defaults to ‘invite.ics’"

	^ options at: #filename
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> filename: aString [

	"optional filename, defaults to ‘invite.ics’"

	options at: #filename put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> href [

	"is an alternative for content to load the calendar data from an URL"

	^ options at: #href
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> href: aString [

	"is an alternative for content to load the calendar data from an URL"

	options at: #href put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> method [

	"optional method, case insensitive, defaults to ‘publish’. Other possible values would be ‘request’, ‘reply’, ‘cancel’ or any other valid calendar method listed in RFC5546. This should match the METHOD: value in calendar event file."

	^ options at: #method
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> method: aString [

	"optional method, case insensitive, defaults to ‘publish’. Other possible values would be ‘request’, ‘reply’, ‘cancel’ or any other valid calendar method listed in RFC5546. This should match the METHOD: value in calendar event file."

	options at: #method put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> path [

	"is an alternative for content to load the calendar data from a file"

	^ options at: #path
]

{ #category : #accessing }
CpNodeJSNodemailerIcalEvent >> path: aString [

	"is an alternative for content to load the calendar data from a file"

	options at: #path put: aString
]
