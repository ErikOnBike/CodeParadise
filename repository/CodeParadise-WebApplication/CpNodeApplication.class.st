Class {
	#name : #CpNodeApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #accessing }
CpNodeApplication class >> app [

	"Answer the receiver unique name (used in URL to access the application as well)"

	^ (self nameWithoutPrefix withoutSuffix: #NodeApplication) asKebabCase asSymbol
]

{ #category : #installing }
CpNodeApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the Node.js environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker nodejs
]

{ #category : #actions }
CpNodeApplication >> load [

	"Perform any actions needed when the ClientEnvironment belonging to the receiver loaded (for the first time)"

	super load.

	"Install the extension method to convert a Block to a JavaScriptFunction. Because of circular dependencies
	this can't be done by defining that method as an extension method."
	self installMethod: BlockClosure >> #asJavaScriptFunction
]
