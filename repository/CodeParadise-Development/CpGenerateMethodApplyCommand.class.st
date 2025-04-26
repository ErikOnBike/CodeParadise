Class {
	#name : #CpGenerateMethodApplyCommand,
	#superclass : #SycMethodCommand,
	#category : #'CodeParadise-Development-Commands'
}

{ #category : #activation }
CpGenerateMethodApplyCommand class >> methodContextMenuActivation [

	<classAnnotation>
	
	^ CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyMethod asCalypsoItemContext
]

{ #category : #accessing }
CpGenerateMethodApplyCommand >> defaultMenuIconName [

	^ #classVarsSelected
]

{ #category : #accessing }
CpGenerateMethodApplyCommand >> defaultMenuItemName [

	^ 'Generate apply method'
]

{ #category : #accessing }
CpGenerateMethodApplyCommand >> description [

	^ 'Generate the actual code for the apply method based on method selector and comments'
]

{ #category : #execution }
CpGenerateMethodApplyCommand >> execute [

	methods do: [ :each | 
		self generateApplyFor: each ]
]

{ #category : #'as yet unclassified' }
CpGenerateMethodApplyCommand >> generateApplyFor: aCompiledMethod [

	aCompiledMethod methodClass
		generateApplyFor: aCompiledMethod
]
