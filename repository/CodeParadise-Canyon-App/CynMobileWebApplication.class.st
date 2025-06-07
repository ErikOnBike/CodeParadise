"
I am the server side part of a Canyon Application.
Only during development am I needed. Once an Application is ready for deployment,
a running (clean) image should be snapshotted into a distributable standalone image.
This standalone image can then be put onto a web server together with an appropriate
html file to fire it up.

The client side of a Canyon Application is typically created by subclassing the CynApp
class. This is a WebComponent and therefore present in the View (sub)package.
"
Class {
	#name : #CynMobileWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-Canyon-App-Application'
}

{ #category : #accessing }
CynMobileWebApplication class >> allowedPackages [

	"Set the allowed packages for the installation checker.

	Include:
		Package containing the Canyon Model (through CpPropertyModel)
		Package containing Ionic framework (through IonElement)
		Package containing base ValueChanged Announcement
		Package containing the REST API Client"

	^ super allowedPackages, {
		CynPropertyModel package .
		IonElement package .
		ValueChanged package .
		CynRestApiClient package .
		CpBrowserSnapshot package }
]

{ #category : #accessing }
CynMobileWebApplication class >> app [

	"Answer the receiver unique name (used in URL to access the application as well)"

	^ ((self nameWithoutPrefix withoutSuffix: #WebApplication) withoutSuffix: #Mobile) asKebabCase asSymbol
]

{ #category : #tags }
CynMobileWebApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #installing }
CynMobileWebApplication >> addInstallationChecker [

	super addInstallationChecker.

	self environment ifDevelopment: [
		environment addInstallationChecker: (CpPackageInstallationChecker
			package: (CynMobileWebApplication >> #updateMultiLanguageText) package) ]
]

{ #category : #installing }
CynMobileWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(canyonModelExtension canyonApplicationExtension)
]

{ #category : #actions }
CynMobileWebApplication >> load [

	"Load the application.
	Include all the Views (Pages, ModelViews and the MainView) from the receiver's Package.
	Add development tools (if appropriate)."

	| package |

	super load.

	"By default install all the Views in the package of the receiver"
	package := self class package.
	CpWebComponent allSubclassesDo: [ :each |
		each package = package
			ifTrue: [ self installClass: each ] ].

	"Add development tools"
	self environment ifDevelopment: [
		self loadDevelopment ]
]

{ #category : #actions }
CynMobileWebApplication >> postLoad [

	"After application is fully loaded, start it"

	super postLoad.

	self startInstance
]

{ #category : #actions }
CynMobileWebApplication >> postReload [

	"After application is fully reloaded, start it"

	super postReload.

	self startInstance
]

{ #category : #actions }
CynMobileWebApplication >> preLoad [

	"Preload classes into the application"

	super preLoad.

	"By default install all property slot (types)"
	CynClientPropertySlot allSubclassesDo: [ :each |
		self installClass: each ]
]

{ #category : #actions }
CynMobileWebApplication >> startInstance [

	"Start instance of the receiver in the browser"

	self environment
		sendMessage: (MessageSend
		receiver: CynApp name
		selector: #start
		arguments: nil)
]
