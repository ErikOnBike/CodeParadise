"
I am an InstallationChecker. I am responsible for deciding whether a Class or a Method
can be installed in a ClientEnvironment.

By default I do NOT allow any Class or Method to be installed.

I can be 'chained' to another InstallationChecker which can override the decision
(in effect 'or-ing' the result of both checkers).
"
Class {
	#name : #CpInstallationChecker,
	#superclass : #Object,
	#instVars : [
		'chainedInstallationChecker'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpInstallationChecker class >> on: anInstallationChecker [

	"Answer an instance of the receiver chained to the specified InstallationChecker"

	^ self basicNew
		initializeWithInstallationChecker: anInstallationChecker ;
		yourself
]

{ #category : #accessing }
CpInstallationChecker >> chainTo: anInstallationChecker [

	chainedInstallationChecker := anInstallationChecker
]

{ #category : #initialization }
CpInstallationChecker >> initializeWithInstallationChecker: anInstallationChecker [

	self initialize.

	chainedInstallationChecker := anInstallationChecker
]

{ #category : #testing }
CpInstallationChecker >> isClassAllowed: aClass [

	"Answer whether the specified Class can be installed (in a ClientEnvironment)"

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker isClassAllowed: aClass ]
		ifNil: [ false ]
]

{ #category : #testing }
CpInstallationChecker >> isMethodAllowed: aCompiledMethod [

	"Answer whether the specified CompiledMethod can be installed (in a ClientEnvironment)"

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker isMethodAllowed: aCompiledMethod ]
		ifNil: [ false ]
]
