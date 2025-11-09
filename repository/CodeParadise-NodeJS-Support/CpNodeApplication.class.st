Class {
	#name : #CpNodeApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-NodeJS-Support-Application'
}

{ #category : #accessing }
CpNodeApplication class >> app [

	"Answer the receiver unique name (used in URL to access the application as well)"

	^ (self nameWithoutPrefix withoutSuffix: #NodeApplication) asKebabCase asSymbol
]

{ #category : #tags }
CpNodeApplication class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #installing }
CpNodeApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the Node.js environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker nodejs
]
