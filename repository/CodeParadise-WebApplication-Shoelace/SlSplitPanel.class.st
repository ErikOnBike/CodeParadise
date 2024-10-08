Class {
	#name : #SlSplitPanel,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlSplitPanel >> beDisabled [

	self disabled: true
]

{ #category : #'accessing style' }
SlSplitPanel >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #'accessing style' }
SlSplitPanel >> beNotDisabled [

	self disabled: false
]

{ #category : #'accessing style' }
SlSplitPanel >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #'accessing style' }
SlSplitPanel >> beNotVertical [

	self vertical: false
]

{ #category : #'accessing style' }
SlSplitPanel >> beVertical [

	self vertical: true
]

{ #category : #accessing }
SlSplitPanel >> disabled: aBoolean [

	"Disables resizing. Note that the position may still change as a result of resizing the host element."

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlSplitPanel >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #accessing }
SlSplitPanel >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlSplitPanel >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #'accessing style' }
SlSplitPanel >> isVertical [

	^ self propertyAt: #vertical
]

{ #category : #accessing }
SlSplitPanel >> position [

	^ self propertyAt: #position
]

{ #category : #accessing }
SlSplitPanel >> position: aNumber [

	"The current position of the divider from the primary panel’s edge as a percentage 0–100. Defaults to 50% of the container’s initial size."

	self propertyAt: #position put: aNumber
]

{ #category : #accessing }
SlSplitPanel >> snap [

	^ self propertyAt: #snap
]

{ #category : #accessing }
SlSplitPanel >> snap: aString [

	"One or more space-separated values at which the divider should snap. Values can be in pixels or percentages, e.g. '100px 50%'."

	self propertyAt: #snap put: aString
]

{ #category : #accessing }
SlSplitPanel >> snapThreshold [

	^ self propertyAt: #snapThreshold
]

{ #category : #accessing }
SlSplitPanel >> snapThreshold: aNumber [

	"How close the divider must be to a snap point until snapping occurs."

	self propertyAt: #snapThreshold put: aNumber
]

{ #category : #'accessing style' }
SlSplitPanel >> vertical: aBoolean [

	"Draws the split panel in a vertical orientation with the start and end panels stacked."

	self propertyAt: #vertical put: aBoolean
]
