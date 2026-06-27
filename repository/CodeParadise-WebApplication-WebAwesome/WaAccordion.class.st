Class {
	#name : #WaAccordion,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaAccordion >> appearance [

	"The accordion's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaAccordion >> appearance: aString [

	"The accordion's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaAccordion >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaAccordion >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #'accessing - convenience' }
WaAccordion >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaAccordion >> bePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #actions }
WaAccordion >> collapseAll [

	"Collapses all accordion items."

	^ self apply: #collapseAll
]

{ #category : #actions }
WaAccordion >> expandAll [

	"Expands all accordion items. No-op when `mode` is `single` or `single-collapsible`."

	^ self apply: #expandAll
]

{ #category : #accessing }
WaAccordion >> headingLevel [

	"The heading level for child item triggers (1–6), or ""none"" to omit the heading wrapper. Defaults to 3.
	
	Type: String
	Default: '3'"

	^ self propertyAt: #headingLevel
]

{ #category : #accessing }
WaAccordion >> headingLevel: aString [

	"The heading level for child item triggers (1–6), or ""none"" to omit the heading wrapper. Defaults to 3.
	
	Type: String
	Default: '3'"

	self propertyAt: #headingLevel put: aString
]

{ #category : #accessing }
WaAccordion >> iconPlacement [

	"The location of the expand/collapse icon in child items.
	
	Type: String
	Default: 'end'
	Allowed: 'start' | 'end'"

	^ self propertyAt: #iconPlacement
]

{ #category : #accessing }
WaAccordion >> iconPlacement: aString [

	"The location of the expand/collapse icon in child items.
	
	Type: String
	Default: 'end'
	Allowed: 'start' | 'end'"

	self propertyAt: #iconPlacement put: aString
]

{ #category : #accessing }
WaAccordion >> mode [

	"Controls how items can be expanded. `multiple` (the default) allows any number of items to be open at
	once. `single` allows only one item to be open at a time; opening a new item collapses the previously
	open one, and clicking an open item does not collapse it. `single-collapsible` is the same as `single`
	except that clicking the open item collapses it, so zero open items is a valid state.
	
	Type: String
	Default: 'multiple'
	Allowed: 'single' | 'single-collapsible' | 'multiple'"

	^ self propertyAt: #mode
]

{ #category : #accessing }
WaAccordion >> mode: aString [

	"Controls how items can be expanded. `multiple` (the default) allows any number of items to be open at
	once. `single` allows only one item to be open at a time; opening a new item collapses the previously
	open one, and clicking an open item does not collapse it. `single-collapsible` is the same as `single`
	except that clicking the open item collapses it, so zero open items is a valid state.
	
	Type: String
	Default: 'multiple'
	Allowed: 'single' | 'single-collapsible' | 'multiple'"

	self propertyAt: #mode put: aString
]
