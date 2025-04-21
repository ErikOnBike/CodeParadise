Extension { #name : #CpCanyonActivateAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonActivateAccount >> activate [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CpCanyonActivateAccount class >> uri [

	^ '/accounts?action=activate'
]
