Class {
	#name : #SlTag,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing variant' }
SlTag >> beDanger [

	self variant: #danger
]

{ #category : #'accessing size' }
SlTag >> beLarge [

	self size: #large
]

{ #category : #'accessing size' }
SlTag >> beMedium [

	self size: #medium
]

{ #category : #'accessing variant' }
SlTag >> beNeutral [

	self variant: #neutral
]

{ #category : #'accessing variant' }
SlTag >> beNotPill [

	self pill: false
]

{ #category : #'accessing variant' }
SlTag >> beNotRemovable [

	self removable: false
]

{ #category : #'accessing variant' }
SlTag >> bePill [

	self pill: true
]

{ #category : #'accessing variant' }
SlTag >> bePrimary [

	self variant: #primary
]

{ #category : #'accessing variant' }
SlTag >> beRemovable [

	self removable: true
]

{ #category : #'accessing size' }
SlTag >> beSmall [

	self size: #small
]

{ #category : #'accessing variant' }
SlTag >> beSuccess [

	self variant: #success
]

{ #category : #'accessing variant' }
SlTag >> beText [

	self variant: #text
]

{ #category : #'accessing variant' }
SlTag >> beWarning [

	self variant: #warning
]

{ #category : #copying }
SlTag >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		removable: self isRemovable ;
		yourself

]

{ #category : #accessing }
SlTag >> content [

	"Answer the content HTML element of the receiver.
	For a simple String value use #contentText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlTag >> content: anElement [

	"Set the content to the specified Element.
	For a simple String value use #contentText: instead."

	self replaceAllChildrenWith: anElement atSlotNamed: nil
]

{ #category : #accessing }
SlTag >> contentText [

	"Answer the content text (a String) of the receiver.
	For richer HTML element use #content instead."

	^ self textContent
]

{ #category : #accessing }
SlTag >> contentText: aString [

	"Set the content text to the specified String value.
	For richer HTML element use #content: instead."

	self textContent: aString
]

{ #category : #testing }
SlTag >> isPill [

	^ self propertyAt: #pill
]

{ #category : #testing }
SlTag >> isRemovable [

	^ self propertyAt: #removable
]

{ #category : #accessing }
SlTag >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlTag >> removable: aBoolean [

	self propertyAt: #removable put: aBoolean
]

{ #category : #accessing }
SlTag >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlTag >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlTag >> variant [

	^ self propertyAt: #variant
]

{ #category : #accessing }
SlTag >> variant: aString [

	self propertyAt: #variant put: aString
]
