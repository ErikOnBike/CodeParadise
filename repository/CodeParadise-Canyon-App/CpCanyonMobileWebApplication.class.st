Class {
	#name : #CpCanyonMobileWebApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-Canyon-App-Application'
}

{ #category : #accessing }
CpCanyonMobileWebApplication class >> allowedPackages [

	"Set the allowed packages for the installation checker.

	Include:
		Package containing the Canyon Model (through CpPropertyModel)
		Package containing Ionic framework (through IonElement)
		Package containing base ValueChanged Announcement
		Package containing the REST API Client"

	^ super allowedPackages, {
		CpPropertyModel package .
		IonElement package .
		ValueChanged package .
		CpRestApiClient package }
]

{ #category : #installing }
CpCanyonMobileWebApplication >> extensionMethodCategories [

	"Answer the collection of extension method categories needed for the receiver"

	^ super extensionMethodCategories,
		#(canyonApplicationExtension)
]

{ #category : #actions }
CpCanyonMobileWebApplication >> load [

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
CpCanyonMobileWebApplication >> postLoad [

	"After application is fully loaded, start it"

	super postLoad.

	self startInstance
]

{ #category : #actions }
CpCanyonMobileWebApplication >> postReload [

	"After application is fully reloaded, start it"

	super postReload.

	self startInstance
]

{ #category : #actions }
CpCanyonMobileWebApplication >> startInstance [

	"Start instance of the receiver in the browser"

	self environment
		sendMessage: (MessageSend
		receiver: CpCanyonAppMainView name
		selector: #start
		arguments: nil)
]
