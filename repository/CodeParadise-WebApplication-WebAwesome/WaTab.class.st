Class {
	#name : #WaTab,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaTab >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #convenience }
WaTab >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #accessing }
WaTab >> disabled [

	"Disables the tab and prevents selection.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaTab >> disabled: aBoolean [

	"Disables the tab and prevents selection.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #accessing }
WaTab >> panel [

	"The name of the tab panel this tab is associated with. The panel must be located in the same tab group.
	
	Type: String
	Default: ''"

	^ self propertyAt: #panel
]

{ #category : #accessing }
WaTab >> panel: aString [

	"The name of the tab panel this tab is associated with. The panel must be located in the same tab group.
	
	Type: String
	Default: ''"

	self propertyAt: #panel put: aString
]
