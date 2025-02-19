Extension { #name : #Process }

{ #category : #'*CodeParadise-JavaScript' }
Process >> allowAwaitPromise [

	"Answer whether the receiver allows awaiting"

	<applicationExtension>

	<primitive: 'primitiveProcessAllowAwaitPromise' module: 'CpSystemPlugin'>
	self primitiveFailed
]
