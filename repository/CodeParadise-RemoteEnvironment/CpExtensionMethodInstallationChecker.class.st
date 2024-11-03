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

{ #category : #initialization }
CpExtensionMethodInstallationChecker >> initializeWithExtensionMethodCategories: aCollection [

	self initialize.

	extensionMethodCategories := aCollection
]

{ #category : #testing }
CpExtensionMethodInstallationChecker >> isMethodAllowed: aCompiledMethod [

	"Answer whether the specified CompiledMethod can be installed (in a ClientEnvironment)"

	| pragmas |

	"Check if the method is allowed by a chained InstallationChecker first (since accessing pragmas might be slower)"
	(super isMethodAllowed: aCompiledMethod)
		ifTrue: [ ^ true ].

	"Check if this method is an explicit extension method"
	pragmas := aCompiledMethod pragmas.
	extensionMethodCategories do: [ :each |
		pragmas detect: [ :pragma | pragma keyword = each ] ifFound: [ ^ true ] ].

	^ false
]