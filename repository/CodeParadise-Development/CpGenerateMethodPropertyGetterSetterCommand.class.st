Class {
	#name : #CpGenerateMethodPropertyGetterSetterCommand,
	#superclass : #SycMethodCommand,
	#category : #'CodeParadise-Development-Commands'
}

{ #category : #activation }
CpGenerateMethodPropertyGetterSetterCommand class >> methodContextMenuActivation [

	<classAnnotation>
	
	^ CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyMethod asCalypsoItemContext
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterSetterCommand >> defaultMenuIconName [

	^ #classVarsSelected
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterSetterCommand >> defaultMenuItemName [

	^ 'Generate property getter and setter'
]

{ #category : #accessing }
CpGenerateMethodPropertyGetterSetterCommand >> description [

	^ 'Generate the actual code for the property getter and setter based on method selector and comments'
]

{ #category : #execution }
CpGenerateMethodPropertyGetterSetterCommand >> execute [

	methods do: [ :each | 
		self generatePropertyGetterSetterFor: each ]
]

{ #category : #execution }
CpGenerateMethodPropertyGetterSetterCommand >> generatePropertyGetterSetterFor: aCompiledMethod [

	aCompiledMethod numArgs > 1
		ifTrue: [ ^ self ].

	aCompiledMethod methodClass
		generatePropertyGetterFor: aCompiledMethod.
	aCompiledMethod methodClass
		generatePropertySetterFor: aCompiledMethod
]
