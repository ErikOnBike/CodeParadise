Class {
	#name : #WaTreeItem,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaTreeItem >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaTreeItem >> beExpanded [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self expanded: true
]

{ #category : #convenience }
WaTreeItem >> beLazy [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lazy: true
]

{ #category : #convenience }
WaTreeItem >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaTreeItem >> beNotExpanded [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self expanded: false
]

{ #category : #convenience }
WaTreeItem >> beNotLazy [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lazy: false
]

{ #category : #convenience }
WaTreeItem >> beNotSelected [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self selected: false
]

{ #category : #convenience }
WaTreeItem >> beSelected [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self selected: true
]

{ #category : #accessing }
WaTreeItem >> disabled [

	"Disables the tree item.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaTreeItem >> disabled: aBoolean [

	"Disables the tree item.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaTreeItem >> expanded [

	"Expands the tree item.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #expanded
]

{ #category : #accessing }
WaTreeItem >> expanded: aBoolean [

	"Expands the tree item.
	
	Type: Boolean
	Default: false"

	self propertyAt: #expanded put: aBoolean
]

{ #category : #actions }
WaTreeItem >> getChildrenItems [

	"Gets all the nested tree items in this node.
	
	Return type: WaTreeItem[]"

	^ self apply: #getChildrenItems
]

{ #category : #actions }
WaTreeItem >> getChildrenItems: anObject [

	"Gets all the nested tree items in this node.
	
	Return type: WaTreeItem[]
	Parameter: param1 (object)"

	^ self apply: #getChildrenItems withArguments: { anObject }
]

{ #category : #accessing }
WaTreeItem >> lazy [

	"Enables lazy loading behavior.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #lazy
]

{ #category : #accessing }
WaTreeItem >> lazy: aBoolean [

	"Enables lazy loading behavior.
	
	Type: Boolean
	Default: false"

	self propertyAt: #lazy put: aBoolean
]

{ #category : #accessing }
WaTreeItem >> selected [

	"Draws the tree item in a selected state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #selected
]

{ #category : #accessing }
WaTreeItem >> selected: aBoolean [

	"Draws the tree item in a selected state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #selected put: aBoolean
]
