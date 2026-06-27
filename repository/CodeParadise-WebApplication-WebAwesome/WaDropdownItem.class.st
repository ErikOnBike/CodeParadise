Class {
	#name : #WaDropdownItem,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaDropdownItem >> beChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: true
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beDanger [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #danger
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beDefault [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self variant: #default
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beNotChecked [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self checked: false
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beNotSubmenuOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self submenuOpen: false
]

{ #category : #'accessing - convenience' }
WaDropdownItem >> beSubmenuOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self submenuOpen: true
]

{ #category : #accessing }
WaDropdownItem >> checked [

	"Set to true to check the dropdown item. Only valid when `type` is `checkbox`.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #checked
]

{ #category : #accessing }
WaDropdownItem >> checked: aBoolean [

	"Set to true to check the dropdown item. Only valid when `type` is `checkbox`.
	
	Type: Boolean
	Default: false"

	self propertyAt: #checked put: aBoolean
]

{ #category : #actions }
WaDropdownItem >> closeSubmenu [

	"Closes the submenu."

	^ self apply: #closeSubmenu
]

{ #category : #'accessing - slots' }
WaDropdownItem >> detailsElement [

	"Additional content or details to display after the label."

	^ self firstChildAtSlotNamed: #details
]

{ #category : #'accessing - slots' }
WaDropdownItem >> detailsElement: anElement [

	"Additional content or details to display after the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #details
]

{ #category : #accessing }
WaDropdownItem >> disabled [

	"Disables the dropdown item.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaDropdownItem >> disabled: aBoolean [

	"Disables the dropdown item.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #'accessing - slots' }
WaDropdownItem >> iconElement [

	"An optional icon to display before the label."

	^ self firstChildAtSlotNamed: #icon
]

{ #category : #'accessing - slots' }
WaDropdownItem >> iconElement: anElement [

	"An optional icon to display before the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #icon
]

{ #category : #actions }
WaDropdownItem >> openSubmenu [

	"Opens the submenu."

	^ self apply: #openSubmenu
]

{ #category : #'accessing - slots' }
WaDropdownItem >> submenuElement [

	"Submenu items, typically `<wa-dropdown-item>` elements, to create a nested menu."

	^ self firstChildAtSlotNamed: #submenu
]

{ #category : #'accessing - slots' }
WaDropdownItem >> submenuElement: anElement [

	"Submenu items, typically `<wa-dropdown-item>` elements, to create a nested menu."

	self replaceAllChildrenWith: anElement atSlotNamed: #submenu
]

{ #category : #accessing }
WaDropdownItem >> submenuOpen [

	"Whether the submenu is currently open.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #submenuOpen
]

{ #category : #accessing }
WaDropdownItem >> submenuOpen: aBoolean [

	"Whether the submenu is currently open.
	
	Type: Boolean
	Default: false"

	self propertyAt: #submenuOpen put: aBoolean
]

{ #category : #accessing }
WaDropdownItem >> type [

	"Set to `checkbox` to make the item a checkbox.
	
	Type: String
	Default: 'normal'
	Allowed: 'normal' | 'checkbox'"

	^ self propertyAt: #type
]

{ #category : #accessing }
WaDropdownItem >> type: aString [

	"Set to `checkbox` to make the item a checkbox.
	
	Type: String
	Default: 'normal'
	Allowed: 'normal' | 'checkbox'"

	self propertyAt: #type put: aString
]

{ #category : #accessing }
WaDropdownItem >> value [

	"An optional value for the menu item. This is useful for determining which item was selected when listening to the
	dropdown's `wa-select` event.
	
	Type: String"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaDropdownItem >> value: aString [

	"An optional value for the menu item. This is useful for determining which item was selected when listening to the
	dropdown's `wa-select` event.
	
	Type: String"

	self propertyAt: #value put: aString
]

{ #category : #accessing }
WaDropdownItem >> variant [

	"The type of menu item to render.
	
	Type: String
	Default: 'default'
	Allowed: 'danger' | 'default'"

	^ self propertyAt: #variant
]

{ #category : #accessing }
WaDropdownItem >> variant: aString [

	"The type of menu item to render.
	
	Type: String
	Default: 'default'
	Allowed: 'danger' | 'default'"

	self propertyAt: #variant put: aString
]
