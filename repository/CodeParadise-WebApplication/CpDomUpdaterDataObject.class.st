"
I am a helper class to use Objects as Dictionary like data structures in
the DomUpdater (see class CpTemplateBasedDomUpdater).
My sole responsibility is to convert the Dictionary like access (using the
 #at:ifAbsent: message) to regular message sends. This simply means that
every key that is requested from the receiver is transformed into a
 #perform: on the data object.
There are NO (none, 0) checks implemented. If the key 'halt' is sent to
the receiver, it will perform the halt. Make sure the full set of keys
being used is under the control of someone knowledgable about this.

I do allow some overrides to be given. This is a Dictionary which will
first be checked before calling the key on the data object. Although
this does allow a few well known 'dangerous' methods to be stopped, it
should not be seen as a mechanism to prevent all. Reason is that any
unknown method (for the data object) will still result in a DNU.
If the result from the override Dictionary (if any is present) is a
BlockClosure, it will be culled with the data object as argument. This
allows more dynamic data responses.
"
Class {
	#name : #CpDomUpdaterDataObject,
	#superclass : #Object,
	#instVars : [
		'data',
		'overrides'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #'instance creation' }
CpDomUpdaterDataObject class >> new [

	self errorNewReplacedBy: (' or ' join: { #on: . #on:overrides: })
]

{ #category : #'instance creation' }
CpDomUpdaterDataObject class >> on: anObject [

	^ self on: anObject overrides: nil
]

{ #category : #'instance creation' }
CpDomUpdaterDataObject class >> on: anObject overrides: aDictionary [

	"Answer a new instance of the receiver for the specified Object"

	^ self basicNew
		initializeWithObject: anObject overrides: aDictionary ;
		yourself
]

{ #category : #accessing }
CpDomUpdaterDataObject >> at: aString ifAbsent: aBlock [

	"Answer the data for the specified key.
	Be aware not failsafe mechanism is in place. If the key supplied
	is 'halt' it will halt (as per request), if the message is not
	implemented a DNU will be signaled."

	^ self overrideAt: aString ifAbsent: [ data perform: aString asSymbol ]
]

{ #category : #initialization }
CpDomUpdaterDataObject >> initializeWithObject: anObject overrides: aDictionary [

	self initialize.

	data := anObject.
	overrides := aDictionary
]

{ #category : #accessing }
CpDomUpdaterDataObject >> overrideAt: aString ifAbsent: aBlock [

	"Answer the overriden value for the specified key. If no such
	value exists answer the evaluation of the specified Block.

	Implementation:
	The same #at:ifAbsent: message is the only message sent to the
	override Dictionary (just in case they need to be mixed with
	other DomUpdaterDataObjects at some point in the future)."

	| value |

	overrides ifNil: [ ^ aBlock value ].

	value := overrides at: aString ifAbsent: [ ^ aBlock value ].
	^ value isBlock
		ifTrue: [ value cull: data ]
		ifFalse: [ value ]
]
