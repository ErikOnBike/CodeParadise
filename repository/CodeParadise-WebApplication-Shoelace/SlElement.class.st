Class {
	#name : #SlElement,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #testing }
SlElement class >> hasAbstractTag [

	^ self classSide includesSelector: #isAbstractTag
]

{ #category : #testing }
SlElement class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #initialization }
SlElement class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #meta)
				attributeAt: #name put: 'viewport' ;
				attributeAt: #content put: 'width=device-width, initial-scale=1.0' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #script)
				attributeAt: #type put: 'module' ;
				attributeAt: #src put: 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0-beta.60/dist/shoelace.js' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #link)
				attributeAt: #rel put: 'stylesheet' ;
				attributeAt: #type put: 'text/css' ;
				attributeAt: #href put: 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0-beta.60/dist/themes/light.css' ;
				yourself)
]

{ #category : #'instance creation' }
SlElement class >> new [

	"Answer a new instance of the receiver.
	Although not allowed on the receiver or its superclasses,
	new instances of the receiver's subclasses are allowed to be created,
	because the receiver knows its own tag."

	self = SlElement
		ifTrue: [ ^ super new ].

	^ self newWithTag: self tagName
]

{ #category : #'class initialization' }
SlElement class >> postInstall [

	"Install Shoelace library into receiver"

	super postInstall.

	"Load library only once (ie not for subclasses)"
	self = SlElement
		ifTrue: [ self loadLibrary ; waitForLibrary ]
]

{ #category : #initialization }
SlElement class >> waitForLibrary [

	"Wait for library being loaded"

	| activeProcess resumed |

	activeProcess := Processor activeProcess.

	resumed := false.
	(CpTransition onBlock: [ :progress :time |

		"Resume Process if specific component is correctly registered or we timed out"
		(((self isRegistered: 'sl-button') or: [ progress >= 1.0 ]) and: [ resumed not ])
			ifTrue: [
				activeProcess resume.
				resumed := true ] ])
		duration: 2000 ;	"Wait at most 2 seconds"
		start.

	"Suspend receiver here (it will be resumed when library is loaded)"	
	activeProcess suspend.

	"After resume do final check"
	resumed ifFalse: [ self error: 'Failed to load Shoelace library' ]
]

{ #category : #'text input' }
SlElement >> focus: optionsArray [

	"Sets focus on the receiver with options.

	Only options available (at the moment):
		{ #preventScroll -> true }."

	self apply: #focus withArguments: optionsArray asDictionary
]
