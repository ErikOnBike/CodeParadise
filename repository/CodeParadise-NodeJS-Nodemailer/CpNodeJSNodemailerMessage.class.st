"
I am a Nodemailer Message (definition).

See https://nodemailer.com/message/
"
Class {
	#name : #CpNodeJSNodemailerMessage,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> alternatives [

	"An array of alternative text contents (in addition to text and html parts)"

	^ options at: #alternatives
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> alternatives: anArray [

	"An array of alternative text contents (in addition to text and html parts).

	See also: https://nodemailer.com/message/alternatives/
	See also: class CpNodeJSNodemailerAttachment"

	options at: #alternatives put: anArray
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> amp [

	"AMP4EMAIL specific HTML version of the message, same usage as with text and html"

	^ options at: #amp
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> amp: anObject [

	"AMP4EMAIL specific HTML version of the message, same usage as with text and html.

	See also: #html:
	Seel also: https://nodemailer.com/message/#amp-example"

	options at: #amp put: anObject
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> attachDataUrls [

	"if true then convert data: images in the HTML content of this message to embedded attachments"

	^ options at: #attachDataUrls
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> attachDataUrls: aBoolean [

	"if true then convert data: images in the HTML content of this message to embedded attachments"

	options at: #attachDataUrls put: aBoolean
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> attachments [

	"An array of attachment objects (see Using attachments for details). Attachments can be used for embedding images as well."

	^ options at: #attachments
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> attachments: anArray [

	"An array of attachment objects. Attachments can be used for embedding images as well.

	See also: class CpNodeJSNodemailerAttachment
	See also: https://nodemailer.com/message/attachments/"

	options at: #attachments put: anArray
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> bcc [

	"Comma separated list or an array of recipients email addresses that will appear on the Bcc: field"

	^ options at: #bcc
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> bcc: anArrayOrString [

	"Comma separated list or an array of recipients email addresses that will appear on the Bcc: field.

	See also: class CpNodeJSNodemailerAddress"

	options at: #bcc put: anArrayOrString
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> cc [

	"Comma separated list or an array of recipients email addresses that will appear on the Cc: field"

	^ options at: #cc
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> cc: anArrayOrString [

	"Comma separated list or an array of recipients email addresses that will appear on the Cc: field.

	See also: class CpNodeJSNodemailerAddress"

	options at: #cc put: anArrayOrString
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> date [

	"optional Date value, current UTC string will be used if not set"

	^ options at: #date
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> date: aJSDateOrString [

	"optional Date value, current UTC string will be used if not set"

	options at: #date put: aJSDateOrString
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerMessage >> disableFileAccess [

	"if true, then does not allow to use files as content. Use it when you want to use JSON data from untrusted source as the email. If an attachment or message node tries to fetch something from a file the sending returns an error. If this field is also set in the transport options, then the value in mail data is ignored"

	^ options at: #disableFileAccess
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerMessage >> disableFileAccess: aBoolean [

	"if true, then does not allow to use files as content. Use it when you want to use JSON data from untrusted source as the email. If an attachment or message node tries to fetch something from a file the sending returns an error. If this field is also set in the transport options, then the value in mail data is ignored"

	options at: #disableFileAccess put: aBoolean
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerMessage >> disableUrlAccess [

	"if true, then does not allow to use Urls as content. If this field is also set in the transport options, then the value in mail data is ignored"

	^ options at: #disableUrlAccess
]

{ #category : #'accessing - security' }
CpNodeJSNodemailerMessage >> disableUrlAccess: aBoolean [

	"if true, then does not allow to use Urls as content. If this field is also set in the transport options, then the value in mail data is ignored"

	options at: #disableUrlAccess put: aBoolean
]

{ #category : #'accessing - signing' }
CpNodeJSNodemailerMessage >> dkim [

	"Answer the DKIM definition of the receiver"

	^ options at: #dkim
]

{ #category : #'accessing - signing' }
CpNodeJSNodemailerMessage >> dkim: aDKIM [

	"Set the DKIM definition for the receiver.

	See also: class CpNodeJSNodemailerDKIM"

	options at: #dkim put: aDKIM
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> encoding [

	"identifies encoding for text/html strings (defaults to ‘utf-8’, other values are ‘hex’ and ‘base64’)"

	^ options at: #encoding
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> encoding: aString [

	"identifies encoding for text/html strings (defaults to ‘utf-8’, other values are ‘hex’ and ‘base64’)"

	options at: #encoding put: aString
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> envelope [

	"optional SMTP envelope, if auto generated envelope is not suitable (see SMTP envelope for details)"

	^ options at: #envelope
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> envelope: anEnvelope [

	"optional SMTP envelope, if auto generated envelope is not suitable (see SMTP envelope for details)"

	options at: #envelope put: anEnvelope
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> from [

	"The email address of the sender. All email addresses can be plain ‘sender@server.com’ or formatted '“Sender Name” sender@server.com', see Address object for details"

	^ options at: #from
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> from: anAddressOrString [

	"The email address of the sender. All email addresses can be plain ‘sender@server.com’ or formatted '“Sender Name” sender@server.com', see Address object for details.

	See also: class CpNodeJSNodemailerAddress"

	options at: #from put: anAddressOrString
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> headers [

	"An object or array of additional header fields (e.g. {“X-Key-Name”: “key value”} or [{key: “X-Key-Name”, value: “val1”}, {key: “X-Key-Name”, value: “val2”}])"

	^ options at: #headers
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> headers: anObject [

	"An object or array of additional header fields (e.g. {“X-Key-Name”: “key value”} or [{key: “X-Key-Name”, value: “val1”}, {key: “X-Key-Name”, value: “val2”}]).

	See also: https://nodemailer.com/message/custom-headers/"

	options at: #headers put: anObject
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> html [

	"The HTML version of the message as an Unicode string, Buffer, Stream or an attachment-like object ({path: ‘http://…'})"

	^ options at: #html
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> html: anObject [

	"The HTML version of the message as an Unicode string, Buffer, Stream or an attachment-like object ({path: ‘http://…'})"

	options at: #html put: anObject
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> icalEvent [

	"iCalendar event to use as an alternative"

	^ options at: #icalEvent
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> icalEvent: anObject [

	"iCalendar event to use as an alternative.

	See also: https://nodemailer.com/message/calendar-events/"

	options at: #icalEvent put: anObject
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> inReplyTo [

	"The Message-ID this message is replying to"

	^ options at: #inReplyTo
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> inReplyTo: aString [

	"The Message-ID this message is replying to"

	options at: #inReplyTo put: aString
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> list [

	"helper for setting List-* headers"

	^ options at: #list
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> list: aDictionary [

	"helper for setting List-* headers.

	See also: https://nodemailer.com/message/list-headers/"

	options at: #list put: aDictionary
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> messageId [

	"optional Message-Id value, random value will be generated if not set"

	^ options at: #messageId
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> messageId: aString [

	"optional Message-Id value, random value will be generated if not set"

	options at: #messageId put: aString
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> priority [

	"Sets message importance headers, either ‘high’, ‘normal’ (default) or ‘low’"

	^ options at: #priority
]

{ #category : #'accessing - header' }
CpNodeJSNodemailerMessage >> priority: aString [

	"Sets message importance headers, either ‘high’, ‘normal’ (default) or ‘low’"

	options at: #priority put: aString
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> raw [

	"existing MIME message to use instead of generating a new one"

	^ options at: #raw
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> raw: anObject [

	"existing MIME message to use instead of generating a new one.

	See also: https://nodemailer.com/message/custom-source/"

	options at: #raw put: anObject
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> references [

	"Message-ID list (an array or space separated string)"

	^ options at: #references
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> references: anArrayOrString [

	"Message-ID list (an array or space separated string)"

	options at: #references put: anArrayOrString
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> replyTo [

	"An email address that will appear on the Reply-To: field"

	^ options at: #replyTo
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> replyTo: anAddressOrString [

	"An email address that will appear on the Reply-To: field"

	options at: #replyTo put: anAddressOrString
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> sender [

	"An email address that will appear on the Sender: field (always prefer from if you’re not sure which one to use)"

	^ options at: #sender
]

{ #category : #'accessing - routing' }
CpNodeJSNodemailerMessage >> sender: anAddressOrString [

	"An email address that will appear on the Sender: field (always prefer from if you’re not sure which one to use)"

	options at: #sender put: anAddressOrString
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> subject [

	"The subject of the email"

	^ options at: #subject
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> subject: aString [

	"The subject of the email"

	options at: #subject put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> text [

	"The plaintext version of the message as an Unicode string, Buffer, Stream or an attachment-like object ({path: ‘/var/data/…'})"

	^ options at: #text
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> text: anObject [

	"The plaintext version of the message as an Unicode string, Buffer, Stream or an attachment-like object ({path: ‘/var/data/…'})"

	options at: #text put: anObject
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> textEncoding [

	"force content-transfer-encoding for text values (either quoted-printable or base64). By default the best option is detected (for lots of ascii use quoted-printable, otherwise base64)"

	^ options at: #textEncoding
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> textEncoding: aString [

	"force content-transfer-encoding for text values (either 'quoted-printable' or 'base64'). By default the best option is detected (for lots of ascii use quoted-printable, otherwise base64)"

	options at: #textEncoding put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> to [

	"Comma separated list or an array of recipients email addresses that will appear on the To: field"

	^ options at: #to
]

{ #category : #accessing }
CpNodeJSNodemailerMessage >> to: anArrayOrString [

	"Comma separated list or an array of recipients email addresses that will appear on the To: field.

	See also: class CpNodeJSNodemailerAddress"

	options at: #to put: anArrayOrString
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> watchHtml [

	"Apple Watch specific HTML version of the message. Latest watches have no problems rendering text/html content so watchHtml is most probably never seen by the recipient"

	^ options at: #watchHtml
]

{ #category : #'accessing - content' }
CpNodeJSNodemailerMessage >> watchHtml: anObject [

	"Apple Watch specific HTML version of the message. Latest watches have no problems rendering text/html content so watchHtml is most probably never seen by the recipient.

	Seel also: #html:"

	options at: #watchHtml put: anObject
]
