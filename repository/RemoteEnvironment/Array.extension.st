Extension { #name : #Array }

{ #category : #'*RemoteEnvironment' }
Array >> asSlotCollection [

	"Answer a new Collection with the receiver's elements as Slots"

	<clientEnvironment>

	^ self collect: [ :each | each asSlot ]
]

{ #category : #'*RemoteEnvironment' }
Array >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeArray: self
]
