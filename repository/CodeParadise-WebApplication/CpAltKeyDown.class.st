Class {
	#name : #CpAltKeyDown,
	#superclass : #CpModifierKeyDownCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpAltKeyDown class >> modifierCharacter [

	^ $A
]

{ #category : #accessing }
CpAltKeyDown class >> modifiers [

	"Answer the modifiers (an Integer, see CpEvent >> #modifiers) the receiver represents"

	^ 1
]

{ #category : #accessing }
CpAltKeyDown class >> visualCharacter [

	^ CpClientEnvironment isPlatformMacOS
		ifTrue: [ '⌥' ]
		ifFalse: [ 'Alt' ]
]
