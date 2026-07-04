Class {
	#name : #WaFormatBytes,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaFormatBytes >> display [

	"Determines how to display the result, e.g. ""100 bytes"", ""100 b"", or ""100b"".
	
	Type: String
	Default: 'short'
	Allowed: 'long' | 'short' | 'narrow'"

	^ self propertyAt: #display
]

{ #category : #accessing }
WaFormatBytes >> display: aString [

	"Determines how to display the result, e.g. ""100 bytes"", ""100 b"", or ""100b"".
	
	Type: String
	Default: 'short'
	Allowed: 'long' | 'short' | 'narrow'"

	self propertyAt: #display put: aString
]

{ #category : #accessing }
WaFormatBytes >> unit [

	"The type of unit to display.
	
	Type: String
	Default: 'byte'
	Allowed: 'byte' | 'bit'"

	^ self propertyAt: #unit
]

{ #category : #accessing }
WaFormatBytes >> unit: aString [

	"The type of unit to display.
	
	Type: String
	Default: 'byte'
	Allowed: 'byte' | 'bit'"

	self propertyAt: #unit put: aString
]

{ #category : #accessing }
WaFormatBytes >> value [

	"The number to format in bytes.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #value
]

{ #category : #accessing }
WaFormatBytes >> value: aNumber [

	"The number to format in bytes.
	
	Type: Number
	Default: 0"

	self propertyAt: #value put: aNumber
]
