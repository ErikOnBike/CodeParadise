"
I am a PropertyConstraint with a default implementation.
My behavior is not based on a per instance configuration.
I do support having a global configuration allowing the
default implementation to be made application specific.
"
Class {
	#name : #CynDefaultPropertyConstraint,
	#superclass : #CynPropertyConstraint,
	#classVars : [
		'Configs',
		'Defaults'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CynDefaultPropertyConstraint class >> config [

	"Answer my configuration (a Dictionary)"

	^ (Configs ifNil: [ Configs := Dictionary new ])
		at: self ifAbsentPut: [ Dictionary new ]
]

{ #category : #accessing }
CynDefaultPropertyConstraint class >> configAt: aSymbol ifAbsent: aBlock [

	"Answer my configuration for the specified key or evaluate the specified Block if the key is not present"

	^ self config
		at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CynDefaultPropertyConstraint class >> configAt: aSymbol put: anObject [

	"Update my configuration with the specified key and value"

	^ self config
		at: aSymbol put: anObject
]

{ #category : #accessing }
CynDefaultPropertyConstraint class >> default [

	^ (Defaults ifNil: [ Defaults := Dictionary new ])
		at: self ifAbsentPut: [ self basicNew initialize ; yourself ]
]

{ #category : #validating }
CynDefaultPropertyConstraint class >> isValidValue: anObject [

	"Answer whether the specified value is valid using the default instance.
	The specified value is normalized before validation."

	^ self default
		isValidValue: anObject
]

{ #category : #validating }
CynDefaultPropertyConstraint class >> isValidValue: anObject in: aModel [

	"Answer whether the specified value is valid using the default instance.
	The specified value is normalized before validation."

	^ self default
		isValidValue: anObject in: aModel
]

{ #category : #'instance creation' }
CynDefaultPropertyConstraint class >> new [

	self errorNewReplacedBy: #default
]

{ #category : #initialization }
CynDefaultPropertyConstraint class >> reset [

	<script>

	Defaults := nil
]

{ #category : #validating }
CynDefaultPropertyConstraint class >> violationsForValue: anObject in: aModel do: aBlock [

	"Validate the provided value using the default instance and
	evaluate the specified Block for each violation"

	self default
		violationsForValue: anObject in: aModel do: aBlock
]

{ #category : #accessing }
CynDefaultPropertyConstraint >> configAt: aSymbol [

	"Answer my configuration for the specified key or nil if such configuration is not present"

	^ self configAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
CynDefaultPropertyConstraint >> configAt: aSymbol ifAbsent: aBlock [

	"Answer my configuration for the specified key or evaluate the specified Block if the key is not present"

	^ self class
		configAt: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
CynDefaultPropertyConstraint >> configAt: aSymbol put: anObject [

	"Update my configuration with the specified key and value"

	^ self class
		configAt: aSymbol put: anObject
]
