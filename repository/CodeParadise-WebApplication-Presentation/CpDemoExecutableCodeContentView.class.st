Class {
	#name : #CpDemoExecutableCodeContentView,
	#superclass : #CpDemoCodeContentView,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'event handling' }
CpDemoExecutableCodeContentView >> executeCode [

	self serverAnnounce: CpDemoCodeDoIt
]

{ #category : #initialization }
CpDemoExecutableCodeContentView >> initialize [

	super initialize.

	self
		appendChild: ('Execute code (DoIt)' asHtmlElement
			when: CpPrimaryClickEvent only send: #executeCode to: self ;
			yourself)
		atSlotNamed: #actions
]
