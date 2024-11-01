"
I am an InstallationChecker. I am responsible for deciding whether a Class or a Method
can be installed in a ClientEnvironment.

I have a dummy implementation answering 'true' to both installation questions.
Typically a ServerApplication has the same capability and will answer based on packages
which are allowed for the application.
For more specific situations, subclass me and add the needed behavior.
"
Class {
	#name : #CpInstallationChecker,
	#superclass : #Object,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #testing }
CpInstallationChecker >> isClassAllowed: aClass [

	"Answer whether the specified Class can be installed (in a ClientEnvironment)"

	^ true
]

{ #category : #testing }
CpInstallationChecker >> isMethodAllowed: aCompiledMethod [

	"Answer whether the specified CompiledMethod can be installed (in a ClientEnvironment)"

	^ true
]
