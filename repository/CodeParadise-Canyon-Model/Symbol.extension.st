Extension { #name : #Symbol }

{ #category : #'*CodeParadise-Canyon-Model' }
Symbol >> asTextReference [

	"Answer a ParamText instance for the receiver"

	<canyonModelExtension>

	^ CynTextReference key: self format: Dictionary new
]

{ #category : #'*CodeParadise-Canyon-Model' }
Symbol >> textKey [

	"Answer the receiver's key.
	This method is to allow for a single access protocol for both the receiver class and Symbol."

	<canyonModelExtension>

	^ self
]
