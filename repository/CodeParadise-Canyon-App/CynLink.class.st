Class {
	#name : #CynLink,
	#superclass : #CpTemplateComponent,
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'web resources' }
CynLink class >> style [

	<webResource: #css>

	^ ':host {
	display: inline;
	font-weight: var(--canyon-link-font-weight, inherit);
	font-style: var(--canyon-link-font-style, inherit);
	text-decoration: var(--canyon-link-text-decoration, inherit);
	color: var(--canyon-link-color, inherit);
	cursor: pointer;
}'
]

{ #category : #initialization }
CynLink >> initialize [

	super initialize.

	self when: CpClickEvent deferSend: #linkClicked to: self
]

{ #category : #'event handling' }
CynLink >> linkClicked [

	(self attributeAt: #href) ifNotNil: [ :href |
		(href beginsWith: '#')
			ifTrue: [ CynApp current navigateLink: href allButFirst asSymbol ]
			ifFalse: [
				(CynPage pageClassNamed: href)
					ifNotNil: [ :pageClass | CynApp current navigateTo: pageClass ] ] ]
]
