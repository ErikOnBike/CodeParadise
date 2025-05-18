Class {
	#name : #CynAttribute,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'instance creation' }
CynAttribute class >> new [

	self error: 'Do not instantiate me in code, only use me inside HTML content'
]

{ #category : #initialization }
CynAttribute >> initialize [

	| attr text |

	super initialize.

	attr := self attributeAt: #attr.
	text := self attributeAt: #text.

	(attr isNil or: [ text isNil ])
		ifTrue: [
			self errorCr: ('Used {1} without attributes "attr" and "text" defined (both are required)' format: { self tagName }).
			^ self ].

	self parent
		attributeAt: attr put: (CynPropertyEntity text: text asSymbol)
]
