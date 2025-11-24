Extension { #name : #CynActivateAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccount >> activate [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynActivateAccount classSide >> uri [

	^ '/accounts?action=activate'
]
