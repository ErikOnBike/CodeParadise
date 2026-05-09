Extension { #name : #OrderedDictionary }

{ #category : #'*CodeParadise-RemoteEnvironment' }
OrderedDictionary >> asCpEncodedArray [

	^ self associations
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
OrderedDictionary >> asDictionary [

	"Answer the receiver as a Dictionary.

	Implementation:
	Since I am a Dictionary, answer myself."

	<applicationExtension>

	^ self
]
