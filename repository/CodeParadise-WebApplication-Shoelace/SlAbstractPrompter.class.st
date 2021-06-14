Class {
	#name : #SlAbstractPrompter,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlAbstractPrompter >> beHeader [

	self removeAttributeAt: #'no-header'
]

{ #category : #accessing }
SlAbstractPrompter >> beNoHeader [

	self attributeAt: #'no-header' put: 'on'
]

{ #category : #accessing }
SlAbstractPrompter >> hide [ 
	"Show the element"

	self apply: #hide withArguments: #() 
]

{ #category : #accessing }
SlAbstractPrompter >> isOpen [

	^self attributeAt: #open
]

{ #category : #accessing }
SlAbstractPrompter >> label: aString [

	self attributeAt: #label put: aString
]

{ #category : #accessing }
SlAbstractPrompter >> open: aBoolean [
	"Show the element"

	self attributeAt: #open put: aBoolean 
	

]

{ #category : #'ui dialogs' }
SlAbstractPrompter >> preventOverlayDismiss [
	"Add an event handle to cancel the dismiss overlay dismiss event"
	
	CpClientEnvironment current
		globalApply: '_cpslPreventEventDefault'
		withArguments: {self. 'sl-overlay-dismiss'}
]

{ #category : #accessing }
SlAbstractPrompter >> show [ 
	"Show the element"

	self apply: #show withArguments: #()

]

{ #category : #accessing }
SlAbstractPrompter >> showFocusing: anElement [
	"Show the receiver and set focus on @anElement"

	CpClientEnvironment current
		globalApply: '_cpslShowSettingFocusOn'
		withArguments: {self. anElement}.

]

{ #category : #'ui dialogs' }
SlAbstractPrompter >> showModally [
	"Make the dialog open modally"

	self
		preventOverlayDismiss;
		show
]

{ #category : #'ui dialogs' }
SlAbstractPrompter >> showModallyFocusing: anElement [
	"Show the receiver modally and set focus on @anElement. NOTE: event ordering is very finicky here, hence this specialised method. Any browser devTools can also affect focusing"

	self
		beNoHeader;	
		preventOverlayDismiss;
		showFocusing: anElement
]
