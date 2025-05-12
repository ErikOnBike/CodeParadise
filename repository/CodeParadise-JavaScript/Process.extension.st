Extension { #name : #Process }

{ #category : #'*CodeParadise-JavaScript' }
Process >> allowAwaitPromise [

	"Answer whether the receiver allows awaiting (internal for CodeParadise)"

	<clientEnvironment>

	<primitive: 'primitiveProcessAllowAwaitPromise' module: 'CpSystemPlugin'>
	self primitiveFailed
]
