Class {
	#name : #CpAttributeDataUpdater,
	#superclass : #CpDomDataUpdater,
	#instVars : [
		'name'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'instance creation' }
CpAttributeDataUpdater class >> canHandleAttributeName: aString [

	"Answer whether the receiver can handle the specified attribute name.
	By default answer false, but the receiver (the base class) will, if
	all else fail, handle the attribute name in the default way."

	^ false
]

{ #category : #'instance creation' }
CpAttributeDataUpdater class >> key: keyString matchingName: nameString [

	"Answer an instance of the receiver that will handle the specified attribute name"

	self allSubclassesDo: [ :each |
		(each canHandleAttributeName: nameString)
			ifTrue: [ ^ each key: keyString name: nameString ] ].

	"Default is the receiver itself"
	^ self key: keyString name: nameString
]

{ #category : #'instance creation' }
CpAttributeDataUpdater class >> key: keyString name: nameString [

	"Answer an instance of the receiver on the specified attribute name"

	^ self basicNew
		initializeWithKey: keyString name: nameString ;
		yourself
]

{ #category : #'instance creation' }
CpAttributeDataUpdater class >> new [

	self errorNewReplacedBy: (' or ' join: { #key:name: . #key:matchingName: })
]

{ #category : #initialization }
CpAttributeDataUpdater >> initializeWithKey: keyString name: nameString [

	self initializeWithKey: keyString.

	name := nameString
]

{ #category : #accessing }
CpAttributeDataUpdater >> name [

	^ name
]

{ #category : #rendering }
CpAttributeDataUpdater >> renderData: anObject on: anElement [

	anElement attributeAt: self name put: (self stringValueFromData: anObject)
]
