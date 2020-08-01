Extension { #name : #CpHtmlElement }

{ #category : #'*CodeParadise-WebApplication-Fomantic' }
CpHtmlElement >> becomeElement: aSymbol [

	self becomeElement: aSymbol with: nil
]

{ #category : #'*CodeParadise-WebApplication-Fomantic' }
CpHtmlElement >> becomeElement: aSymbol with: aDictionary [

	<primitive: 'primitiveHTMLElementBecomeElement:with:' module: 'CpFomanticPlugin'>
	self primitiveFailed

]
