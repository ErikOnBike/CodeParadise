Class {
	#name : #CpEnvironmentMethodInstallationChecker,
	#superclass : #CpInstallationChecker,
	#instVars : [
		'environmentName'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpEnvironmentMethodInstallationChecker class >> browser [

	^ self environmentName: #browser
]

{ #category : #'instance creation' }
CpEnvironmentMethodInstallationChecker class >> environmentName: aSymbol [

	^ self basicNew
		initializeWithEnvironmentName: aSymbol ;
		yourself
]

{ #category : #'instance creation' }
CpEnvironmentMethodInstallationChecker class >> new [

	self errorNewReplacedBy: #environmentName:
]

{ #category : #'instance creation' }
CpEnvironmentMethodInstallationChecker class >> nodejs [

	^ self environmentName: #nodejs
]

{ #category : #testing }
CpEnvironmentMethodInstallationChecker >> excludeMethod: aCompiledMethod [

	"Answer whether the specified CompiledMethod should NOT be installed (in a ClientEnvironment)"

	| refersToEnvironment isPresent |

	"Check if the method is not allowed by a chained InstallationChecker first (since accessing pragmas might be slower)"
	(super excludeMethod: aCompiledMethod)
		ifTrue: [ ^ true ].

	"Check if this method has an incompatible environment pragma"
	refersToEnvironment := false.
	isPresent := false.
	aCompiledMethod pragmas do: [ :each |
		each selector = #environment:
			ifTrue: [
				refersToEnvironment := true.
				(each argumentAt: 1) = environmentName
					ifTrue: [ isPresent := true ] ] ].

	"If reference is present to environment, but the receiver's environment is not present, exclude this method"
	^ refersToEnvironment and: [ isPresent not ]
]

{ #category : #initialization }
CpEnvironmentMethodInstallationChecker >> initializeWithEnvironmentName: aSymbol [

	self initialize.

	environmentName := aSymbol
]
