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
CpHtmlElement class >> documentBody [

	"Answer an instance of the receiver representing the <body> element of
	the current (browser tab) HTML document"

	<primitive: 'primitiveHTMLElementDocumentBody' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #'acccessing-ui' }
CpHtmlElement class >> documentHead [

	"Answer an instance of the receiver representing the <head> element of
	the current (browser tab) HTML document"

	<primitive: 'primitiveHTMLElementDocumentHead' module: 'CpDOMPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpHtmlElement class >> namespace [

	^ 'http://www.w3.org/1999/xhtml'
]

{ #category : #accessing }
CpHtmlElement class >> prefix [

	^ #xhtml
]
