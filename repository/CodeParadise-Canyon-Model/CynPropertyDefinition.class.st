"
I am a base class for creating PropertyDefinitions of a Property in a PropertyModel.
The reason for having this empty base class is to prevent having to add extension
methods to Object for the sake of identifying or using Property definitions.
"
Class {
	#name : #CynPropertyDefinition,
	#superclass : #Object,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #testing }
CynPropertyDefinition >> isPropertyConstraint [

	^ false
]

{ #category : #testing }
CynPropertyDefinition >> isPropertyFlag [

	^ false
]

{ #category : #testing }
CynPropertyDefinition >> isPropertyFlag: aSymbol [

	^ false
]

{ #category : #testing }
CynPropertyDefinition >> isPropertyValue [

	^ false
]

{ #category : #testing }
CynPropertyDefinition >> isPropertyValue: aSymbol [

	^ false
]
