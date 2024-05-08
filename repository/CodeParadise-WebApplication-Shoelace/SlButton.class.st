Class {
	#name : 'SlButton',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing' }
SlButton class >> label: aStringOrElement [

	^ self new
		label: aStringOrElement ;
		yourself
]

{ #category : 'accessing' }
SlButton class >> label: aStringOrElement suffix: suffixElement [

	^ self new
		label: aStringOrElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : 'accessing' }
SlButton class >> prefix: anElement label: aStringOrElement [

	^ self new
		prefix: anElement ;
		label: aStringOrElement ;
		yourself
]

{ #category : 'accessing' }
SlButton class >> prefix: prefixElement label: aStringOrElement suffix: suffixElement [

	^ self new
		prefix: prefixElement ;
		label: aStringOrElement ;
		suffix: suffixElement ;
		yourself
]

{ #category : 'accessing style' }
SlButton >> beCircle [

	self circle: true
]

{ #category : 'accessing variant' }
SlButton >> beDanger [

	self variant: #danger
]

{ #category : 'accessing variant' }
SlButton >> beDefault [

	self variant: #default
]

{ #category : 'accessing style' }
SlButton >> beDisabled [

	self disabled: true
]

{ #category : 'accessing style' }
SlButton >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : 'accessing variant' }
SlButton >> beInfo [

	self variant: #info
]

{ #category : 'accessing size' }
SlButton >> beLarge [

	self size: #large
]

{ #category : 'accessing style' }
SlButton >> beLoading [

	self loading: true
]

{ #category : 'accessing size' }
SlButton >> beMedium [

	self size: #medium
]

{ #category : 'accessing variant' }
SlButton >> beNeutral [

	self variant: #neutral
]

{ #category : 'accessing style' }
SlButton >> beNotCircle [

	self circle: false
]

{ #category : 'accessing style' }
SlButton >> beNotDisabled [

	self disabled: false
]

{ #category : 'accessing style' }
SlButton >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : 'accessing style' }
SlButton >> beNotLoading [

	self loading: false
]

{ #category : 'accessing style' }
SlButton >> beNotOutline [

	self outline: false
]

{ #category : 'accessing style' }
SlButton >> beNotPill [

	self pill: false
]

{ #category : 'accessing style' }
SlButton >> beOutline [

	self outline: true
]

{ #category : 'accessing style' }
SlButton >> bePill [

	self pill: true
]

{ #category : 'accessing variant' }
SlButton >> bePrimary [

	self variant: #primary
]

{ #category : 'accessing size' }
SlButton >> beSmall [

	self size: #small
]

{ #category : 'accessing variant' }
SlButton >> beSuccess [

	self variant: #success
]

{ #category : 'accessing variant' }
SlButton >> beText [

	self variant: #text
]

{ #category : 'accessing variant' }
SlButton >> beWarning [

	self variant: #warning
]

{ #category : 'accessing' }
SlButton >> circle: aBoolean [

	self propertyAt: #circle put: aBoolean
]

{ #category : 'copying' }
SlButton >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		link: self link ;
		target: self target ;
		download: self download ;
		yourself

]

{ #category : 'accessing' }
SlButton >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : 'accessing' }
SlButton >> download [

	^ self propertyAt: #download
]

{ #category : 'accessing' }
SlButton >> download: aString [

	self propertyAt: #download put: aString
]

{ #category : 'accessing' }
SlButton >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : 'testing' }
SlButton >> hasFocus [

	^ self = CpHtmlElement activeElement
]

{ #category : 'testing' }
SlButton >> isCircle [

	^ self propertyAt: #circle
]

{ #category : 'testing' }
SlButton >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : 'testing' }
SlButton >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : 'testing' }
SlButton >> isLoading [

	^ self propertyAt: #loading
]

{ #category : 'testing' }
SlButton >> isOutline [

	^ self propertyAt: #outline
]

{ #category : 'testing' }
SlButton >> isPill [

	^ self propertyAt: #pill
]

{ #category : 'accessing' }
SlButton >> label [

	"Answer the label HTML element of the receiver.
	For a simple String value use #labelText instead."

	^ self firstChildAtSlotNamed: nil
]

{ #category : 'accessing' }
SlButton >> label: aStringOrElement [

	"Set the label to the specified Element.
	For a simple String value use #labelText: instead."

	self replaceAllChildrenWith: aStringOrElement asHtmlElement atSlotNamed: nil
]

{ #category : 'accessing' }
SlButton >> labelText [

	"Answer the label text (a String) of the receiver.
	For richer HTML element use #label instead."

	^ self textContent
]

{ #category : 'accessing' }
SlButton >> labelText: aString [

	"Set the label text to the specified String value.
	For richer HTML element use #label: instead."

	self textContent: aString
]

{ #category : 'accessing' }
SlButton >> link [

	^ self propertyAt: #href
]

{ #category : 'accessing' }
SlButton >> link: aString [

	self propertyAt: #href put: aString
]

{ #category : 'accessing' }
SlButton >> link: linkString download: downloadString [

	self
		link: linkString ;
		download: downloadString
]

{ #category : 'accessing' }
SlButton >> link: linkString target: targetString [

	self
		link: linkString ;
		target: targetString
]

{ #category : 'accessing' }
SlButton >> loading: aBoolean [

	self propertyAt: #loading put: aBoolean
]

{ #category : 'accessing' }
SlButton >> outline: aBoolean [

	self propertyAt: #outline put: aBoolean
]

{ #category : 'accessing' }
SlButton >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : 'accessing' }
SlButton >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : 'accessing' }
SlButton >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : 'accessing' }
SlButton >> size [

	^ self propertyAt: #size
]

{ #category : 'accessing' }
SlButton >> size: aString [

	self propertyAt: #size put: aString
]

{ #category : 'accessing' }
SlButton >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : 'accessing' }
SlButton >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : 'accessing' }
SlButton >> target [

	^ self propertyAt: #target
]

{ #category : 'accessing' }
SlButton >> target: aString [

	self propertyAt: #target put: aString
]

{ #category : 'accessing target' }
SlButton >> targetBlank [

	self target: #'_blank'
]

{ #category : 'accessing target' }
SlButton >> targetParent [

	self target: #'_parent'
]

{ #category : 'accessing target' }
SlButton >> targetSelf [

	self target: #'_self'
]

{ #category : 'accessing target' }
SlButton >> targetTop [

	self target: #'_top'
]

{ #category : 'accessing' }
SlButton >> variant [

	^ self propertyAt: #variant
]

{ #category : 'accessing' }
SlButton >> variant: aString [

	self propertyAt: #variant put: aString
]
