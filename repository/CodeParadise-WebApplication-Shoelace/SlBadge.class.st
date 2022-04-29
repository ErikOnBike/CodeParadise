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

{ #category : #'accessing variant' }
SlBadge >> beDanger [

	self variant: #danger
]

{ #category : #'accessing variant' }
SlBadge >> beDefault [

	self variant: #default
]

{ #category : #'accessing variant' }
SlBadge >> beNeutral [

	self variant: #neutral
]

{ #category : #'accessing style' }
SlBadge >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlBadge >> beNotPulse [

	self pulse: false
]

{ #category : #'accessing style' }
SlBadge >> bePill [

	self pill: true
]

{ #category : #'accessing variant' }
SlBadge >> bePrimary [

	self variant: #primary
]

{ #category : #'accessing style' }
SlBadge >> bePulse [

	self pulse: true
]

{ #category : #'accessing variant' }
SlBadge >> beSuccess [

	self variant: #success
]

{ #category : #'accessing variant' }
SlBadge >> beWarning [

	self variant: #warning
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

{ #category : #testing }
SlBadge >> isPulse [

	^ self propertyAt: #pulse
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

	"Optimize for simple badge label with <span> only"
	self label ifNotNil: [ :label |
		label tagName = #span
			ifTrue: [
				label textContent: aString.
				^ self ] ].

	self label: aString asHtmlElement
]

{ #category : #accessing }
SlBadge >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlBadge >> pulse: aBoolean [

	self propertyAt: #pulse put: aBoolean
]

{ #category : #accessing }
SlBadge >> variant [

	^ self propertyAt: #variant
]

{ #category : #accessing }
SlBadge >> variant: aString [

	self propertyAt: #variant put: aString
]
