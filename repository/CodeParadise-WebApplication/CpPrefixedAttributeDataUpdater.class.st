Class {
	#name : #CpPrefixedAttributeDataUpdater,
	#superclass : #CpAttributeDataUpdater,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #testing }
CpPrefixedAttributeDataUpdater class >> canHandleAttributeName: aString [

	self = CpPrefixedAttributeDataUpdater
		ifTrue: [ ^ false ].

	^ aString beginsWith: self prefix
]

{ #category : #accessing }
CpPrefixedAttributeDataUpdater class >> prefix [

	"Answer the prefix of the receiver"

	self subclassResponsibility
]

{ #category : #initialization }
CpPrefixedAttributeDataUpdater >> initializeWithKey: keyString name: nameString [

	self initializeWithKey: keyString.

	name := nameString withoutPrefix: self class prefix
]
