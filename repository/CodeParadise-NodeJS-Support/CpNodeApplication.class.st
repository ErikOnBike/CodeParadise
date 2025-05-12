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

{ #category : #installing }
CpNodeApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the Node.js environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker nodejs
]
