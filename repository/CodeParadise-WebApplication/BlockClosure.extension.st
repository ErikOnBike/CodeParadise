Extension { #name : 'BlockClosure' }

{ #category : '*CodeParadise-WebApplication' }
BlockClosure >> asTransition [

	<webApplicationExtension>

	^ (Smalltalk at: #CpTransition) onBlock: self
]
