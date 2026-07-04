Class {
	#name : #WaSkeleton,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaSkeleton >> effect [

	"Determines which effect the skeleton will use.
	
	Type: String
	Default: 'none'
	Allowed: 'pulse' | 'sheen' | 'none'"

	^ self propertyAt: #effect
]

{ #category : #accessing }
WaSkeleton >> effect: aString [

	"Determines which effect the skeleton will use.
	
	Type: String
	Default: 'none'
	Allowed: 'pulse' | 'sheen' | 'none'"

	self propertyAt: #effect put: aString
]
