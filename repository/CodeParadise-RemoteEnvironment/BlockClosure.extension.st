Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-RemoteEnvironment' }
BlockClosure >> asJavaScriptFunction [

	<applicationExtension>

	^ CpJavaScriptFunction wrap: self
]
