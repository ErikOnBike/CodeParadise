Class {
	#name : #WaMarkdown,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #actions }
WaMarkdown >> getMarked [

	"Returns the shared Marked instance used by all `<wa-markdown>` components.
	
	Return type: Marked"

	^ self apply: #getMarked
]

{ #category : #accessing }
WaMarkdown >> marked [

	"A reference to the shared Marked instance for convenience. Equivalent to `WaMarkdown.getMarked()`.
	
	Type: Object (Marked)
	Read-only: true"

	^ self propertyAt: #marked
]

{ #category : #actions }
WaMarkdown >> renderMarkdown [

	"Reads the script content, normalizes whitespace, parses markdown, and injects the result."

	^ self apply: #renderMarkdown
]

{ #category : #accessing }
WaMarkdown >> tabSize [

	"The tab stop width used when converting leading tabs to spaces during whitespace normalization.
	
	Type: Number
	Default: 4"

	^ self propertyAt: #tabSize
]

{ #category : #accessing }
WaMarkdown >> tabSize: aNumber [

	"The tab stop width used when converting leading tabs to spaces during whitespace normalization.
	
	Type: Number
	Default: 4"

	self propertyAt: #tabSize put: aNumber
]

{ #category : #actions }
WaMarkdown >> updateAll [

	"Re-renders all connected `<wa-markdown>` instances. Call this after changing the Marked configuration."

	^ self apply: #updateAll
]
