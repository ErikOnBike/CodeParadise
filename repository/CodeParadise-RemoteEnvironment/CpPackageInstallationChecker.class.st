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

{ #category : #testing }
CpPackageInstallationChecker >> includeClass: aClass [

	"Answer whether the specified Class should be installed (in a ClientEnvironment)"

	^ (super includeClass: aClass) or: [ packages includes: aClass package ]
]

{ #category : #testing }
CpPackageInstallationChecker >> includeMethod: aCompiledMethod [

	"Answer whether the specified CompiledMethod should be installed (in a ClientEnvironment)"

	^ (super includeMethod: aCompiledMethod) or: [ packages includes: aCompiledMethod package ]
]

{ #category : #initialization }
CpPackageInstallationChecker >> initializeWithPackages: aCollection [

	self initialize.

	packages := aCollection
]
