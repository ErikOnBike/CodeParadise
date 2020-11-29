Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-WebApplication' }
BlockClosure >> asTransition [

	<webApplicationExtension>

	^ CpTransition onBlock: self
]
