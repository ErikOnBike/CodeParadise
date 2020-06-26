"
I am a XML Element and I represent a SVG Element.

My instances can be created as a result of querying a document or by explicit instantiation using #newWithTag:.

Example:
	[[[
		CpHtmlElement documentBody markupContent: '
			<div class=""container"">
				<svg xmlns=""http://www.w3.org/2000/svg"" viewBox=""0 0 100 100"">
					<rect x=""10"" y=""10"" width=""80"" height=""80"" fill=""#00ff00""></rect>
					<circle cx=""70"" cy=""70"" r=""25"" fill=""#ff0000""></circle>
				</svg>
			</div>
		'.
		(CpHtmlElement documentBody firstDescendantMatching: #rect) class name = #CpSvgElement
	]]]
"
Class {
	#name : #CpSvgElement,
	#superclass : #CpXmlElement,
	#category : #'WebApplication-DOM'
}

{ #category : #'class initialization' }
CpSvgElement class >> namespace [

	^ 'http://www.w3.org/2000/svg'
]

{ #category : #accessing }
CpSvgElement class >> prefix [

	^ #svg
]
