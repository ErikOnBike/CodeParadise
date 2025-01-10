Class {
	#name : #CpNodeApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-WebApplication-Core'
}

{ #category : #installing }
CpNodeApplication >> addInstallationChecker [

	super addInstallationChecker.

	"Add an InstallationChecker for the Node.js environment"
	environment
		addInstallationChecker: CpEnvironmentMethodInstallationChecker nodejs
]
