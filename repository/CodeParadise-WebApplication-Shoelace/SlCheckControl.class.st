Class {
	#name : #SlCheckControl,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #testing }
SlCheckControl class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'accessing style' }
SlCheckControl >> beChecked [

	self checked: true
]

{ #category : #'accessing style' }
SlCheckControl >> beNotChecked [

	self checked: false
]

{ #category : #accessing }
SlCheckControl >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
SlCheckControl >> click [

	"Simulate a click on the checkbox"

	self apply: #click withArguments: #()
]

{ #category : #testing }
SlCheckControl >> isChecked [

	^ self propertyAt: #checked
]

{ #category : #accessing }
SlCheckControl >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlCheckControl >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlCheckControl >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlCheckControl >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]
