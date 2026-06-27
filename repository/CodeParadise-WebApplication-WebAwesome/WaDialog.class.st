Class {
	#name : #WaDialog,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaDialog >> beLightDismiss [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lightDismiss: true
]

{ #category : #'accessing - convenience' }
WaDialog >> beNotLightDismiss [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lightDismiss: false
]

{ #category : #'accessing - convenience' }
WaDialog >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaDialog >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaDialog >> beWithFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: true
]

{ #category : #'accessing - convenience' }
WaDialog >> beWithHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutHeader: false
]

{ #category : #'accessing - convenience' }
WaDialog >> beWithoutFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: false
]

{ #category : #'accessing - convenience' }
WaDialog >> beWithoutHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutHeader: true
]

{ #category : #'accessing - slots' }
WaDialog >> footerElement [

	"The dialog's footer, usually one or more buttons representing various options."

	^ self firstChildAtSlotNamed: #footer
]

{ #category : #'accessing - slots' }
WaDialog >> footerElement: anElement [

	"The dialog's footer, usually one or more buttons representing various options."

	self replaceAllChildrenWith: anElement atSlotNamed: #footer
]

{ #category : #'accessing - slots' }
WaDialog >> headerActionsElement [

	"Optional actions to add to the header. Works best with `<wa-button>`."

	^ self firstChildAtSlotNamed: #'header-actions'
]

{ #category : #'accessing - slots' }
WaDialog >> headerActionsElement: anElement [

	"Optional actions to add to the header. Works best with `<wa-button>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'header-actions'
]

{ #category : #accessing }
WaDialog >> label [

	"The dialog's label as displayed in the header. You should always include a relevant label, as it is required for
	proper accessibility. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaDialog >> label: aString [

	"The dialog's label as displayed in the header. You should always include a relevant label, as it is required for
	proper accessibility. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaDialog >> labelElement [

	"The dialog's label. Alternatively, you can use the `label` attribute."

	^ self firstChildAtSlotNamed: #label
]

{ #category : #'accessing - slots' }
WaDialog >> labelElement: anElement [

	"The dialog's label. Alternatively, you can use the `label` attribute."

	self replaceAllChildrenWith: anElement atSlotNamed: #label
]

{ #category : #accessing }
WaDialog >> lightDismiss [

	"When enabled, the dialog will be closed when the user clicks outside of it.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #lightDismiss
]

{ #category : #accessing }
WaDialog >> lightDismiss: aBoolean [

	"When enabled, the dialog will be closed when the user clicks outside of it.
	
	Type: Boolean
	Default: false"

	self propertyAt: #lightDismiss put: aBoolean
]

{ #category : #accessing }
WaDialog >> open [

	"Indicates whether or not the dialog is open. Toggle this attribute to show and hide the dialog.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaDialog >> open: aBoolean [

	"Indicates whether or not the dialog is open. Toggle this attribute to show and hide the dialog.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaDialog >> withFooter [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withFooter
]

{ #category : #accessing }
WaDialog >> withFooter: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withFooter put: aBoolean
]

{ #category : #accessing }
WaDialog >> withoutHeader [

	"Disables the header. This will also remove the default close button.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutHeader
]

{ #category : #accessing }
WaDialog >> withoutHeader: aBoolean [

	"Disables the header. This will also remove the default close button.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutHeader put: aBoolean
]
