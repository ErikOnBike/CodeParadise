Extension { #name : #UndefinedObject }

{ #category : #'*CodeParadise-WebApplication-MVP' }
UndefinedObject class >> asParameterDictionary [

	"Ignore this conversion and simply answer myself as specific
	placeholder value to indicate no parameters are needed"

	<webApplicationExtension>

	^ self
]
