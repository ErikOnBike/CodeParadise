Class {
	#name : #SlMenuItem,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'instance creation' }
SlMenuItem class >> value: aSymbol label: aStringOrElement [

	^ self new
		value: aSymbol ;
		label: aStringOrElement ;
		yourself
]

{ #category : #'instance creation' }
SlMenuItem class >> value: aSymbol labelText: aString [

	^ self new
		value: aSymbol ;
		labelText: aString ;
		yourself
]

{ #category : #accessing }
SlMenuItem >> beChecked [

	self checked: true
]

{ #category : #accessing }
SlMenuItem >> beDisabled [

	self disabled: true
]

{ #category : #accessing }
SlMenuItem >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #accessing }
SlMenuItem >> beNotChecked [

	self checked: false
]

{ #category : #'accessing style' }
SlMenuItem >> beNotDisabled [

	self disabled: false
]

{ #category : #accessing }
SlMenuItem >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #accessing }
SlMenuItem >> checked: aBoolean [

	self propertyAt: #checked put: aBoolean
]

{ #category : #copying }
SlMenuItem >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		value: self value ;
		yourself

]

{ #category : #accessing }
SlMenuItem >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlMenuItem >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #'text input' }
SlMenuItem >> focus [

	"Set focus to the receiver.

	Implementation:
	Since Shoelace uses tabindex attributes to indicate the currently
	selected item for tabbing/cursor movement, update all sibligs to
	properly indicate the receiver has focus/is active."

	| menu |

	super focus.

	menu := self firstAncestorMatching: SlMenu asCssSelector.
	(menu allDescendantsMatching: self class asCssSelector) do: [ :each |
		each attributeAt: #tabindex put: (each == self
			ifTrue: [ '0' ]
			ifFalse: [ '-1' ]) ]
]

{ #category : #accessing }
SlMenuItem >> isChecked [

	^ self propertyAt: #checked
]

{ #category : #accessing }
SlMenuItem >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlMenuItem >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlMenuItem >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlMenuItem >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlMenuItem >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlMenuItem >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : #accessing }
SlMenuItem >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlMenuItem >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlMenuItem >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlMenuItem >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlMenuItem >> value [

	^ self propertyAt: #value
]

{ #category : #accessing }
SlMenuItem >> value: aString [

	self propertyAt: #value put: aString asString
]
