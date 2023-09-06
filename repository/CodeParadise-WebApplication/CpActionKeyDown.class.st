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
