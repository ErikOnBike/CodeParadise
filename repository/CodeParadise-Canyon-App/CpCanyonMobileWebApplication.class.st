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
	Include all the PropertyModelViews in the receiver's Package.
	Add development tools (if appropriate)."

	| package |

	super load.

	"By default only install the Views in the package of the receiver"
	package := self class package.
	CpPropertyModelView allSubclassesDo: [ :each |
		each package = package
			ifTrue: [ self installClass: each ] ].

	"Add development tools"
	self environment ifDevelopment: [
		self loadDevelopment ]
]
