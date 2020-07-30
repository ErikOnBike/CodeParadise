Extension { #name : #Array }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Array >> asSlotCollection [

	"Answer a new Collection with the receiver's elements as Slots"

	<clientEnvironment>

	^ self collect: [ :each | each asSlot ]
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Array >> cpEncodeWith: anEncoder [

	<clientEnvironment>

	anEncoder encodeArray: self
]
