Class {
	#name : #CpDemoClassDefinitionCodeContentView,
	#superclass : #CpDemoExecutableCodeContentView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoClassDefinitionCodeContentView class >> style [

	<webResource: #css>

	^ super style, '
	:host(.has-other) ::slotted([slot="banner"]) {
		background-color: rgba(255, 0, 0, .5);
		cursor: pointer;
	}'
]

{ #category : #rendering }
CpDemoClassDefinitionCodeContentView >> renderBanner: aString showOther: aBoolean [

	(self firstChildAtSlotNamed: #banner) ifNotNil: [ :banner | banner unsubscribe: self ].

	self renderBanner: aString.
	self classed: #'has-other' if: aBoolean.

	aBoolean ifFalse: [ ^ self ].

	(self firstChildAtSlotNamed: #banner) ifNotNil: [ :banner |
		banner when: CpClickEvent primary only send: #toggleOther: to: self ]
]

{ #category : #'as yet unclassified' }
CpDemoClassDefinitionCodeContentView >> toggleOther: aClickEvent [

	aClickEvent stopPropagation.

	self toggleOther
]
