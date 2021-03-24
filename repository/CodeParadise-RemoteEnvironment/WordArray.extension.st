Extension { #name : #WordArray }

{ #category : #'*CodeParadise-RemoteEnvironment' }
WordArray >> asString [

	"Convert to a String with Characters for each word (Unicode value)"

	^ (WideString new: self size) replaceFrom: 1 to: self size with: self
]
