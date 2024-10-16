Class {
	#name : #CpProperty,
	#superclass : #Object,
	#instVars : [
		'model',
		'name'
	],
	#category : #'CodeParadise-Model-Property'
}

{ #category : #'instance creation' }
CpProperty class >> on: aModel name: aSymbol [

	^ self basicNew
		initializeWith: aModel name: aSymbol ;
		yourself
]

{ #category : #initialization }
CpProperty >> initializeWith: aModel name: aSymbol [

	self initialize.

	model := aModel.
	name := aSymbol
]

{ #category : #accessing }
CpProperty >> name [

	^ name
]

{ #category : #removing }
CpProperty >> removeSubscription: aSubscription [

	"Remove the specified subscription from the receiver"

	model removeSubscription: aSubscription
]

{ #category : #announcing }
CpProperty >> unsubscribe: anObject [

	"Unsubscribe the specified Object from Announcements of the receiver"

	^ model unsubscribe: anObject
]

{ #category : #accessing }
CpProperty >> value [

	"Answer the value of the receiver"

	^ model propertyAt: name
]

{ #category : #accessing }
CpProperty >> value: anObject [

	"Set the value of the receiver to the specified value"

	^ model propertyAt: name put: anObject
]

{ #category : #enumerating }
CpProperty >> whenChangedDo: aBlock for: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver"

	model
		when: (CpPropertyChanged name: self name)
		do: aBlock
		for: anObject
]

{ #category : #enumerating }
CpProperty >> whenChangedSend: aSymbol to: anObject [

	"Let the sender subscribe to the value changed announcement of the receiver"

	model
		when: (CpPropertyChanged name: self name)
		send: aSymbol
		to: anObject
]
