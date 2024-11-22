"
I am a base class for creating PropertyDefinitions of a Property in a PropertyModel.
The reason for having this empty base class is to prevent having to add extension
methods to Object for the sake of identifying or using Property definitions.
"
Class {
	#name : #CpPropertyDefinition,
	#superclass : #Object,
	#category : #'CodeParadise-Model-Property'
}

{ #category : #testing }
CpPropertyDefinition >> isPropertyConstraint [

	^ false
]

{ #category : #testing }
CpPropertyDefinition >> isPropertyFlag [

	^ false
]

{ #category : #testing }
CpPropertyDefinition >> isPropertyFlag: aSymbol [

	^ false
]

{ #category : #testing }
CpPropertyDefinition >> isPropertyValue [

	^ false
]

{ #category : #testing }
CpPropertyDefinition >> isPropertyValue: aSymbol [

	^ false
]
