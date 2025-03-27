"
I represent both the Browser Blob and the Node.js Blob.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserBlob,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'class initialization' }
CpBrowserBlob class >> beLoaded [

	"Make sure ArrayBuffer support is loaded"

	CpJavaScriptArrayBuffer beLoaded
]

{ #category : #'instance creation' }
CpBrowserBlob class >> newWith: anObject type: aString [

	"Answer a new instance of the receiver with the specified Object
	(either a ByteArray or String) and specified type.

	Currently no other Object types are supported (deviating from the
	JavaScript Blob spec). Also the concatenation done by the Blob
	should be done in Smalltalk code, before calling this method."

	^ self newInstanceWithArguments: {
		{  anObject }.
		{ #type -> aString } asDictionary }
]

{ #category : #accessing }
CpBrowserBlob >> arrayBuffer [

	"Returns a promise that resolves with an ArrayBuffer containing the entire contents of the Blob as binary data."

	^ self apply: #arrayBuffer resultAs: CpJavaScriptPromise
]

{ #category : #converting }
CpBrowserBlob >> asBrowserClipboardItem [

	<ignoreReference: #CpBrowserClipboardItem>

	^ CpBrowserClipboardItem newWithBlob: self
]

{ #category : #accessing }
CpBrowserBlob >> size [

	"The size, in bytes, of the data contained in the Blob object."

	^ self propertyAt: #size
]

{ #category : #accessing }
CpBrowserBlob >> stream [

	"Returns a ReadableStream that can be used to read the contents of the Blob.

	Return: ReadableStream"

	^ self apply: #stream resultAs: CpBrowserReadableStream
]

{ #category : #accessing }
CpBrowserBlob >> text [

	"Returns a promise that resolves with a string containing the entire contents of the Blob interpreted as UTF-8 text."

	^ self apply: #text resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserBlob >> type [

	"A string indicating the MIME type of the data contained in the Blob. If the type is unknown, this string is empty."

	^ self propertyAt: #type
]

{ #category : #convenience }
CpBrowserBlob >> withContentDo: aBlock [

	"Evaluate the specified Block with the content (as ByteArray) of the receiver"

	self arrayBuffer then: [ :buffer |
		aBlock value: buffer asByteArray ]
]

{ #category : #convenience }
CpBrowserBlob >> withTextDo: aBlock [

	"Evaluate the specified Block with the text of the receiver"

	self text then: [ :text |
		aBlock value: text ]
]
