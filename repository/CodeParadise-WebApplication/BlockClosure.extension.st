Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> asTransition [

	<webApplicationExtension>

	^ (Smalltalk classNamed: #CpTransition) onBlock: self
]
