Class {
	#name : #CpRemoveMethodNoQuestionsCommand,
	#superclass : #SycMethodCommand,
	#category : #'CodeParadise-Development-Commands'
}

{ #category : #activation }
CpRemoveMethodNoQuestionsCommand class >> methodMenuActivation [
	<classAnnotation>

	^ CmdContextMenuActivation byRootGroupItemOrder: 10001 for: ClyMethod asCalypsoItemContext
]

{ #category : #activation }
CpRemoveMethodNoQuestionsCommand class >> methodShortcutActivation [
	<classAnnotation>

	^ (CmdShortcutActivation removalFor: ClyMethod asCalypsoItemContext) ifNotNil: [ :shortcut |
		shortcut keyCombination modifier: shortcut keyCombination modifier + KMModifier shift.
		shortcut ]
]

{ #category : #accessing }
CpRemoveMethodNoQuestionsCommand >> defaultMenuIconName [

	^ #remove
]

{ #category : #accessing }
CpRemoveMethodNoQuestionsCommand >> defaultMenuItemName [

	^ '(R) Remove - No refactoring'
]

{ #category : #execution }
CpRemoveMethodNoQuestionsCommand >> execute [
	
	methods do: [ :each | each removeFromSystem ].

	self inform: 'Removed ', methods size printString, ' methods'
]

{ #category : #execution }
CpRemoveMethodNoQuestionsCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.

	(self confirm: 'Are you sure you want to remove ', methods size printString, ' method(s)?', String cr, (String cr join: (methods collect: [ :each | each selector printString ])))
		ifFalse: [ CmdCommandAborted signal ]
]
