Class {
	#name : #SlOption,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'instance creation' }
SlOption class >> value: aSymbol label: aStringOrElement [

	^ self new
		value: aSymbol ;
		label: aStringOrElement ;
		yourself
]

{ #category : #'instance creation' }
SlOption class >> value: aSymbol labelText: aString [

	^ self new
		value: aSymbol ;
		labelText: aString ;
		yourself
]

{ #category : #accessing }
SlOption >> beDisabled [

	self disabled: true
]

{ #category : #accessing }
SlOption >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing style' }
SlOption >> beNotDisabled [

	self disabled: false
]

{ #category : #accessing }
SlOption >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #copying }
SlOption >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		value: self value ;
		yourself

]

{ #category : #accessing }
SlOption >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlOption >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #accessing }
SlOption >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlOption >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlOption >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlOption >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlOption >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : #accessing }
SlOption >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : #accessing }
SlOption >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlOption >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlOption >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlOption >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlOption >> value [

	self flag: #TODO. "Temporary fix for values with spaces in them (replace by non-breakable space)."

	^ (self propertyAt: #value) replaceAll: (Character value: 160) with: Character space
]

{ #category : #accessing }
SlOption >> value: aString [

	self flag: #TODO. "Temporary fix for values with spaces in them (replace by non-breakable space)."

	self propertyAt: #value put: (aString asString replaceAll: Character space with: (Character value: 160))
]
