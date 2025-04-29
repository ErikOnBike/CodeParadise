Extension { #name : #CynActivateAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccount >> activate [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccount class >> uri [

	^ '/accounts?action=activate'
]
