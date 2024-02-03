"
I represent the asynchronous Clipboard API
"
Class {
	#name : #CpBrowserClipboard,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Clipboard'
}

{ #category : #accessing }
CpBrowserClipboard class >> current [

	"Answer an instance of the receiver"

	^ CpBrowserNavigator current
		apply: #clipboard resultAs: self
]

{ #category : #'instance creation' }
CpBrowserClipboard class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'A Clipboard instance should be retrieved using the selector ', #current
]

{ #category : #accessing }
CpBrowserClipboard >> read [

	"Requests arbitrary data (such as images) from the clipboard, returning a Promise
	that resolves with an array of ClipboardItem objects containing the clipboard's contents."

	^ CpJavaScriptPromise on: [ :resolveBlock :rejectBlock |
		self
			readThenDo: [ :anArray | resolveBlock value: anArray ]
			onError: [ :reason | rejectBlock value: reason ] ]
]

{ #category : #accessing }
CpBrowserClipboard >> readText [

	"Requests text from the system clipboard; returns a Promise which is resolved with a string containing the clipboard's text once it's available."

	^ self apply: #readText withArguments: nil resultAs: CpJavaScriptPromise
]

{ #category : #convenience }
CpBrowserClipboard >> readTextThenDo: successBlock [

	^ self readTextThenDo: successBlock onError: []
]

{ #category : #convenience }
CpBrowserClipboard >> readTextThenDo: successBlock onError: errorBlock [

	"Read a text from the Clipboard and evaluate the specified Block with the text content.
	If the user does not have permission, the errorBlock is evaluated with the JavaScript
	exception as (optional) argument."

	^ self readText
		then: [ :text | successBlock value: text ]
		onRejected: [ :reason | errorBlock cull: reason ]
]

{ #category : #convenience }
CpBrowserClipboard >> readThenDo: successBlock [

	^ self readThenDo: successBlock onError: []
]

{ #category : #convenience }
CpBrowserClipboard >> readThenDo: successBlock onError: errorBlock [

	"Read content from the Clipboard and evaluate the specified Block with that content.
	The content is an Array of ClipboardItems.
	If the user does not have permission, the errorBlock is evaluated with the JavaScript
	exception as (optional) argument."

	^ (self apply: #read withArguments: nil resultAs: CpJavaScriptPromise)
		then: [ :anArray | successBlock value: (anArray collect: [ :each | each as: CpBrowserClipboardItem ]) ]
		onRejected: [ :reason | errorBlock value: reason ]
]

{ #category : #writing }
CpBrowserClipboard >> write: anArray [

	"Writes arbitrary data to the system clipboard. This asynchronous operation signals that it's finished by resolving the returned Promise.
	The Array should contain ClipboardItems."

	^ self apply: #write withArguments: { anArray } resultAs: CpJavaScriptPromise
]

{ #category : #writing }
CpBrowserClipboard >> write: anArray thenDo: successBlock [

	^ self write: anArray thenDo: successBlock onError: []
]

{ #category : #writing }
CpBrowserClipboard >> write: anArray thenDo: successBlock onError: errorBlock [

	"Write content to the Clipboard and evaluate the specified Block after the content has
	been written. There is no argument passed to the success Block.
	The content is an Array of ClipboardItems.
	If the user does not have permission, the errorBlock is evaluated with the JavaScript
	exception as (optional) argument."

	^ (self write: anArray)
		then: [ successBlock value ]
		onRejected: [ :reason | errorBlock cull: reason ]
]

{ #category : #writing }
CpBrowserClipboard >> writeText: aString [

	"Writes text to the system clipboard, returning a Promise which is resolved once the text is fully copied into the clipboard."

	^ self apply: #writeText withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #writing }
CpBrowserClipboard >> writeText: aString thenDo: successBlock [

	^ self writeText: aString thenDo: successBlock onError: []
]

{ #category : #writing }
CpBrowserClipboard >> writeText: aString thenDo: successBlock onError: errorBlock [

	"Write text to the Clipboard and evaluate the specified Block after the content has
	been written. There is no argument passed to the success Block.
	If the user does not have permission, the errorBlock is evaluated with the JavaScript
	exception as (optional) argument."

	^ (self writeText: aString)
		then: [ successBlock value ]
		onRejected: [ :reason | errorBlock cull: reason ]
]
