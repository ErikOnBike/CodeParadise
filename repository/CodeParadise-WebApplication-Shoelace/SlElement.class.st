"
I am the base class for Shoelace components.
See https://shoelace.style

Shoelace components do not load automagically (i.e. the
auto-loader feature is not in use).
A so called 'auto-loader' function exists in Shoelace. This
does however not work for components used inside a Shadow DOM.
The auto-loader works by setting a MutationObserver on the
Light DOM (document root). This feature therefore also has
some impact on performance. Leaving the auto-loader out
does mean we have to specify which components are used. Use
the #beLoaded method to reference any components you might
use in an HTML string or WebComponent template. See example
below.

Shoelace components can be used programmatically:
	myComponent appendChild: (SlIcon named: 'heart')

Or be used as HTML string or within a WebComponent template:
	<sl-icon name=""heart"">

IF used from HTML string or template, please make sure the
component is loaded by adding a call to #beLoaded to the
component in the code being used. If for example you create
a WebComponent XyzView which has an icon in the template
(i.e. in the Shadow DOM) add the following method to your
WebComponent:
postInstallOnce

	""Make sure SlIcon component is loaded""

	SlIcon beLoaded

"
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

	^ 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.17.1/cdn/'
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

	"Answer the themes path for the framework"

	^ self importBasePath, 'themes/light.css'
]

{ #category : #tags }
SlElement class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
SlElement class >> isThirdPartyElement [

	"Answer the fact that the receiver is a third party WebComponent"

	^ true
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
	See SlElement class >> #loadComponent.
	This method also sets location where assets are retrieved from."

	CpHtmlElement documentAddStylesheet: self importThemesPath.

	"Add a script which refers to the location for assets (like icons).
	This script should stay present and not be removed like the
	individual component load scripts do. Its attribute 'data-shoelace'
	contains the base path to assets. Shoelace uses this value internally."
	(CpHtmlElement documentAddModuleScript: '// Do not remove this script tag, Shoelace uses the data attribute')
		attributeAt: 'data-shoelace' put: self importBasePath
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

{ #category : #support }
SlElement >> changeEventClass [

	^ SlChangeEvent
]

{ #category : #'text input' }
SlElement >> focus: optionsArray [

	"Sets focus on the receiver with options.

	Only options available (at the moment):
		{ #preventScroll -> true }."

	self apply: #focus withArguments: optionsArray asDictionary
]

{ #category : #support }
SlElement >> inputEventClass [

	^ SlInputEvent
]

{ #category : #performing }
SlElement >> performMessage: aMessage [

	"Perform the specified message on the receiver"

	aMessage sendTo: self
]
