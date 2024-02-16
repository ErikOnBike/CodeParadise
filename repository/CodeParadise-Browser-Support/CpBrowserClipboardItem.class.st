Class {
	#name : #CpBrowserClipboardItem,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Clipboard'
}

{ #category : #'instance creation' }
CpBrowserClipboardItem class >> newWith: anObject [

	^ anObject asBrowserClipboardItem
]

{ #category : #'instance creation' }
CpBrowserClipboardItem class >> newWithBlob: aBlob [

	^ self newInstanceWithArguments: {
		{ aBlob type -> aBlob } asDictionary }
]

{ #category : #'instance creation' }
CpBrowserClipboardItem class >> newWithString: aString [

	^ self newWithString: aString type: 'text/plain'
]

{ #category : #'instance creation' }
CpBrowserClipboardItem class >> newWithString: contentString type: typeString [

	^ self newInstanceWithArguments: {
		{ typeString -> contentString } asDictionary }
]

{ #category : #convenience }
CpBrowserClipboardItem >> getHtmlTextThenDo: successBlock [

	"Retrieve the HTML text from the clipboard content and evaluate the
	successBlock with the content (a String)"

	self getHtmlTextThenDo: successBlock onError: [ "ignore errors" ]
]

{ #category : #convenience }
CpBrowserClipboardItem >> getHtmlTextThenDo: successBlock onError: errorBlock [

	"Retrieve the HTML text from the clipboard content and evaluate the
	successBlock with the content (a String) or evaluate errorBlock with
	the (optional) JavaScript exception if HTML content is not available
	or an error occurred."

	(self getType: 'text/html')
		then: [ :blob |
			blob withTextDo: [ :content |
				successBlock value: content ] ]
		onRejected: [ :reason |
			errorBlock cull: reason ]
]

{ #category : #convenience }
CpBrowserClipboardItem >> getPlainTextThenDo: successBlock [

	"Retrieve the plain text from the clipboard content and evaluate the
	successBlock with the content (a String)"

	self getHtmlTextThenDo: successBlock onError: [ "ignore errors" ]
]

{ #category : #convenience }
CpBrowserClipboardItem >> getPlainTextThenDo: successBlock onError: errorBlock [

	"Retrieve the plain text from the clipboard content and evaluate the
	successBlock with the content (a String) or evaluate errorBlock with
	the (optional) JavaScript exception if plain content is not available
	or an error occurred."

	(self getType: 'text/plain')
		then: [ :blob |
			blob withTextDo: [ :content |
				successBlock value: content ] ]
		onRejected: [ :reason |
			errorBlock cull: reason ]
]

{ #category : #accessing }
CpBrowserClipboardItem >> getType: aString [

	"Returns a Promise that resolves with a Blob of the requested MIME type, or an error if the MIME type is not found."

	^ self apply: #getType withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #convenience }
CpBrowserClipboardItem >> getType: aString thenDo: successBlock [

	self getType: aString thenDo: successBlock onError: [ "ignore errors" ]
]

{ #category : #convenience }
CpBrowserClipboardItem >> getType: aString thenDo: successBlock onError: errorBlock [

	"Retrieve the clipboard content for the specified MIME type and evaluate the
	successBlock with the content (ByteArray) or evaluate errorBlock with the
	(optional) JavaScript exception."

	(self getType: aString)
		then: [ :blob |
			blob withContentDo: [ :content |
				successBlock value: content ] ]
		onRejected: [ :reason | errorBlock cull: reason ]
]

{ #category : #accessing }
CpBrowserClipboardItem >> presentationStyle [

	"Returns one of the following: 'unspecified', 'inline' or 'attachment'".

	^ self propertyAt: #presentationStyle
]

{ #category : #accessing }
CpBrowserClipboardItem >> types [

	"Returns an Array of MIME types available within the ClipboardItem."

	^ self propertyAt: #types
]
