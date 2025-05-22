"
I am a resource loader. I am responsible for loading a specific resource only once,
yet allow it to be used more frequently. I am especially useful when loading SVG
files (currently the only content type I support). Because I make the resource
content my child(ren) I can be styled more easily (not possible when using <img>).

To allow specific styling I add the following classes during/after resource loading:
	#loading - while loading a resource
	#loaded - after loading a resource
	#failed - when loading fails (#loading remains active as well)

Idea is taken from:
https://dev.to/dannyengelman/load-file-web-component-add-external-content-to-the-dom-1nd

"
Class {
	#name : #CpLoadResource,
	#superclass : #CpTemplateComponent,
	#classVars : [
		'Resources'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'class initialization' }
CpLoadResource class >> postInstallOnce [

	Resources ifNil: [ Resources := Dictionary new ]
]

{ #category : #private }
CpLoadResource >> addContentAt: aString fromResponse: aResponse [

	"Add the content from the specified Response to the receiver and
	answer the content Association (key = content type, value = content).
	If the content is not supported, answer nil."

	^ (aResponse headers get: 'Content-Type')
		ifNotNil: [ :contentType |
			(self isSupportedContentType: contentType)
				ifTrue: [
					Resources
						at: aString
						put: contentType -> (self content: contentType fromResponse: aResponse) ] ]
]

{ #category : #private }
CpLoadResource >> content: aString fromResponse: aResponse [

	"Answer the content (with the specified content type) from the specified Response.

	Implementation:
	Currently only text is supported. Don't need to check for the content type."

	^ aResponse text await
]

{ #category : #initialization }
CpLoadResource >> initialize [

	super initialize.

	(self attributeAt: #src)
		ifNotNil: [ :src | self src: src ]
]

{ #category : #testing }
CpLoadResource >> isSupportedContentType: aString [

	^ #('image/svg+xml') includes: aString
]

{ #category : #private }
CpLoadResource >> loadContent: aString [

	"Load content from the specified URL"

	| fetch |

	self
		removeClass: #loaded ;
		addClass: #loading.

	fetch := CpGlobalThis
		fetch: aString
		withOptions: {
			#method -> #get.
			#mode -> #cors.
			#signal -> (CpBrowserAbortSignal timeout: self timeout) } asDictionary.

	fetch
		then: [ :response |
			self setContent: (self addContentAt: aString fromResponse: response) ]
		onRejected: [ :reason |
			self addClass: #failed.
			self errorCr: ('Failed to retrieve resource {1}, reason: {2}' format: { aString . reason }) ]
]

{ #category : #private }
CpLoadResource >> setContent: anAssociation [

	"Set the specified content (key = content type, value = content).

	Implementation:
	Since currently there is only support for SVG, simply add the markup."

	self
		removeClass: #loading ;
		addClass: #loaded.

	self markupContent: anAssociation value
]

{ #category : #accessing }
CpLoadResource >> src: aString [

	"Load the specified resource in the receiver (or replace it)"

	| content |

	content := Resources at: aString ifAbsent: [ nil ].

	content
		ifNotNil: [ self setContent: content ]
		ifNil: [ self loadContent: aString ]
]

{ #category : #accessing }
CpLoadResource >> timeout [

	"Answer the number of milliseconds to try and receive the resource before timing out"

	^ 4000
]
