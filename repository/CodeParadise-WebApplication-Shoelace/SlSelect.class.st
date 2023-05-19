Class {
	#name : #SlSelect,
	#superclass : #SlFormControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlSelect >> beClearable [

	self clearable: true
]

{ #category : #accessing }
SlSelect >> beFilled [

	self filled: true
]

{ #category : #accessing }
SlSelect >> beHoist [

	self hoist: true
]

{ #category : #accessing }
SlSelect >> beLarge [

	self size: #large
]

{ #category : #accessing }
SlSelect >> beMedium [

	self size: #medium
]

{ #category : #accessing }
SlSelect >> beMultiple [

	self multiple: true
]

{ #category : #accessing }
SlSelect >> beNotClearable [

	self clearable: false
]

{ #category : #accessing }
SlSelect >> beNotFilled [

	self filled: false
]

{ #category : #accessing }
SlSelect >> beNotHoist [

	self hoist: false
]

{ #category : #accessing }
SlSelect >> beNotMultiple [

	self multiple: false
]

{ #category : #accessing }
SlSelect >> beNotPill [

	self pill: false
]

{ #category : #accessing }
SlSelect >> bePill [

	self pill: true
]

{ #category : #accessing }
SlSelect >> beSmall [

	self size: #small
]

{ #category : #accessing }
SlSelect >> clearIcon [

	self firstChildAtSlotNamed: #'clear-icon'
]

{ #category : #accessing }
SlSelect >> clearIcon: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #'clear-icon'
]

{ #category : #accessing }
SlSelect >> clearable: aBoolean [

	self propertyAt: #clearable put: aBoolean
]

{ #category : #accessing }
SlSelect >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		size: self size ;
		placeholder: self placeholder ;
		clearable: self isClearable ;
		yourself

]

{ #category : #accessing }
SlSelect >> filled: aBoolean [

	self propertyAt: #filled put: aBoolean
]

{ #category : #testing }
SlSelect >> hasFocus [

	"Answer whether the receiver or one of its options has focus"

	^ super hasFocus or: [ self = CpHtmlElement activeElement parent ]
]

{ #category : #accessing }
SlSelect >> help [

	"Answer the help HTML element of the receiver.
	For a simple String value use #helpText instead."

	^ self firstChildAtSlotNamed: #'help-text'
]

{ #category : #accessing }
SlSelect >> help: aStringOrElement [

	"Set the help text to the specified Element.
	For a simple String value use #helpText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #'help-text'
]

{ #category : #accessing }
SlSelect >> helpText [

	"Answer the help text (a String) of the receiver.
	For richer HTML element use #help instead."

	^ self help textContent
]

{ #category : #accessing }
SlSelect >> helpText: aString [

	"Set the help text to the specified String value.
	For richer HTML element use #help: instead."

	self help: aString asHtmlElement
]

{ #category : #accessing }
SlSelect >> hoist: aBoolean [

	self propertyAt: #hoist put: aBoolean
]

{ #category : #accessing }
SlSelect >> isClearable [

	^ self propertyAt: #clearable
]

{ #category : #accessing }
SlSelect >> isFilled [

	^ self propertyAt: #filled
]

{ #category : #accessing }
SlSelect >> isHoist [

	^ self propertyAt: #hoist
]

{ #category : #accessing }
SlSelect >> isMultiple [

	^ self propertyAt: #multiple
]

{ #category : #accessing }
SlSelect >> isPill [

	^ self propertyAt: #pill
]

{ #category : #accessing }
SlSelect >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #accessing }
SlSelect >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: #label
]

{ #category : #accessing }
SlSelect >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ '' ]
]

{ #category : #accessing }
SlSelect >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self label: aString asHtmlElement
]

{ #category : #accessing }
SlSelect >> maxTagsVisible [

	^ self propertyAt: #maxTagsVisible
]

{ #category : #accessing }
SlSelect >> maxTagsVisible: aNumber [

	self propertyAt: #maxTagsVisible put: aNumber
]

{ #category : #accessing }
SlSelect >> multiple: aBoolean [

	self propertyAt: #multiple put: aBoolean
]

{ #category : #accessing }
SlSelect >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlSelect >> placeholder [

	^ self propertyAt: #placeholder
]

{ #category : #accessing }
SlSelect >> placeholder: aString [

	self propertyAt: #placeholder put: aString
]

{ #category : #accessing }
SlSelect >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlSelect >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlSelect >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlSelect >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlSelect >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlSelect >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlSelect >> value [

	self flag: #TODO. "Temporary fix for values with spaces in them (replace by non-breakable space)."

	^ super value replaceAll: (Character value: 160) with: Character space
]

{ #category : #accessing }
SlSelect >> value: aString [

	self flag: #TODO. "Temporary fix for values with spaces in them (replace by non-breakable space)."

	^ super value: (aString asString replaceAll: Character space with: (Character value: 160))
]
