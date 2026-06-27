Class {
	#name : #WaDrawer,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - convenience' }
WaDrawer >> beLightDismiss [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lightDismiss: true
]

{ #category : #'accessing - convenience' }
WaDrawer >> beNotLightDismiss [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self lightDismiss: false
]

{ #category : #'accessing - convenience' }
WaDrawer >> beNotOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: false
]

{ #category : #'accessing - convenience' }
WaDrawer >> beOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self open: true
]

{ #category : #'accessing - convenience' }
WaDrawer >> beWithFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: true
]

{ #category : #'accessing - convenience' }
WaDrawer >> beWithHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutHeader: false
]

{ #category : #'accessing - convenience' }
WaDrawer >> beWithoutFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: false
]

{ #category : #'accessing - convenience' }
WaDrawer >> beWithoutHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutHeader: true
]

{ #category : #accessing }
WaDrawer >> label [

	"The drawer's label as displayed in the header. You should always include a relevant label, as it is required for
	proper accessibility. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaDrawer >> label: aString [

	"The drawer's label as displayed in the header. You should always include a relevant label, as it is required for
	proper accessibility. If you need to display HTML, use the `label` slot instead.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaDrawer >> lightDismiss [

	"When enabled, the drawer will be closed when the user clicks outside of it.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #lightDismiss
]

{ #category : #accessing }
WaDrawer >> lightDismiss: aBoolean [

	"When enabled, the drawer will be closed when the user clicks outside of it.
	
	Type: Boolean
	Default: false"

	self propertyAt: #lightDismiss put: aBoolean
]

{ #category : #accessing }
WaDrawer >> modal [

	"Exposes the internal modal utility that controls focus trapping. To temporarily disable focus trapping and allow third-party modals spawned from an active Shoelace modal, call `modal.activateExternal()` when the third-party modal opens. Upon closing, call `modal.deactivateExternal()` to restore Shoelace's focus trapping.
	
	Type: Object"

	^ self propertyAt: #modal
]

{ #category : #accessing }
WaDrawer >> modal: anObject [

	"Exposes the internal modal utility that controls focus trapping. To temporarily disable focus trapping and allow third-party modals spawned from an active Shoelace modal, call `modal.activateExternal()` when the third-party modal opens. Upon closing, call `modal.deactivateExternal()` to restore Shoelace's focus trapping.
	
	Type: Object"

	self propertyAt: #modal put: anObject
]

{ #category : #accessing }
WaDrawer >> open [

	"Indicates whether or not the drawer is open. Toggle this attribute to show and hide the drawer.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #open
]

{ #category : #accessing }
WaDrawer >> open: aBoolean [

	"Indicates whether or not the drawer is open. Toggle this attribute to show and hide the drawer.
	
	Type: Boolean
	Default: false"

	self propertyAt: #open put: aBoolean
]

{ #category : #accessing }
WaDrawer >> placement [

	"The direction from which the drawer will open.
	
	Type: String
	Default: 'end'
	Allowed: 'top' | 'end' | 'bottom' | 'start'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaDrawer >> placement: aString [

	"The direction from which the drawer will open.
	
	Type: String
	Default: 'end'
	Allowed: 'top' | 'end' | 'bottom' | 'start'"

	self propertyAt: #placement put: aString
]

{ #category : #accessing }
WaDrawer >> withFooter [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withFooter
]

{ #category : #accessing }
WaDrawer >> withFooter: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withFooter put: aBoolean
]

{ #category : #accessing }
WaDrawer >> withoutHeader [

	"Disables the header. This will also remove the default close button.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutHeader
]

{ #category : #accessing }
WaDrawer >> withoutHeader: aBoolean [

	"Disables the header. This will also remove the default close button.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutHeader put: aBoolean
]
