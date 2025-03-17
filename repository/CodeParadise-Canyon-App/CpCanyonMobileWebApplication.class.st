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
