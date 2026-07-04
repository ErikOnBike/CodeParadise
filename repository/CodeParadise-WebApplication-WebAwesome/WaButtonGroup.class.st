Class {
	#name : #WaButtonGroup,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaButtonGroup >> label [

	"A label to use for the button group. This won't be displayed on the screen, but it will be announced by assistive
	devices when interacting with the control and is strongly recommended.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaButtonGroup >> label: aString [

	"A label to use for the button group. This won't be displayed on the screen, but it will be announced by assistive
	devices when interacting with the control and is strongly recommended.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #accessing }
WaButtonGroup >> orientation [

	"The button group's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaButtonGroup >> orientation: aString [

	"The button group's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]
