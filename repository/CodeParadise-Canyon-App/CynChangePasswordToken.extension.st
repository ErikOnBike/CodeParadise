Extension { #name : #CynChangePasswordToken }

{ #category : #'*CodeParadise-Canyon-App' }
CynChangePasswordToken >> change [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynChangePasswordToken class >> uri [

	^ '/accounts?action=password-reset'
]
