Class {
	#name : #WaDetails,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaDetails >> appearance [

	"The element's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaDetails >> appearance: aString [

	"The element's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaDetails >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaDetails >> appearanceFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaDetails >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaDetails >> appearancePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #'accessing - convenience' }
WaDetails >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaDetails >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaDetails >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaDetails >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - slots' }
WaDetails >> collapseIconElement [

	"Optional collapse icon to use instead of the default. Works best with `<wa-icon>`."

	^ self firstChildAtSlotNamed: #'collapse-icon'
]

{ #category : #'accessing - slots' }
WaDetails >> collapseIconElement: anElement [

	"Optional collapse icon to use instead of the default. Works best with `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'collapse-icon'
]

{ #category : #accessing }
WaDetails >> disabled [

	"Disables the details so it can't be toggled.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaDetails >> disabled: aBoolean [

	"Disables the details so it can't be toggled.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #'accessing - slots' }
WaDetails >> expandIconElement [

	"Optional expand icon to use instead of the default. Works best with `<wa-icon>`."

	^ self firstChildAtSlotNamed: #'expand-icon'
]

{ #category : #'accessing - slots' }
WaDetails >> expandIconElement: anElement [

	"Optional expand icon to use instead of the default. Works best with `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'expand-icon'
]

{ #category : #actions }
WaDetails >> hide [

	"Hides the details"

	^ self apply: #hide
]

{ #category : #accessing }
WaDetails >> iconPlacement [

	"The location of the expand/collapse icon.
	
	Type: String
	Default: 'end'
	Allowed: 'start' | 'end'"

	^ self propertyAt: #iconPlacement
]

{ #category : #accessing }
WaDetails >> iconPlacement: aString [

	"The location of the expand/collapse icon.
	
	Type: String
	Default: 'end'
	Allowed: 'start' | 'end'"

	self propertyAt: #iconPlacement put: aString
]

{ #category : #accessing }
WaDetails >> name [

	"Groups related details elements. When one opens, others with the same name will close.
	
	Type: String"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaDetails >> name: aString [

	"Groups related details elements. When one opens, others with the same name will close.
	
	Type: String"

	self propertyAt: #name put: aString
]

{ #category : #accessing }
WaDetails >> open [

	"Indicates whether or not the details is open. You can toggle this attribute to show and hide the details, or you
	can use the `show()` and `hide()` methods and this attribute will reflect the details' open state.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaDetails >> open: aBoolean [

	"Indicates whether or not the details is open. You can toggle this attribute to show and hide the details, or you
	can use the `show()` and `hide()` methods and this attribute will reflect the details' open state.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #actions }
WaDetails >> show [

	"Shows the details."

	^ self apply: #show
]

{ #category : #accessing }
WaDetails >> summary [

	"The summary to show in the header. If you need to display HTML, use the `summary` slot instead.
	
	Type: String"

	^ self propertyAt: #summary
]

{ #category : #accessing }
WaDetails >> summary: aString [

	"The summary to show in the header. If you need to display HTML, use the `summary` slot instead.
	
	Type: String"

	self propertyAt: #summary put: aString
]

{ #category : #'accessing - slots' }
WaDetails >> summaryElement [

	"The details' summary. Alternatively, you can use the `summary` attribute."

	^ self firstChildAtSlotNamed: #summary
]

{ #category : #'accessing - slots' }
WaDetails >> summaryElement: anElement [

	"The details' summary. Alternatively, you can use the `summary` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #summary
]
