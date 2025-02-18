Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> asTransition [

	<webApplicationExtension>

	^ (Smalltalk classNamed: #CpTransition) onBlock: self
]

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> forked [

	"Answer a forked version of the receiver"

	<webApplicationExtension>

	^ [ self fork ]
]
