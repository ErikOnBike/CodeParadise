Class {
	#name : #SlRadioButton,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlRadioButton >> beChecked [

	self checked: true
]

{ #category : #'accessing size' }
SlRadioButton >> beLarge [

	self size: #large
]

{ #category : #'accessing size' }
SlRadioButton >> beMedium [

	self size: #medium
]

{ #category : #'accessing style' }
SlRadioButton >> beNotChecked [

	self checked: false
]

{ #category : #'accessing style' }
SlRadioButton >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlRadioButton >> bePill [

	self pill: true
]

{ #category : #'accessing size' }
SlRadioButton >> beSmall [

	self size: #small
]

{ #category : #accessing }
SlRadioButton >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
SlRadioButton >> click [

	"Simulate a click on the checkbox"

	self apply: #click withArguments: #()
]

{ #category : #testing }
SlRadioButton >> hasFocus [

	^ self = CpHtmlElement activeElement
]

{ #category : #initialization }
SlRadioButton >> initialize [

	super initialize.

	self when: CpPrimaryClickEvent send: #onPrivateClick: to: self
]

{ #category : #testing }
SlRadioButton >> isChecked [

	^ self propertyAt: #checked
]

{ #category : #testing }
SlRadioButton >> isPill [

	^ self propertyAt: #pill
]

{ #category : #accessing }
SlRadioButton >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlRadioButton >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlRadioButton >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlRadioButton >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : #'private - event handling' }
SlRadioButton >> onPrivateClick: aClickEvent [

	"The receiver has generated a click event (as oppposed to having actually
	been clicked by a pointer device). Emulate regular click event."

	"Implementation: a Click event is not a pointer event, but the protocol matches enough"
	aClickEvent isNoButtonPressed
		ifTrue: [ self announce: ((CpPrimaryClickEvent newFromMouseEvent: aClickEvent) ifNil: [ ^ self ]) ]
]

{ #category : #accessing }
SlRadioButton >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlRadioButton >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlRadioButton >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlRadioButton >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlRadioButton >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlRadioButton >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlRadioButton >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]
