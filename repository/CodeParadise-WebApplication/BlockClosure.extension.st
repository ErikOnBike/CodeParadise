Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> asTransition [

	<webApplicationExtension>
	<ignoreReference: #CpTransition>

	^ CpTransition onBlock: self
]

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> forked [

	"Answer a forked version of the receiver.
	I am only needed to allow awaiting Promises in an event handler.
	Please read the class comment for CpForkedMessage for more details."

	<webApplicationExtension>

	^ [ :event |
		numArgs = 0
			ifTrue: [ self fork ]
			ifFalse: [
				| copyEvent |

				"Because events change while bubbling, create a (stopped) copy"
				copyEvent := event copy.
				[ self value: copyEvent ] fork ] ]
]
