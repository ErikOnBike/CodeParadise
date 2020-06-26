Extension { #name : #Array }

{ #category : #'*WebApplication' }
Array >> asSlotCollection [

	"Answer a new Collection with the receiver's elements as Slots"

	<clientEnvironment>

	^ self collect: [ :each | each asSlot ]
]

{ #category : #'*WebApplication' }
Array >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeArray: self
]
