Extension { #name : #CynPasswordForgottenAccount }

{ #category : #'*CodeParadise-Canyon-App' }
CynPasswordForgottenAccount >> sendPasswordResetMail [

	self restWrite
]

{ #category : #'*CodeParadise-Canyon-App' }
CynPasswordForgottenAccount class >> uri [

	^ '/accounts?action=password-forgotten'
]
