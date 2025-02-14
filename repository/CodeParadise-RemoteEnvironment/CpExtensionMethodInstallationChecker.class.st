Class {
	#name : #CpExtensionMethodInstallationChecker,
	#superclass : #CpInstallationChecker,
	#instVars : [
		'extensionMethodCategories'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpExtensionMethodInstallationChecker class >> extensionMethodCategories: aCollection [

	^ self basicNew
		initializeWithExtensionMethodCategories: aCollection ;
		yourself
]

{ #category : #'instance creation' }
CpExtensionMethodInstallationChecker class >> new [

	self errorNewReplacedBy: #extensionMethodCategories:
]

{ #category : #testing }
CpExtensionMethodInstallationChecker >> includeMethod: aCompiledMethod [

	"Answer whether the specified CompiledMethod should be installed (in a ClientEnvironment)"

	| pragmas |

	"Check if the method is allowed by a chained InstallationChecker first (since accessing pragmas might be slower)"
	(super includeMethod: aCompiledMethod)
		ifTrue: [ ^ true ].

	"Check if this method is an explicit extension method"
	pragmas := aCompiledMethod pragmas.
	extensionMethodCategories do: [ :each |
		pragmas detect: [ :pragma | pragma selector = each ] ifFound: [ ^ true ] ].

	^ false
]

{ #category : #initialization }
CpExtensionMethodInstallationChecker >> initializeWithExtensionMethodCategories: aCollection [

	self initialize.

	extensionMethodCategories := aCollection
]
