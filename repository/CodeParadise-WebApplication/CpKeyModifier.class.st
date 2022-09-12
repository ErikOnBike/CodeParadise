Class {
	#name : #CpKeyModifier,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #combining }
CpKeyModifier class >> + aKeyModifier [

	"Answer an instance representing the combined modifier"

	^ self value: (self value bitOr: aKeyModifier value)
]

{ #category : #adding }
CpKeyModifier class >> addToClickAnnouncementClass: aClickAnnouncement [

	aClickAnnouncement addKeyModifier: self
]

{ #category : #'instance creation' }
CpKeyModifier class >> altCtrlMetaModifier [

	"Convenience method"

	^ self value: 7
]

{ #category : #'instance creation' }
CpKeyModifier class >> altCtrlModifier [

	"Convenience method"

	^ self value: 3
]

{ #category : #comparing }
CpKeyModifier class >> equals: aKeyModifier [

	"Answer whether the receiver and specified key modifier match exactly"

	^ self value = aKeyModifier value
]

{ #category : #comparing }
CpKeyModifier class >> includes: aKeyModifier [

	"Answer whether the receiver includes the specified key modifier (fully)"

	^ self value allMask: aKeyModifier value
]

{ #category : #comparing }
CpKeyModifier class >> isPresentIn: aKeyModifier [

	"Answer whether the receiver is (fully) present in the specified key modifier"

	^ aKeyModifier value allMask: self value
]

{ #category : #'instance creation' }
CpKeyModifier class >> value: anInteger [

	"Answer an instance representing the specified modifier"

	^ self basicNew
		initializeWith: anInteger ;
		yourself
]

{ #category : #combining }
CpKeyModifier >> + aKeyModifier [

	"Answer a new instance representing the combined modifier"

	^ CpKeyModifier value: (self value bitOr: aKeyModifier value)
]

{ #category : #adding }
CpKeyModifier >> addToClickAnnouncementClass: aClickAnnouncement [

	aClickAnnouncement addKeyModifier: self
]

{ #category : #comparing }
CpKeyModifier >> equals: aKeyModifier [

	"Answer whether the receiver and specified key modifier match exactly"

	^ value = aKeyModifier value
]

{ #category : #comparing }
CpKeyModifier >> includes: aKeyModifier [

	"Answer whether the receiver includes the specified key modifier (fully)"

	^ value allMask: aKeyModifier value
]

{ #category : #initialization }
CpKeyModifier >> initializeWith: anInteger [

	self initialize.

	value := anInteger
]

{ #category : #testing }
CpKeyModifier >> isPresentIn: aKeyModifier [

	"Answer whether the receiver is (fully) present in the specified key modifier"

	^ aKeyModifier value allMask: self value
]

{ #category : #accessing }
CpKeyModifier >> value [

	"Answer an Integer representing the receiver's value"

	^ value
]
