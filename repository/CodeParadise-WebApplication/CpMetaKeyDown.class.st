Class {
	#name : #CpMetaKeyDown,
	#superclass : #CpModifierKeyDownCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpMetaKeyDown class >> modifierCharacter [

	^ $M
]

{ #category : #accessing }
CpMetaKeyDown class >> modifiers [

	"Answer the modifiers (an Integer, see CpEvent >> #modifiers) the receiver represents"

	^ 4
]

{ #category : #accessing }
CpMetaKeyDown class >> visualCharacter [

	^ CpClientEnvironment isPlatformMacOS
		ifTrue: [ '⌘' ]
		ifFalse: [ 'Win' ]
]
