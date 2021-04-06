Class {
	#name : #SlTooltip,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

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

	^ self attributeAt: #content
]

{ #category : #accessing }
SlTooltip >> contentText: aString [

	self attributeAt: #content put: aString
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

{ #category : #'accessing placement' }
SlTooltip >> placement [

	^ self attributeAt: #placement
]

{ #category : #'accessing placement' }
SlTooltip >> placement: aString [

	self attributeAt: #placement put: aString
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

{ #category : #'accessing trigger' }
SlTooltip >> trigger [

	^ self attributeAt: #trigger
]

{ #category : #'accessing trigger' }
SlTooltip >> trigger: aString [

	self attributeAt: #trigger put: aString
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerClick [

	self trigger: #click
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerHover [

	self trigger: nil
]

{ #category : #'accessing trigger' }
SlTooltip >> triggerManual [

	self trigger: #manual
]
