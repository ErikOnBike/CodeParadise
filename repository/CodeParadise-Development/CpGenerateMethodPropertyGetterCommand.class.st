Class {
	#name : #CpGenerateMethodPropertyGetterCommand,
	#superclass : #SycMethodCommand,
	#category : #'CodeParadise-Development-Commands'
}

{ #category : #activation }
CpGenerateMethodPropertyGetterCommand class >> methodContextMenuActivation [

	<classAnnotation>
	
	^ CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyMethod asCalypsoItemContext
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterCommand >> defaultMenuIconName [

	^ #classVarsSelected
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterCommand >> defaultMenuItemName [

	^ 'Generate property getter'
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterCommand >> description [

	^ 'Generate the actual code for the property getter based on method selector and comments'
]

{ #category : #execution }
CpGenerateMethodPropertyGetterCommand >> execute [

	methods do: [ :each | 
		self generatePropertyGetterFor: each ]
]

{ #category : #execution }
CpGenerateMethodPropertyGetterCommand >> generatePropertyGetterFor: aCompiledMethod [

	aCompiledMethod numArgs = 0
		ifFalse: [ ^ self ].

	aCompiledMethod methodClass
		generatePropertyGetterFor: aCompiledMethod
]
