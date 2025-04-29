"
I am a simple Acount model to use with email/password credentials.
My name is prefixed with Canyon to prevent name clashes with other classes.

My subclasses represent different states in the Account model. These are:
	Register - for registering an account (account still needs activiation)
	Activate - for activating an account
	Login - for logging in into an account
	PasswordForgotten - for mailing a 'password reset' message to the account

"
Class {
	#name : #CynAccount,
	#superclass : #CynPropertyEntity,
	#instVars : [
		'#task => CpPropertySlot',
		'#email => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #email addConstraint: CynEmailPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #accessing }
CynAccount >> email [

	^ email
]

{ #category : #accessing }
CynAccount >> email: aString [

	email := aString
]
