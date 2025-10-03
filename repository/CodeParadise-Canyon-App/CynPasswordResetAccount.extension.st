Extension { #name : #CynPasswordResetAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CynPasswordResetAccount >> reset [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPasswordResetAccount class >> uri [

	^ '/accounts?action=password-reset'
]
