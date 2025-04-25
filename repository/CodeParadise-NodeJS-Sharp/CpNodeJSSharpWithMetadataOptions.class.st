Class {
	#name : #CpNodeJSSharpWithMetadataOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpWithMetadataOptions >> orientation [

	"Used to update the EXIF Orientation tag, integer between 1 and 8.

	Type: Integer"

	^ options at: #orientation
]

{ #category : #accessing }
CpNodeJSSharpWithMetadataOptions >> orientation: anInteger [

	"Used to update the EXIF Orientation tag, integer between 1 and 8"

	options at: #orientation put: anInteger
]
