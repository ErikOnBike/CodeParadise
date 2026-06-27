Class {
	#name : #WaTabGroup,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTabGroup >> activation [

	"When set to auto, navigating tabs with the arrow keys will instantly show the corresponding tab panel. When set to
	manual, the tab will receive focus but will not show until the user presses spacebar or enter.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | 'manual'"

	^ self propertyAt: #activation
]

{ #category : #accessing }
WaTabGroup >> activation: aString [

	"When set to auto, navigating tabs with the arrow keys will instantly show the corresponding tab panel. When set to
	manual, the tab will receive focus but will not show until the user presses spacebar or enter.
	
	Type: String
	Default: 'auto'
	Allowed: 'auto' | 'manual'"

	self propertyAt: #activation put: aString
]

{ #category : #accessing }
WaTabGroup >> active [

	"Sets the active tab.
	
	Type: String
	Default: ''"

	^ self propertyAt: #active
]

{ #category : #accessing }
WaTabGroup >> active: aString [

	"Sets the active tab.
	
	Type: String
	Default: ''"

	self propertyAt: #active put: aString
]

{ #category : #'accessing - convenience' }
WaTabGroup >> beWithScrollControls [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutScrollControls: false
]

{ #category : #'accessing - convenience' }
WaTabGroup >> beWithoutScrollControls [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutScrollControls: true
]

{ #category : #accessing }
WaTabGroup >> defaultSlot [

	"Default slot for `<wa-tab-panel>` children (inside the `body` part container).
	
	Type: HtmlElement (HTMLSlotElement)"

	^ self propertyAt: #defaultSlot
]

{ #category : #accessing }
WaTabGroup >> defaultSlot: anHtmlElement [

	"Default slot for `<wa-tab-panel>` children (inside the `body` part container).
	
	Type: HtmlElement (HTMLSlotElement)"

	self propertyAt: #defaultSlot put: anHtmlElement
]

{ #category : #accessing }
WaTabGroup >> placement [

	"The placement of the tabs.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'bottom' | 'start' | 'end'"

	^ self propertyAt: #placement
]

{ #category : #accessing }
WaTabGroup >> placement: aString [

	"The placement of the tabs.
	
	Type: String
	Default: 'top'
	Allowed: 'top' | 'bottom' | 'start' | 'end'"

	self propertyAt: #placement put: aString
]

{ #category : #accessing }
WaTabGroup >> withoutScrollControls [

	"Disables the scroll arrows that appear when tabs overflow.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutScrollControls
]

{ #category : #accessing }
WaTabGroup >> withoutScrollControls: aBoolean [

	"Disables the scroll arrows that appear when tabs overflow.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutScrollControls put: aBoolean
]
