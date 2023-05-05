Extension { #name : #Fraction }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Fraction >> cpEncodeWith: anEncoder [

	"Currently the tiny image does not support Fractions, use a Float instead"

	<clientEnvironment>

	anEncoder encodeFloat: self asFloat
]
