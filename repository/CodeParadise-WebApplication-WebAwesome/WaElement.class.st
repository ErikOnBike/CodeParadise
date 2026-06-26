"
I am the base class for WebAwesome components.
See https://webawesome.com

WebAwesome components do not load automagically (i.e. the
auto-loader feature is not in use).
A so called 'auto-loader' function exists in WebAwesome. This
does however not work for components used inside a Shadow DOM.
The auto-loader works by setting a MutationObserver on the
Light DOM (document root). This feature therefore also has
some impact on performance. Leaving the auto-loader out
does mean we have to specify which components are used. Use
the #beLoaded method to reference any components you might
use in an HTML string or WebComponent template. See example
below.

WebAwesome components can be used programmatically:
	myComponent appendChild: (WaIcon named: 'heart')

Or be used as HTML string or within a WebComponent template:
	<wa-icon name=""heart""></wa-icon>

IF used from HTML string or template, please make sure the
component is loaded by adding a call to #beLoaded to the
component in the code being used. If for example you create
a WebComponent XyzView which has an icon in the template
(i.e. in the Shadow DOM) add the following method to your
WebComponent:
postInstallOnce

	""Make sure WaIcon component is loaded""

	WaIcon beLoaded

"
Class {
	#name : #WaElement,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaElement class >> componentLoaderName [

	^ self name asKebabCase, '-loader'
]

{ #category : #accessing }
WaElement class >> componentName [

	^ self nameWithoutPrefix asKebabCase
]

{ #category : #accessing }
WaElement class >> importBasePath [

	^ 'https://cdn.jsdelivr.net/npm/@awesome.me/webawesome@3.9.0/dist/'
]

{ #category : #accessing }
WaElement class >> importComponentCode [

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
WaElement class >> importComponentPath [

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
WaElement class >> importStylesPath [

	"Answer the themes path for the framework"

	^ self importBasePath, 'styles/webawesome.css'
]

{ #category : #tags }
WaElement class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #testing }
WaElement class >> isThirdPartyElement [

	"Answer the fact that the receiver is a third party WebComponent"

	^ true
]

{ #category : #'class initialization' }
WaElement class >> loadComponent [

	"Load component from CDN"

	CpHtmlElement
		documentAddScript: self importComponentCode
		type: 'module'
		id: self componentLoaderName
]

{ #category : #'class initialization' }
WaElement class >> loadLibrary [

	"Load library from CDN.

	Implementation:
	Load stylesheet here. All components will load themselves.
	See WaElement class >> #loadComponent.
	This method also sets location where assets are retrieved from."

	CpHtmlElement documentAddStylesheet: self importStylesPath.

	"Add a script which refers to the location for assets (like icons).
	This script should stay present and not be removed like the
	individual component load scripts do. Its attribute 'data-webawesome'
	contains the base path to assets. WebAwesome uses this value internally."
	(CpHtmlElement documentAddModuleScript: '// Do not remove this script tag, WebAwesome uses the data attribute')
		attributeAt: 'data-webawesome' put: self importBasePath
]

{ #category : #'class initialization' }
WaElement class >> postInstall [

	"Install WebAwesome component into receiver"

	super postInstall.

	self hasAbstractTag
		ifTrue: [ ^ self ].

	self loadComponent
]

{ #category : #'class initialization' }
WaElement class >> postInstallOnce [

	"Install WebAwesome library into receiver"

	self loadLibrary
]

{ #category : #support }
WaElement >> changeEventClass [

	^ CpChangeEvent
]

{ #category : #support }
WaElement >> inputEventClass [

	^ CpInputEvent
]

{ #category : #performing }
WaElement >> performMessage: aMessage [

	"Perform the specified message on the receiver"

	aMessage sendTo: self
]
