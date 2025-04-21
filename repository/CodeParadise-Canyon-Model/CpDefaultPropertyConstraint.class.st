"
I am a PropertyConstraint with a default implementation.
My behavior is not based on a per instance configuration.
I do support having a global configuration allowing the
default implementation to be made application specific.
"
Class {
	#name : #CpDefaultPropertyConstraint,
	#superclass : #CpPropertyConstraint,
	#classVars : [
		'Configs',
		'Defaults'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpDefaultPropertyConstraint class >> config [

	"Answer my configuration (a Dictionary)"

	^ (Configs ifNil: [ Configs := Dictionary new ])
		at: self ifAbsentPut: [ Dictionary new ]
]

{ #category : #accessing }
CpDefaultPropertyConstraint class >> configAt: aSymbol ifAbsent: aBlock [

	"Answer my configuration for the specified key or evaluate the specified Block if the key is not present"

	^ self config
		at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CpDefaultPropertyConstraint class >> configAt: aSymbol put: anObject [

	"Update my configuration with the specified key and value"

	^ self config
		at: aSymbol put: anObject
]

{ #category : #accessing }
CpDefaultPropertyConstraint class >> default [

	^ (Defaults ifNil: [ Defaults := Dictionary new ])
		at: self ifAbsentPut: [ self basicNew initialize ; yourself ]
]

{ #category : #'instance creation' }
CpDefaultPropertyConstraint class >> new [

	self errorNewReplacedBy: #default
]

{ #category : #initialization }
CpDefaultPropertyConstraint class >> reset [

	<script>

	Defaults := nil
]

{ #category : #accessing }
CpDefaultPropertyConstraint >> configAt: aSymbol [

	"Answer my configuration for the specified key or nil if such configuration is not present"

	^ self configAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CpDefaultPropertyConstraint >> configAt: aSymbol ifAbsent: aBlock [

	"Answer my configuration for the specified key or evaluate the specified Block if the key is not present"

	^ self class
		configAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CpDefaultPropertyConstraint >> configAt: aSymbol put: anObject [

	"Update my configuration with the specified key and value"

	^ self class
		configAt: aSymbol put: anObject
]
