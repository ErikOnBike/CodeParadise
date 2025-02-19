Class {
	#name : #SlAbstractPrompter,
	#superclass : #SlElement,
	#instVars : [
		'modal',
		'defaultFocusElement'
	],
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #tags }
SlAbstractPrompter class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #accessing }
SlAbstractPrompter class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself
]

{ #category : #accessing }
SlAbstractPrompter >> beHeader [

	"Convenience method"

	self noHeader: false
]

{ #category : #accessing }
SlAbstractPrompter >> beModal [

	self modal: true
]

{ #category : #accessing }
SlAbstractPrompter >> beNoHeader [

	self noHeader: true
]

{ #category : #accessing }
SlAbstractPrompter >> beNotHeader [

	"Convenience method"

	self noHeader: true
]

{ #category : #accessing }
SlAbstractPrompter >> beNotModal [

	self modal: false
]

{ #category : #accessing }
SlAbstractPrompter >> beNotNoHeader [

	self noHeader: false
]

{ #category : #accessing }
SlAbstractPrompter >> beNotOpen [

	self open: false

]

{ #category : #accessing }
SlAbstractPrompter >> beOpen [

	self open: true

]

{ #category : #'accessing - convenience' }
SlAbstractPrompter >> close [

	"Convenience method to hide and destroy the receiver"

	self
		hide ;
		destroy
]

{ #category : #accessing }
SlAbstractPrompter >> content [

	"Answer the content HTML element of the receiver.
	For a simple String value use #contentText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlAbstractPrompter >> content: aStringOrElement [

	"Set the content to the specified Element.
	For a simple String value use #contentText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlAbstractPrompter >> contentText [

	"Answer the content text (a String) of the receiver.
	For richer HTML element use #content instead."

	^ self textContent
]

{ #category : #accessing }
SlAbstractPrompter >> contentText: aString [

	"Set the content text to the specified String value.
	For richer HTML element use #content: instead."

	self textContent: aString
]

{ #category : #accessing }
SlAbstractPrompter >> defaultFocusElement [

	^ defaultFocusElement
]

{ #category : #accessing }
SlAbstractPrompter >> defaultFocusElement: anElement [

	defaultFocusElement := anElement
]

{ #category : #accessing }
SlAbstractPrompter >> footer [

	"Answer the footer HTML element of the receiver.
	For a simple String value use #footerText instead."

	^ self firstChildAtSlotNamed: #footer
]

{ #category : #accessing }
SlAbstractPrompter >> footer: aStringOrElement [

	"Set the footer to the specified Element.
	For a simple String value use #footerText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #footer
]

{ #category : #accessing }
SlAbstractPrompter >> footerText [

	"Answer the footer text (a String) of the receiver.
	For richer HTML element use #footer instead."

	^ self footer
		ifNotNil: [ :footer | footer textContent ]
		ifNil: [ '' ]
]

{ #category : #accessing }
SlAbstractPrompter >> footerText: aString [

	"Set the footer text to the specified String value.
	For richer HTML element use #footer: instead."

	self footer: aString asHtmlElement
]

{ #category : #testing }
SlAbstractPrompter >> hasDefaultFocusElement [

	^ defaultFocusElement isNotNil
]

{ #category : #actions }
SlAbstractPrompter >> hide [

	self apply: #hide withArguments: #() 
]

{ #category : #initialization }
SlAbstractPrompter >> initialize [

	super initialize.

	modal := false.

	self
		when: SlRequestCloseEvent send: #onModalRequestClose: to: self ;
		when: SlInitialFocusEvent send: #onInitialFocus: to: self
]

{ #category : #testing }
SlAbstractPrompter >> isHeader [

	"Convenience method"

	^ self isNoHeader not
]

{ #category : #testing }
SlAbstractPrompter >> isModal [

	^ modal
]

{ #category : #testing }
SlAbstractPrompter >> isNoHeader [

	^ self propertyAt: #noHeader
]

{ #category : #testing }
SlAbstractPrompter >> isOpen [

	^ self propertyAt: #open

]

{ #category : #accessing }
SlAbstractPrompter >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
SlAbstractPrompter >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #label
]

{ #category : #accessing }
SlAbstractPrompter >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #content instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ '' ]
]

{ #category : #accessing }
SlAbstractPrompter >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #content: instead."

	self label: aString asHtmlElement
]

{ #category : #accessing }
SlAbstractPrompter >> modal: aBoolean [

	modal := aBoolean

]

{ #category : #accessing }
SlAbstractPrompter >> noHeader: aBoolean [

	self propertyAt: #noHeader put: aBoolean
]

{ #category : #'event handling' }
SlAbstractPrompter >> onInitialFocus: anInitialFocusEvent [

	self hasDefaultFocusElement
		ifFalse: [ ^ self ].

	anInitialFocusEvent preventDefault.
	self defaultFocusElement focus

]

{ #category : #'event handling' }
SlAbstractPrompter >> onModalRequestClose: aRequestCloseEvent [

	"Prevent the receiver from being closed if opened modal"

	modal
		ifTrue: [ aRequestCloseEvent preventDefault ]
]

{ #category : #accessing }
SlAbstractPrompter >> open: aBoolean [

	self propertyAt: #open put: aBoolean

]

{ #category : #accessing }
SlAbstractPrompter >> resetDefaultFocusElement [

	defaultFocusElement := nil
]

{ #category : #actions }
SlAbstractPrompter >> show [

	self apply: #show withArguments: #()

]

{ #category : #actions }
SlAbstractPrompter >> showFocusing: anElement [

	"Show the receiver and set focus on the specified Element"

	self
		defaultFocusElement: anElement ;
		show
]

{ #category : #actions }
SlAbstractPrompter >> showModal [

	"Show the receiver in modal mode"

	self
		beNoHeader ;
		beModal ;
		show

]

{ #category : #actions }
SlAbstractPrompter >> showModalFocusing: anElement [

	"Show the receiver modally and set focus on the specified Element"

	self
		defaultFocusElement: anElement ;
		showModal
]

{ #category : #actions }
SlAbstractPrompter >> showNonModal [

	"Show the receiver in non modal mode"

	self
		beHeader ;
		beNotModal ;
		show

]
