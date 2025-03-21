"
I am a Nodemailer Attachment (definition).

See https://nodemailer.com/message/attachments/

"
Class {
	#name : #CpNodeJSNodemailerAttachment,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Nodemailer-Support'
}

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> cid [

	"optional content id for using inline images in HTML message source"

	^ options at: #cid
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> cid: aString [

	"optional content id for using inline images in HTML message source"

	options at: #cid put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> content [

	"String, Buffer or a Stream contents for the attachment"

	^ options at: #content
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> content: anObject [

	"String, Buffer or a Stream contents for the attachment"

	options at: #content put: anObject
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> contentDisposition [

	"optional content disposition type for the attachment, defaults to ‘attachment’"

	^ options at: #contentType
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> contentDisposition: aString [

	"optional content disposition type for the attachment, defaults to ‘attachment’"

	options at: #contentType put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> contentType [

	"optional content type for the attachment, if not set will be derived from the filename property"

	^ options at: #contentType
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> contentType: aString [

	"optional content type for the attachment, if not set will be derived from the filename property"

	options at: #contentType put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> encoding [

	"If set and content is string, then encodes the content to a Buffer using the specified encoding. Example values: ‘base64’, ‘hex’, ‘binary’ etc. Useful if you want to use binary attachments in a JSON formatted email object."

	^ options at: #encoding
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> encoding: aString [

	"If set and content is string, then encodes the content to a Buffer using the specified encoding. Example values: ‘base64’, ‘hex’, ‘binary’ etc. Useful if you want to use binary attachments in a JSON formatted email object."

	options at: #encoding put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> filename [

	"filename to be reported as the name of the attached file. Use of unicode is allowed."

	^ options at: #filename
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> filename: aString [

	"filename to be reported as the name of the attached file. Use of unicode is allowed."

	options at: #filename put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> headers [

	"custom headers for the attachment node. Same usage as with message headers"

	^ options at: #headers
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> headers: aDictionary [

	"custom headers for the attachment node. Same usage as with message headers"

	options at: #headers put: aDictionary
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> href [

	"an URL to the file (data uris are allowed as well)"

	^ options at: #href
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> href: aString [

	"an URL to the file (data uris are allowed as well)"

	options at: #href put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> httpHeaders [

	"optional HTTP headers to pass on with the href request, eg. {authorization: ""bearer ...""}"

	^ options at: #httpHeaders
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> httpHeaders: aDictionary [

	"optional HTTP headers to pass on with the href request, eg. {authorization: ""bearer ...""}"

	options at: #httpHeaders put: aDictionary
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> path [

	"path to the file if you want to stream the file instead of including it (better for larger attachments)"

	^ options at: #path
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> path: aString [

	"path to the file if you want to stream the file instead of including it (better for larger attachments)"

	options at: #path put: aString
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> raw [

	"is an optional special value that overrides entire contents of current mime node including mime headers. Useful if you want to prepare node contents yourself"

	^ options at: #raw
]

{ #category : #accessing }
CpNodeJSNodemailerAttachment >> raw: aString [

	"is an optional special value that overrides entire contents of current mime node including mime headers. Useful if you want to prepare node contents yourself"

	options at: #raw put: aString
]
