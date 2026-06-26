Class {
	#name : #WaAccordionItem,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaAccordionItem >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaAccordionItem >> beExpanded [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self expanded: true
]

{ #category : #convenience }
WaAccordionItem >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #convenience }
WaAccordionItem >> beNotExpanded [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self expanded: false
]

{ #category : #actions }
WaAccordionItem >> collapse [

	"Collapses the accordion item with animation."

	^ self apply: #collapse
]

{ #category : #accessing }
WaAccordionItem >> disabled [

	"Disables the accordion item so it can't be toggled.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaAccordionItem >> disabled: aBoolean [

	"Disables the accordion item so it can't be toggled.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #actions }
WaAccordionItem >> expand [

	"Expands the accordion item with animation."

	^ self apply: #expand
]

{ #category : #accessing }
WaAccordionItem >> expanded [

	"Expands the accordion item.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #expanded
]

{ #category : #accessing }
WaAccordionItem >> expanded: aBoolean [

	"Expands the accordion item.
	
	Type: Boolean
	Default: false"

	self propertyAt: #expanded put: aBoolean
]

{ #category : #actions }
WaAccordionItem >> focus [

	"Focuses the accordion item's trigger button."

	^ self apply: #focus
]

{ #category : #actions }
WaAccordionItem >> focus: anObject [

	"Focuses the accordion item's trigger button.
	
	Parameter: options (FocusOptions)"

	^ self apply: #focus withArguments: { anObject }
]

{ #category : #accessing }
WaAccordionItem >> label [

	"The text label shown in the header. If you need HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaAccordionItem >> label: aString [

	"The text label shown in the header. If you need HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #actions }
WaAccordionItem >> toggle [

	"Toggles the accordion item's expanded state."

	^ self apply: #toggle
]
