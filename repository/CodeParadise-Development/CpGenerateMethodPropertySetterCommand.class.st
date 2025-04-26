Class {
	#name : #CpGenerateMethodPropertySetterCommand,
	#superclass : #SycMethodCommand,
	#category : #'CodeParadise-Development-Commands'
}

{ #category : #activation }
CpGenerateMethodPropertySetterCommand class >> methodContextMenuActivation [

	<classAnnotation>
	
	^ CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyMethod asCalypsoItemContext
]

{ #category : #accessing }
CpGenerateMethodPropertySetterCommand >> defaultMenuIconName [

	^ #classVarsSelected
]

{ #category : #accessing }
CpGenerateMethodPropertySetterCommand >> defaultMenuItemName [

	^ 'Generate property setter (from getter or empty setter)'
]

{ #category : #accessing }
CpGenerateMethodPropertySetterCommand >> description [

	^ 'Generate the actual code for the property setter based on the getter with comments'
]

{ #category : #execution }
CpGenerateMethodPropertySetterCommand >> execute [

	methods do: [ :each | 
		self generatePropertySetterFor: each ]
]

{ #category : #execution }
CpGenerateMethodPropertySetterCommand >> generatePropertySetterFor: aCompiledMethod [

	aCompiledMethod numArgs > 1
		ifTrue: [ ^ self ].

	aCompiledMethod methodClass
		generatePropertySetterFor: aCompiledMethod
]
