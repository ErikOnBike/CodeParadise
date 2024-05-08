Class {
	#name : 'SlDropdown',
	#superclass : 'SlElement',
	#category : 'CodeParadise-WebApplication-Shoelace-Elements',
	#package : 'CodeParadise-WebApplication-Shoelace',
	#tag : 'Elements'
}

{ #category : 'accessing style' }
SlDropdown >> beDisabled [

	self disabled: true
]

{ #category : 'accessing style' }
SlDropdown >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : 'accessing style' }
SlDropdown >> beHoist [

	self hoist: true
]

{ #category : 'accessing style' }
SlDropdown >> beOpen [

	self open: true
]

{ #category : 'accessing style' }
SlDropdown >> beStayOpenOnSelect [

	self stayOpenOnSelect: true
]

{ #category : 'copying' }
SlDropdown >> clone [

	"Deep clone the receiver.

	Implementation:
	Set the (non reflecting properties explicitly)."

	^ super clone
		disabled: self isDisabled ;
		distance: self distance ;
		skidding: self skidding ;
		hoist: self isHoist ;
		yourself

]

{ #category : 'accessing' }
SlDropdown >> containingElement [

	^ self propertyAt: #containingElement
]

{ #category : 'accessing' }
SlDropdown >> disabled: aBoolean [

	self propertyAt: #disabled put: aBoolean
]

{ #category : 'accessing' }
SlDropdown >> distance [

	^ self propertyAt: #distance
]

{ #category : 'accessing' }
SlDropdown >> distance: aNumber [

	self propertyAt: #distance put: aNumber
]

{ #category : 'accessing' }
SlDropdown >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : 'accessing' }
SlDropdown >> hoist: aBoolean [

	self propertyAt: #hoist put: aBoolean
]

{ #category : 'testing' }
SlDropdown >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : 'testing' }
SlDropdown >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : 'testing' }
SlDropdown >> isHoist [

	^ self propertyAt: #hoist
]

{ #category : 'testing' }
SlDropdown >> isOpen [

	^ self propertyAt: #open
]

{ #category : 'testing' }
SlDropdown >> isStayOpenOnSelect [

	^ self propertyAt: #stayOpenOnSelect
]

{ #category : 'accessing' }
SlDropdown >> open: aBoolean [

	self propertyAt: #open put: aBoolean
]

{ #category : 'accessing' }
SlDropdown >> placement [

	^ self propertyAt: #placement
]

{ #category : 'accessing' }
SlDropdown >> placement: aString [

	self propertyAt: #placement put: aString
]

{ #category : 'accessing placement' }
SlDropdown >> placementBottom [

	self placement: #bottom
]

{ #category : 'accessing placement' }
SlDropdown >> placementBottomEnd [

	self placement: #'bottom-end'
]

{ #category : 'accessing placement' }
SlDropdown >> placementBottomStart [

	self placement: #'bottom-start'
]

{ #category : 'accessing placement' }
SlDropdown >> placementLeft [

	self placement: #'left'
]

{ #category : 'accessing placement' }
SlDropdown >> placementLeftEnd [

	self placement: #'left-end'
]

{ #category : 'accessing placement' }
SlDropdown >> placementLeftStart [

	self placement: #'left-start'
]

{ #category : 'accessing placement' }
SlDropdown >> placementRight [

	self placement: #'right'
]

{ #category : 'accessing placement' }
SlDropdown >> placementRightEnd [

	self placement: #'right-end'
]

{ #category : 'accessing placement' }
SlDropdown >> placementRightStart [

	self placement: #'right-start'
]

{ #category : 'accessing placement' }
SlDropdown >> placementTop [

	self placement: #top
]

{ #category : 'accessing placement' }
SlDropdown >> placementTopEnd [

	self placement: #'top-end'
]

{ #category : 'accessing placement' }
SlDropdown >> placementTopStart [

	self placement: #'top-start'
]

{ #category : 'accessing' }
SlDropdown >> skidding [

	^ self propertyAt: #skidding
]

{ #category : 'accessing' }
SlDropdown >> skidding: aNumber [

	self propertyAt: #skidding put: aNumber
]

{ #category : 'accessing' }
SlDropdown >> stayOpenOnSelect: aBoolean [

	self propertyAt: #stayOpenOnSelect put: aBoolean
]
