Extension { #name : 'CompiledMethod' }

{ #category : '*CodeParadise-WebApplication' }
CompiledMethod >> sendsOrRefersTo: aSelector [

	self flag: #todo.	"This is non optimized code, see Behavior>>#thoroughWhichMethodsReferTo:"

	^ self hasSelector: aSelector specialSelectorIndex: 	(Smalltalk specialSelectorIndexOrNil: aSelector)
]
