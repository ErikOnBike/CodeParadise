Class {
	#name : #CynText,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'web resources' }
CynText class >> style [

	<webResource: #css>

	^ ':host {
	display: inline;
}'
]

{ #category : #initialization }
CynText >> initialize [

	| index count |

	super initialize.

	index := (self attributeAt: #index)
		ifNotNil: [ :indexString | indexString asNumberOrNil ].
	count := (self attributeAt: #count)
		ifNotNil: [ :countString | countString asNumberOrNil ].

	"Set text if value provided as attribute"
	(self attributeAt: #text) ifNotNil: [ :text |
		self textContent: (index
			ifNotNil: [ CynPropertyEntity index: index text: text asSymbol ]
			ifNil: [
				count
					ifNotNil: [ CynPropertyEntity count: count text: text asSymbol ]
					ifNil: [ CynPropertyEntity text: text asSymbol ] ]) ]
]
