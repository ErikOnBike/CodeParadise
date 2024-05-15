Extension { #name : 'Object' }

{ #category : '*CodeParadise-WebApplication-MVP' }
Object >> asParameterDictionary [

	"Answer a parameter dictionary with single pair '1 -> self'"

	<webApplicationExtension>

	^ (Dictionary new: 1)
		at: 1 put: self ;
		yourself
]
