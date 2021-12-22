Class {
	#name : #SlBadge,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlBadge class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself
]

{ #category : #'accessing type' }
SlBadge >> beDanger [

	self type: #danger
]

{ #category : #'accessing type' }
SlBadge >> beDefault [

	self type: #default
]

{ #category : #'accessing size' }
SlBadge >> beLarge [

	self size: #large
]

{ #category : #'accessing size' }
SlBadge >> beMedium [

	self size: #medium
]

{ #category : #'accessing type' }
SlBadge >> beNeutral [

	self type: #neutral
]

{ #category : #'accessing style' }
SlBadge >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlBadge >> bePill [

	self pill: true
]

{ #category : #'accessing type' }
SlBadge >> bePrimary [

	self type: #primary
]

{ #category : #'accessing size' }
SlBadge >> beSmall [

	self size: #small
]

{ #category : #'accessing type' }
SlBadge >> beSuccess [

	self type: #success
]

{ #category : #'accessing type' }
SlBadge >> beWarning [

	self type: #warning
]

{ #category : #accessing }
SlBadge >> content: anElement [

	"Set the content of the receiver to the specified element.
	Any existing content is removed."

	self replaceAllChildrenWith: anElement asHtmlElement
]

{ #category : #testing }
SlBadge >> isPill [

	^ self propertyAt: #pill
]

{ #category : #accessing }
SlBadge >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #helpLabel instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : #accessing }
SlBadge >> label: anElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: anElement asHtmlElement atSlotNamed: nil
]

{ #category : #accessing }
SlBadge >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self label
		ifNotNil: [ :label | label textContent ]
		ifNil: [ self textContent ]
]

{ #category : #accessing }
SlBadge >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self label: aString asHtmlElement
]

{ #category : #accessing }
SlBadge >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlBadge >> size [

	^ self propertyAt: #size
]

{ #category : #accessing }
SlBadge >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : #accessing }
SlBadge >> type [

	^ self propertyAt: #type
]

{ #category : #accessing }
SlBadge >> type: aString [

	self propertyAt: #type put: aString
]
