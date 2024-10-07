Class {
	#name : #SlMenuLabel,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlMenuLabel >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlMenuLabel >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlMenuLabel >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlMenuLabel >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]
