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

	super initialize.

	"Set text if value provided as attribute"
	(self attributeAt: #text)
		ifNotNil: [ :text | self textContent: (CynPropertyEntity text: text asSymbol) ]
]
