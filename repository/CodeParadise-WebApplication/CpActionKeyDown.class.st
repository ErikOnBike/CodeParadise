"
I represent a modifier key being pressed down. I have platform specific behavior.
On Windows and Linux I am represented as the Ctrl key being pressed down.
On macOS I am represented as the Cmd key being pressed down.

"
Class {
	#name : #CpActionKeyDown,
	#superclass : #CpModifierKeyDownCondition,
	#classVars : [
		'PlatformModifier'
	],
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #accessing }
CpActionKeyDown class >> modifierCharacter [

	^ $X
]

{ #category : #accessing }
CpActionKeyDown class >> modifiers [

	"Answer the modifiers (an Integer, see CpEvent >> #modifiers) the receiver represents"

	^ PlatformModifier
]

{ #category : #'class initialization' }
CpActionKeyDown class >> postInstallOnce [

	"Set the modifiers based on the current platform"

	PlatformModifier := CpClientEnvironment isPlatformMacOS
		ifTrue: [ CpMetaKeyDown modifiers ]
		ifFalse: [ CpCtrlKeyDown modifiers ]
]
