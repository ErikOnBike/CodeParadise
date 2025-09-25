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

{ #category : #accessing }
CpPrefixedAttributeDataUpdater >> name [

	^ name withoutPrefix: self class prefix
]
