Extension { #name : #String }

{ #category : #'*CodeParadise-WebApplication-MVP' }
String >> asParameterDictionary [

	"Answer a parameter dictionary with single pair '1 -> self'"

	<webApplicationExtension>

	^ (Dictionary new: 1)
		at: 1 put: self ;
		yourself
]
