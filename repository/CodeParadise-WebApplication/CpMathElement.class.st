"
I am a XML Element and I represent a MathML Element.

My instances can be created as a result of querying a document or by explicit instantiation using #newWithTag:.

Not all browsers do support me at the moment (May 2020). 

Example:
	[[[
		CpHtmlElement documentBody markupContent: '
			<div class=""container"">
				<math xmlns=""http://www.w3.org/1998/Math/MathML"">
					<mi>&#x03C0;<!-- π --></mi>
					<mo>&#x2062;<!-- &InvisibleTimes; --></mo>
					<msup>
						<mi>r</mi>
						<mn>2</mn>
					</msup>
				</math>
			</div>
		'.
		(CpHtmlElement documentBody firstDescendantMatching: #mi) class name = #CpMathElement
	]]]
"
Class {
	#name : #CpMathElement,
	#superclass : #CpXmlElement,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'class initialization' }
CpMathElement class >> namespace [

	^ 'http://www.w3.org/1998/Math/MathML'
]

{ #category : #accessing }
CpMathElement class >> prefix [

	^ #math
]
