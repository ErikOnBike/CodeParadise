"
I am an InstallationChecker using a fixed collection of Packages to decide
whether installation of classes and methods is allowed.

"
Class {
	#name : #CpPackageInstallationChecker,
	#superclass : #CpInstallationChecker,
	#instVars : [
		'packages'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpPackageInstallationChecker class >> new [

	self errorNewReplacedBy: #packages:
]

{ #category : #'instance creation' }
CpPackageInstallationChecker class >> package: aPackage [

	^ self packages: { aPackage }
]

{ #category : #'instance creation' }
CpPackageInstallationChecker class >> packages: aCollection [

	"Answer a new instance of the receiver with the specified Collection of allowed Packages"

	^ self basicNew
		initializeWithPackages: aCollection ;
		yourself
]

{ #category : #initialization }
CpPackageInstallationChecker >> initializeWithPackages: aCollection [

	self initialize.

	packages := aCollection
]

{ #category : #testing }
CpPackageInstallationChecker >> isClassAllowed: aClass [

	"Answer whether the specified Class is allowed within the receiver"

	^ (super isClassAllowed: aClass) or: [ packages includes: aClass package ]
]

{ #category : #testing }
CpPackageInstallationChecker >> isMethodAllowed: aCompiledMethod [

	"Answer whether the specified CompiledMethod can be installed (in a ClientEnvironment)"

	^ (super isMethodAllowed: aCompiledMethod) or: [ packages includes: aCompiledMethod package ]
]
