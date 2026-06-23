Extension { #name : #Object }

{ #category : #'*CodeParadise-WebApplication-MVP' }
Object >> asParameterDictionary [

	"Answer a parameter dictionary with single pair '1 -> self'"

	<webApplicationExtension>

	^ (Dictionary new: 1)
		at: 1 put: self ;
		yourself
]

{ #category : #'*CodeParadise-WebApplication-MVP' }
Object >> propertySlot: aSlot valueChangedFrom: oldValue to: newValue [

	"The specified PropertySlot's value changed.
	It is a subclass' responsibility to inform any interested parties/dependents of this fact."
]
