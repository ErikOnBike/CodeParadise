"
I am a DataUpdater.
I am responsible for 'rendering data' onto a DOM Element.
My subclasses all have specific behavior for 'rendering data'.
Some might update the text content of the Element, another might
update some class of the Element or change styling.
"
Class {
	#name : #CpDomDataUpdater,
	#superclass : #Object,
	#instVars : [
		'key'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'instance creation' }
CpDomDataUpdater class >> key: aString [

	"Answer an instance of the receiver with the specified key"

	^ self basicNew
		initializeWithKey: aString ;
		yourself
]

{ #category : #'instance creation' }
CpDomDataUpdater class >> new [

	self errorNewReplacedBy: #key:
]

{ #category : #initialization }
CpDomDataUpdater >> initializeWithKey: aString [

	self initialize.

	key := aString
]

{ #category : #rendering }
CpDomDataUpdater >> renderData: anObject on: anElement [

	"Render the specified data on the specified Element"

	self subclassResponsibility
]

{ #category : #accessing }
CpDomDataUpdater >> stringValueFromData: anObject [

	"Answer a String representation of the value from the specified data Object
	or nil if the value was nil (i.e. nil will not be represented as a String)"

	^ (self valueFromData: anObject)
		ifNotNil: [ :value | value asString ]
]

{ #category : #accessing }
CpDomDataUpdater >> valueFromData: anObject [

	"Answer the value from the specified data Object"

	^ anObject at: key ifAbsent: [ nil ]
]
