Class {
	#name : #SlTreeItem,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlTreeItem >> beDisabled [

	self disabled: true
]

{ #category : #accessing }
SlTreeItem >> beEnabled [

	"Convenience method to make receiver enabled"

	self disabled: false
]

{ #category : #accessing }
SlTreeItem >> beExpanded [

	self expanded: true
]

{ #category : #accessing }
SlTreeItem >> beLazy [

	self lazy: true
]

{ #category : #accessing }
SlTreeItem >> beNotDisabled [

	self disabled: false
]

{ #category : #accessing }
SlTreeItem >> beNotEnabled [

	"Convenience method to clear the enabled state of the receiver"

	self disabled: true
]

{ #category : #accessing }
SlTreeItem >> beNotExpanded [

	self expanded: false
]

{ #category : #accessing }
SlTreeItem >> beNotLazy [

	self lazy: false
]

{ #category : #accessing }
SlTreeItem >> beNotSelected [

	self selected: false
]

{ #category : #accessing }
SlTreeItem >> beSelected [

	self selected: true
]

{ #category : #accessing }
SlTreeItem >> disabled: aBoolean [

	"Disables the tree item."

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
SlTreeItem >> enabled: aBoolean [

	"Convenience method to set receiver's enabled state"

	self disabled: aBoolean not
]

{ #category : #accessing }
SlTreeItem >> expanded: aBoolean [

	"Expands the tree item."

	self propertyAt: #expanded put: aBoolean
]

{ #category : #accessing }
SlTreeItem >> isDisabled [

	^ self propertyAt: #disabled
]

{ #category : #accessing }
SlTreeItem >> isEnabled [

	"Convenience method to test if receiver is enabled"

	^ self isDisabled not
]

{ #category : #accessing }
SlTreeItem >> isExpanded [

	^ self propertyAt: #expanded
]

{ #category : #accessing }
SlTreeItem >> isLazy [

	^ self propertyAt: #lazy
]

{ #category : #accessing }
SlTreeItem >> isSelected [

	^ self propertyAt: #selected
]

{ #category : #accessing }
SlTreeItem >> lazy: aBoolean [

	"Enables lazy loading behavior."

	self propertyAt: #lazy put: aBoolean
]

{ #category : #accessing }
SlTreeItem >> selected: aBoolean [

	"Draws the tree item in a selected state."

	self propertyAt: #selected put: aBoolean
]
