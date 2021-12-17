Class {
	#name : #SlElement,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlElement class >> componentLoaderName [

	^ self name asKebabCase, '-loader'
]

{ #category : #accessing }
SlElement class >> componentName [

	^ self nameWithoutPrefix asKebabCase
]

{ #category : #testing }
SlElement class >> hasAbstractTag [

	^ self classSide includesSelector: #isAbstractTag
]

{ #category : #accessing }
SlElement class >> importBasePath [

	^ 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0-beta.62/dist/'
]

{ #category : #accessing }
SlElement class >> importComponentCode [

	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'import "' ;
			nextPutAll: self importComponentPath ;
			nextPutAll: '";' ;
			nextPutAll: 'let script = document.getElementById("' ;
			nextPutAll: self componentLoaderName ;
			nextPutAll: '");' ;
			nextPutAll: 'if(script) script.remove();' ]
]

{ #category : #accessing }
SlElement class >> importComponentPath [

	"Answer the component path for the receiver"

	| componentName |

	componentName := self componentName.

	^ String streamContents: [ :stream|
		stream
			nextPutAll: self importBasePath ;
			nextPutAll: 'components/' ;
			nextPutAll: componentName ;
			nextPut: $/ ;
			nextPutAll: componentName ;
			nextPutAll: '.js' ]
]

{ #category : #accessing }
SlElement class >> importThemesPath [

	"Answer the themes path for the framework (is not component specific)"

	^ self importBasePath, 'themes/light.css'
]

{ #category : #testing }
SlElement class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'class initialization' }
SlElement class >> loadComponent [

	"Load component from CDN"

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #script)
				attributeAt: #id put: self componentLoaderName ;
				attributeAt: #type put: 'module' ;
				textContent: self importComponentCode ;
				yourself)
]

{ #category : #'class initialization' }
SlElement class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #meta)
				attributeAt: #name put: 'viewport' ;
				attributeAt: #content put: 'width=device-width, initial-scale=1.0' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #link)
				attributeAt: #rel put: 'stylesheet' ;
				attributeAt: #type put: 'text/css' ;
				attributeAt: #href put: self importThemesPath ;
				yourself)
]

{ #category : #'instance creation' }
SlElement class >> new [

	"Answer a new instance of the receiver.
	Although not allowed on the receiver or its superclasses,
	new instances of the receiver's subclasses are allowed to be created,
	because the receiver knows its own tag."

	self hasAbstractTag
		ifTrue: [ self error: self name, ' is abstract and cannot be instantiated' ].

	^ self newWithTag: self tagName
]

{ #category : #'class initialization' }
SlElement class >> postInstall [

	"Install Shoelace component into receiver"

	super postInstall.

	self hasAbstractTag
		ifTrue: [ ^ self ].

	self loadComponent
]

{ #category : #'class initialization' }
SlElement class >> postInstallOnce [

	"Install Shoelace library into receiver"

	self loadLibrary
]

{ #category : #'text input' }
SlElement >> focus: optionsArray [

	"Sets focus on the receiver with options.

	Only options available (at the moment):
		{ #preventScroll -> true }."

	self apply: #focus withArguments: optionsArray asDictionary
]
