Class {
	#name : #CpDemoApplicationCodeContentView,
	#superclass : #CpDemoCodeContentView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #initialization }
CpDemoApplicationCodeContentView >> initialize [

	super initialize.

	self
		appendChild: ('(Re)open Inspector' asHtmlElement
			when: CpPrimaryClickEvent only send: #openInspector to: self ;
			yourself)
		atSlotNamed: #actions
]

{ #category : #'event handling' }
CpDemoApplicationCodeContentView >> openInspector [

	self serverAnnounce: CpDemoCodeOpenInspector
]
