Class {
	#name : #CpPresentationClientBehavior,
	#superclass : #CpMvpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-Presentation-Application'
}

{ #category : #initialization }
CpPresentationClientBehavior >> initialize [

	super initialize.

	"Add a 'screen' to our browser (creating usable real estate)"
	CpHtmlElement documentBody
		appendChild: (CpScreen new
			attributeAt: #id put: 'screen' ;
			yourself)
]
