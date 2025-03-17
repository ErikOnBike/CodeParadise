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

{ #category : #'as yet unclassified' }
CpInstallationChecker class >> checkDeprecatedUsage [

	self subclassesDo: [ :each |
		(each includesSelector: #isMethodAllowed:)
			ifTrue: [ self warnCr: 'Please use #includeMethod: or #excludeMethod: in ', each name, ', since #isMethodAllowed: is deprecated' ].
		(each includesSelector: #isClassAllowed:)
			ifTrue: [ self warnCr: 'Please use #includeClass: or #excludeClass: in ', each name, ', since #isClassAllowed: is deprecated' ] ]
]

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

{ #category : #testing }
CpInstallationChecker >> excludeClass: aClass [

	"Answer whether the specified Class should NOT be installed (in a ClientEnvironment).

	By default, classes should NOT be excluded."

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker excludeClass: aClass ]
		ifNil: [ false ]
]

{ #category : #testing }
CpInstallationChecker >> excludeMethod: aCompiledMethod [

	"Answer whether the specified CompiledMethod should NOT be installed (in a ClientEnvironment).

	By default, only server side only methods should be excluded.

	Example of excluding methods are in EnvironmentMethodInstallationChecker."

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker excludeMethod: aCompiledMethod ]
		ifNil: [ aCompiledMethod isServerSideOnly ]
]

{ #category : #testing }
CpInstallationChecker >> includeClass: aClass [

	"Answer whether the specified Class should be installed (in a ClientEnvironment).

	By default, classes should NOT be included.
	
	Example of including methods are in PackageInstallationChecker."

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker includeClass: aClass ]
		ifNil: [ false ]
]

{ #category : #testing }
CpInstallationChecker >> includeMethod: aCompiledMethod [

	"Answer whether the specified CompiledMethod should be installed (in a ClientEnvironment).

	By default, methods should NOT be included.
	
	Example of including methods are in PackageInstallationChecker and ExtensionMethodInstallationChecker."

	^ chainedInstallationChecker
		ifNotNil: [ chainedInstallationChecker includeMethod: aCompiledMethod ]
		ifNil: [ false ]
]

{ #category : #initialization }
CpInstallationChecker >> initializeWithInstallationChecker: anInstallationChecker [

	self initialize.

	chainedInstallationChecker := anInstallationChecker
]

{ #category : #testing }
CpInstallationChecker >> isClassAllowed: aClass [

	"Answer whether the specified Class can be installed (in a ClientEnvironment)

	Implementation:
	Classes can be either included or excluded from installation. Only if these conditions are
	consistent for inclusion (included = true and excluded = false) will a class be installed.

	Do not override this method, but use #includeClass: or #excludeClass: please."

	^ (self includeClass: aClass) and: [ (self excludeClass: aClass) not ]
]

{ #category : #testing }
CpInstallationChecker >> isMethodAllowed: aCompiledMethod [

	"Answer whether the specified CompiledMethod can be installed (in a ClientEnvironment).

	Implementation:
	Methods can be either included or excluded from installation. Only if these conditions are
	consistent for inclusion (included = true and excluded = false) will a method be installed.

	Do not override this method, but use #includeMethod: or #excludeMethod: please."

	^ (self includeMethod: aCompiledMethod) and: [ (self excludeMethod: aCompiledMethod) not ]
]
