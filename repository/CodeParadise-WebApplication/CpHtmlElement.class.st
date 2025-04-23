"
I am a CpDomElement and I represent a HTML element inside a web browser document (ie a page or tab).

See my superclass' comment for more explanation and some generic examples.

HTML examples:
Create a 'div' tag and add it to the body of the browser document:
	[[[ CpHtmlElement documentBody appendChild: (CpHtmlElement newWithTag: #div) ]]]

Select (using CSS selectors) all unordered lists within the browser document and add a single list item:
	[[[
		(CpHtmlElement documentBody allDescendantsMatching: #ul) do: [ :each |
			each appendChild: ((CpHtmlElement newWithTag: #li)
				textContent: 'New item' ;
				yourself)
	]]]

Remove all paragraph elements which have a class value 'old' from the browser document:
	[[[ (CpHtmlElement documentBody allDescendantsMatching: #'p.old') do: [ :each | each remove ] ]]]

Make the text in input fields uppercase for all input fields in the document:
	[[[
		(CpHtmlElement documentBody allDescendantsMatching: #'input[type=""text""]') do: [ :each |
			each propertyAt: #value put: (each propertyAt: #value) asUppercase ]
	]]] 

Append a HTML fragment (markup content) to the document body (replacing all existing content):
	[[[
		CpHtmlElement documentBody markupContent: '
			<ol>
				<li>Smalltalk</li>
				<li>Javascript</li>
				<li>Modula-2</li>
				<li>C++</li>
				<li>8088 Assembly</li>
				<li>Basic</li>
			</ol>'
	]]]

Load a stylesheet:
	[[[
			CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #link)
				attributeAt: #href put: '/css/stylesheet.css' ;
				attributeAt: #rel put: 'stylesheet' ;
				yourself)
	]]]
"
Class {
	#name : #CpHtmlElement,
	#superclass : #CpDomElement,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'acccessing-ui' }
CpHtmlElement class >> activeElement [

	^ self document propertyAt: #activeElement
]

{ #category : #adding }
CpHtmlElement class >> documentAddExternalScript: urlString [

	"Add the specified JavaScript resource to the receiver"

	^ self documentAddExternalScript: urlString type: nil id: nil
]

{ #category : #adding }
CpHtmlElement class >> documentAddExternalScript: urlString type: typeString [

	"Add the specified JavaScript resource to the receiver"

	^ self documentAddExternalScript: urlString type: typeString id: nil
]

{ #category : #adding }
CpHtmlElement class >> documentAddExternalScript: urlString type: typeString id: idString [

	"Add the specified JavaScript resource to the receiver"

	^ self documentHead appendChild: ((self newWithTag: #script)
		id: idString ;
		attributeAt: #type put: typeString ;
		attributeAt: #src put: urlString ;
		yourself)
]

{ #category : #adding }
CpHtmlElement class >> documentAddModuleScript: aString [

	^ self documentAddScript: aString type: 'module' id: nil
]

{ #category : #adding }
CpHtmlElement class >> documentAddScript: aString [

	^ self documentAddScript: aString type: nil id: nil
]

{ #category : #adding }
CpHtmlElement class >> documentAddScript: contentString type: typeString id: idString [

	"Add the specified JavaScript content to the receiver"

	^ self documentHead appendChild: ((self newWithTag: #script)
		id: idString ;
		attributeAt: #type put: typeString ;
		textContent: contentString ;
		yourself)
]

{ #category : #adding }
CpHtmlElement class >> documentAddStyle: aString [

	"Add the specified CSS content to the receiver"

	^ self documentHead appendChild: ((self newWithTag: #style)
		textContent: aString ;
		yourself)
]

{ #category : #adding }
CpHtmlElement class >> documentAddStylesheet: aString [

	"Add the specified (external) stylesheet to the receiver"

	^ self documentHead appendChild: ((self newWithTag: #link)
		attributeAt: #rel put: 'stylesheet' ;
		attributeAt: #type put: 'text/css' ;
		attributeAt: #href put: aString ;
		yourself)
]

{ #category : #'acccessing-ui' }
CpHtmlElement class >> documentBody [

	"Answer an instance of the receiver representing the <body> element of
	the current (browser tab) HTML document"

	<primitive: 'primitiveHtmlElementDocumentBody' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'acccessing-ui' }
CpHtmlElement class >> documentHead [

	"Answer an instance of the receiver representing the <head> element of
	the current (browser tab) HTML document"

	<primitive: 'primitiveHtmlElementDocumentHead' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'acccessing-ui' }
CpHtmlElement class >> documentHtml [

	"Answer an instance of the receiver representing the <html> element of
	the current (browser tab) HTML document"

	^ self documentBody parent
]

{ #category : #accessing }
CpHtmlElement class >> namespace [

	^ 'http://www.w3.org/1999/xhtml'
]

{ #category : #accessing }
CpHtmlElement class >> prefix [

	^ #xhtml
]

{ #category : #converting }
CpHtmlElement >> asHtmlElement [

	"Answer the receiver as DOM element"

	^ self
]

{ #category : #accessing }
CpHtmlElement >> isSlotted [

	"Answer whether the receiver lives in a slot within the receiver's parent.

	Implementation: Only validates whether a slot is named, not whether it actually exists."

	^ self hasAttributeAt: #slot
]

{ #category : #accessing }
CpHtmlElement >> slot [

	"Answer the slot within the receiver's parent in which the receiver lives
	(or nil if it lives outside a named slot)"

	^ self attributeAt: #slot
]

{ #category : #accessing }
CpHtmlElement >> slot: aString [

	"Assign receiver to the specified slot (within the receiver's parent)"

	self attributeAt: #slot put: aString
]
