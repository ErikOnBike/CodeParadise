Class {
	#name : #CpCtrlKeyDown,
	#superclass : #CpModifierKeyDownCondition,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpCtrlKeyDown class >> modifierCharacter [

	^ $C
]

{ #category : #accessing }
CpCtrlKeyDown class >> modifiers [

	"Answer the modifiers (an Integer, see CpEvent >> #modifiers) the receiver represents"

	^ 2
]
