Class {
	#name : #WaTabPanel,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaTabPanel >> active [

	"When true, the tab panel will be shown.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #active
]

{ #category : #accessing }
WaTabPanel >> active: aBoolean [

	"When true, the tab panel will be shown.
	
	Type: Boolean
	Default: false"

	self propertyAt: #active put: aBoolean
]

{ #category : #convenience }
WaTabPanel >> beActive [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self active: true
]

{ #category : #convenience }
WaTabPanel >> beNotActive [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self active: false
]

{ #category : #accessing }
WaTabPanel >> name [

	"The tab panel's name.
	
	Type: String
	Default: ''"

	^ self propertyAt: #name
]

{ #category : #accessing }
WaTabPanel >> name: aString [

	"The tab panel's name.
	
	Type: String
	Default: ''"

	self propertyAt: #name put: aString
]
