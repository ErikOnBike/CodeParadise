Extension { #name : #CynActivateAccountToken }

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccountToken >> activate [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccountToken class >> uri [

	^ '/accounts?action=activate'
]
