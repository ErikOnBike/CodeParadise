Class {
	#name : #CynText,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #initialization }
CynText >> initialize [

	super initialize.

	"Set text if value provided as attribute"
	(self attributeAt: #text)
		ifNotNil: [ :text | self text: text ]
]

{ #category : #accessing }
CynText >> text: text [

	self replaceWith: ((CpHtmlElement newWithTag: #span)
		addClass: #'lang-text' ;
		attributeAt: #'lang-text' put: text ;
		textContent: (CynPropertyEntity text: text asSymbol) ;
		yourself)
]
