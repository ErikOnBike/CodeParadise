Class {
	#name : #WaDivider,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaDivider >> orientation [

	"Sets the divider's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaDivider >> orientation: aString [

	"Sets the divider's orientation.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]
