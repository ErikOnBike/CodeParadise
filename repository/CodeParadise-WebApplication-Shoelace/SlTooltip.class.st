Class {
	#name : #SlTooltip,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlTooltip >> beDisabled [

	self disabled: true
]

{ #category : #'accessing style' }
SlTooltip >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing style' }
SlTooltip >> beHoist [

	self hoist: true
]

{ #category : #'accessing style' }
SlTooltip >> beNotDisabled [

	self disabled: false
]

{ #category : #'accessing style' }
SlTooltip >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #'accessing style' }
SlTooltip >> beNotHoist [

	self hoist: false
]

{ #category : #'accessing style' }
SlTooltip >> beNotOpen [

	self open: false
]

{ #category : #'accessing style' }
SlTooltip >> beOpen [

	self open: true
]

{ #category : #'accessing placement' }
SlTooltip >> bottom [

	self placement: #bottom
]

{ #category : #'accessing placement' }
SlTooltip >> bottomEnd [

	self placement: #'bottom-end'
]

{ #category : #'accessing placement' }
SlTooltip >> bottomStart [

	self placement: #'bottom-start'
]

{ #category : #accessing }
SlTooltip >> content [

	^ self firstChildAtSlotNamed: #content
]

{ #category : #accessing }
SlTooltip >> content: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #content
]

{ #category : #accessing }
SlTooltip >> contentText [

	"Answer the content text (a String) of the receiver.
	For richer HTML element use #content instead."

	^ self content textContent
]

{ #category : #accessing }
SlTooltip >> contentText: aString [

	"Set the content text to the specified String value.
	For richer HTML element use #content: instead."

	self content: aString asHtmlElement
]

{ #category : #accessing }
SlTooltip >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlTooltip >> distance [

	^ self propertyAt: #distance
]

{ #category : #accessing }
SlTooltip >> distance: aNumber [

	self propertyAt: #distance put: aNumber
]

{ #category : #accessing }
SlTooltip >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #actions }
SlTooltip >> hide [

	self apply: #hide withArguments: #()
]

{ #category : #accessing }
SlTooltip >> hoist: aBoolean [

	self propertyAt: #hoist put: aBoolean
]

{ #category : #testing }
SlTooltip >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #testing }
SlTooltip >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #testing }
SlTooltip >> isHoist [

	^ self propertyAt: #hoist
]

{ #category : #testing }
SlTooltip >> isOpen [

	^ self propertyAt: #open
]

{ #category : #'accessing placement' }
SlTooltip >> left [

	self placement: #left
]

{ #category : #'accessing placement' }
SlTooltip >> leftEnd [

	self placement: #'left-end'
]

{ #category : #'accessing placement' }
SlTooltip >> leftStart [

	self placement: #'left-start'
]

{ #category : #accessing }
SlTooltip >> open: aBoolean [

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
SlTooltip >> placement [

	^ self propertyAt: #placement
]

{ #category : #accessing }
SlTooltip >> placement: aString [

	self propertyAt: #placement put: aString
]

{ #category : #'accessing placement' }
SlTooltip >> right [

	self placement: #right
]

{ #category : #'accessing placement' }
SlTooltip >> rightEnd [

	self placement: #'right-end'
]

{ #category : #'accessing placement' }
SlTooltip >> rightStart [

	self placement: #'right-start'
]

{ #category : #actions }
SlTooltip >> show [

	self apply: #show withArguments: #()
]

{ #category : #accessing }
SlTooltip >> skidding [

	^ self propertyAt: #skidding
]

{ #category : #accessing }
SlTooltip >> skidding: aNumber [

	self propertyAt: #skidding put: aNumber
]

{ #category : #'accessing placement' }
SlTooltip >> top [

	self placement: #top
]

{ #category : #'accessing placement' }
SlTooltip >> topEnd [

	self placement: #'top-end'
]

{ #category : #'accessing placement' }
SlTooltip >> topStart [

	self placement: #'top-start'
]

{ #category : #accessing }
SlTooltip >> trigger [

	^ self propertyAt: #trigger
]

{ #category : #accessing }
SlTooltip >> trigger: aString [

	self propertyAt: #trigger put: aString
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerClick [

	self trigger: #click
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerFocus [

	self trigger: #focus
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerHover [

	self trigger: #hover
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerHoverAndFocus [

	self trigger: 'hover focus'
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerManual [

	self trigger: #manual
]
