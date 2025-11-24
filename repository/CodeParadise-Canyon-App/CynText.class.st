Class {
	#name : #CynText,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'instance creation' }
CynText class >> labelText: aSymbol [

	"Answer a new instance with the specified text key and mark it as a label (will influence color,
	since Ionic is peculiair in handling label color)."

	^ self new
		attributeAt: #text put: aSymbol ;
		addClass: #label ;
		render
]

{ #category : #'web resources' }
CynText class >> style [

	<webResource: #css>

	^ ':host {
	display: inline;
}
:host(.label) {
	color: var(--canyon-label-color);
}'
]

{ #category : #'instance creation' }
CynText class >> text: aSymbol [

	^ self new
		attributeAt: #text put: aSymbol ;
		render
]

{ #category : #initialization }
CynText >> initialize [

	super initialize.

	self render
]

{ #category : #initialization }
CynText >> render [

	| index count |

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

{ #category : #'view - customization' }
CynText >> updateMultiLanguageText [

	self render
]
