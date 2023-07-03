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

{ #category : #accessing }
SlElement class >> importBasePath [

	^ 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0/dist/'
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

	CpHtmlElement
		documentAddScript: self importComponentCode
		type: 'module'
		id: self componentLoaderName
]

{ #category : #'class initialization' }
SlElement class >> loadLibrary [

	"Load library from CDN.

	Implementation:
	Load stylesheet here. All components will load themselves.
	See SlElement class >> #loadComponent"

	CpHtmlElement documentAddStylesheet: self importThemesPath
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

{ #category : #performing }
SlElement >> performMessage: aMessage [

	"Perform the specified message on the receiver"

	aMessage sendTo: self
]
