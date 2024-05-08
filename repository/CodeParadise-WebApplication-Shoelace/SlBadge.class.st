Class {
	#name : 'SlBadge',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing' }
SlBadge class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself
]

{ #category : 'accessing variant' }
SlBadge >> beDanger [

	self variant: #danger
]

{ #category : 'accessing variant' }
SlBadge >> beDefault [

	self variant: #default
]

{ #category : 'accessing variant' }
SlBadge >> beNeutral [

	self variant: #neutral
]

{ #category : 'accessing style' }
SlBadge >> beNotPill [

	self pill: false
]

{ #category : 'accessing style' }
SlBadge >> beNotPulse [

	self pulse: false
]

{ #category : 'accessing style' }
SlBadge >> bePill [

	self pill: true
]

{ #category : 'accessing variant' }
SlBadge >> bePrimary [

	self variant: #primary
]

{ #category : 'accessing style' }
SlBadge >> bePulse [

	self pulse: true
]

{ #category : 'accessing variant' }
SlBadge >> beSuccess [

	self variant: #success
]

{ #category : 'accessing variant' }
SlBadge >> beWarning [

	self variant: #warning
]

{ #category : 'testing' }
SlBadge >> isPill [

	^ self propertyAt: #pill
]

{ #category : 'testing' }
SlBadge >> isPulse [

	^ self propertyAt: #pulse
]

{ #category : 'accessing' }
SlBadge >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : 'accessing' }
SlBadge >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : 'accessing' }
SlBadge >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : 'accessing' }
SlBadge >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : 'accessing' }
SlBadge >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : 'accessing' }
SlBadge >> pulse: aBoolean [

	self propertyAt: #pulse put: aBoolean
]

{ #category : 'accessing' }
SlBadge >> variant [

	^ self propertyAt: #variant
]

{ #category : 'accessing' }
SlBadge >> variant: aString [

	self propertyAt: #variant put: aString
]
