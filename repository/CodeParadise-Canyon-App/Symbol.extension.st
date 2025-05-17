Extension { #name : #Symbol }

{ #category : #'*CodeParadise-Canyon-App' }
Symbol >> langText [

	"Answer the language specific text for the receiver"

	^ CynPropertyEntity text: self
]
