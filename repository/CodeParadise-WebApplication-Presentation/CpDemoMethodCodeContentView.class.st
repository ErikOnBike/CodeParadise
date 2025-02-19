Class {
	#name : #CpDemoMethodCodeContentView,
	#superclass : #CpDemoCodeContentView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'web resources' }
CpDemoMethodCodeContentView class >> style [

	<webResource: #css>

	^ super style, '
	:host(.has-other) ::slotted([slot="banner"]) {
		background-color: rgba(255, 0, 0, .5);
		cursor: pointer;
	}'
]

{ #category : #initialization }
CpDemoMethodCodeContentView >> initialize [

	super initialize.

	self
		appendChild: ('Install method' asHtmlElement
			when: CpPrimaryClickEvent only send: #installMethod to: self ;
			yourself)
		atSlotNamed: #actions
]

{ #category : #'event handling' }
CpDemoMethodCodeContentView >> installMethod [

	self serverAnnounce: CpDemoCodeInstall
]

{ #category : #rendering }
CpDemoMethodCodeContentView >> renderBanner: aString showOther: aBoolean [

	(self firstChildAtSlotNamed: #banner) ifNotNil: [ :banner | banner unsubscribe: self ].

	self renderBanner: aString.
	self classed: #'has-other' if: aBoolean.

	aBoolean ifFalse: [ ^ self ].

	(self firstChildAtSlotNamed: #banner) ifNotNil: [ :banner |
		banner when: CpClickEvent primary only send: #toggleOther: to: self ]
]

{ #category : #'as yet unclassified' }
CpDemoMethodCodeContentView >> toggleOther: aClickEvent [

	aClickEvent stopPropagation.

	self toggleOther
]
