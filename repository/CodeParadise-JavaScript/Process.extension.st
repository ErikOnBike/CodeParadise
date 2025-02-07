Extension { #name : #Process }

{ #category : #'*CodeParadise-JavaScript' }
Process >> allowAwaitPromise [

	"Answer whether the receiver allows awaiting"

	<applicationExtension>

	<primitive: 'primitiveProcessAllowAwaitPromise' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #'*CodeParadise-JavaScript' }
Process >> isSyncProcess [

	"Answer a Boolean whether the receiver is a synchronous Process.
	(Smalltalk) Blocks being used as (JavaScript) Functions are executed in a
	synchronous Process (prevent synchronous JavaScript Function to become
	async because of Process switching).
	Also CpEvent and CpTransition (for use with Browser DOM) are running in a
	synchronous Process."

	<applicationExtension>

	<primitive: 'primitiveProcessIsSyncProcess' module: 'CpSystemPlugin'>
]
